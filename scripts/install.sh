#!/bin/sh
# Installs the halleyfy CLI from npm's registry into ~/.local/bin (or $HALLEYFY_INSTALL_DIR).
# Usage: sh install.sh [--no-skills] [--version <v>]
set -eu

fail() {
  printf '%s\n' "$*" >&2
  exit 1
}

skills=1
version=latest
while [ $# -gt 0 ]; do
  case "$1" in
    --no-skills) skills=0 ;;
    --version)
      [ $# -ge 2 ] || fail "--version needs a value."
      version=$2
      shift
      ;;
    --version=*) version=${1#--version=} ;;
    *) fail "Unknown option: $1" ;;
  esac
  shift
done

registry=${HALLEYFY_NPM_REGISTRY:-https://registry.npmjs.org}
registry=${registry%/}
dir=${HALLEYFY_INSTALL_DIR:-${HOME:?HOME is not set}/.local/bin}

# 1. Platform
os=$(uname -s)
case "$os" in
  Darwin) os=darwin ;;
  Linux) os=linux ;;
  *) fail "On Windows, run: npx -y halleyfy" ;;
esac
arch=$(uname -m)
case "$arch" in
  x86_64 | amd64) arch=x64 ;;
  arm64 | aarch64) arch=arm64 ;;
  *) fail "halleyfy has no build for $os-$arch." ;;
esac
target=$os-$arch
if [ "$os" = darwin ]; then
  # Under Rosetta uname says x86_64, but the native build is the right one.
  if [ "$arch" = x64 ] && [ "$(sysctl -n sysctl.proc_translated 2>/dev/null || true)" = 1 ]; then
    target=darwin-arm64
  fi
else
  # Trust ldd when it names a libc (Alpine's prints to stderr); the musl loader file
  # alone proves nothing, since glibc distros can install a musl package too.
  musl=0
  case "$(ldd --version 2>&1 || true)" in
    *[Mm]usl*) musl=1 ;;
    *GNU* | *[Gg][Ll][Ii][Bb][Cc]*) ;;
    *)
      for f in /lib/ld-musl-*; do
        [ -e "$f" ] && musl=1
      done
      ;;
  esac
  [ "$musl" = 1 ] && target=$target-musl
fi

tmp=$(mktemp -d)
staged=
cleanup() {
  rm -rf "$tmp"
  [ -z "$staged" ] || rm -f "$staged"
}
trap cleanup EXIT
trap 'exit 1' INT TERM HUP

if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
  fail "Install curl or wget and try again."
fi
download() { # url, output file
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$1" -o "$2"
  else
    wget -q -O "$2" "$1"
  fi
}

# 2. Lookup
download "$registry/@halleyfy%2fcli-$target/$version" "$tmp/meta.json" 2>/dev/null ||
  fail "Couldn't reach $registry."
meta=$(tr -d '\n' <"$tmp/meta.json")
tarball=$(printf %s "$meta" | sed -n 's/.*"tarball"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
integrity=$(printf %s "$meta" | sed -n 's/.*"integrity"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[ -n "$tarball" ] && [ -n "$integrity" ] ||
  fail "$registry has no halleyfy build for $target (version $version)."

# 3. Download and check
tgz=$tmp/cli.tgz
download "$tarball" "$tgz" 2>/dev/null || fail "Couldn't reach $registry."
if ! command -v sha512sum >/dev/null 2>&1 && ! command -v shasum >/dev/null 2>&1; then
  fail "Install sha512sum or shasum and try again."
fi
want=$(printf %s "${integrity#sha512-}" | base64 -d 2>/dev/null | od -An -v -tx1 | tr -d ' \n')
got=$( (sha512sum "$tgz" 2>/dev/null || shasum -a 512 "$tgz") | cut -d' ' -f1)
[ -n "$want" ] && [ "$want" = "$got" ] || fail "The download didn't match its checksum; nothing was installed."

# 4. Install: stage next to the target, then rename, so two installs at once are safe.
mkdir -p "$tmp/x" "$dir"
tar -xzf "$tgz" -C "$tmp/x" package/bin/halleyfy
chmod 755 "$tmp/x/package/bin/halleyfy"
staged=$dir/.halleyfy.tmp.$$
cp "$tmp/x/package/bin/halleyfy" "$staged"
chmod 755 "$staged"
mv -f "$staged" "$dir/halleyfy"
staged=

# 5. Skills
if [ "$skills" = 1 ]; then
  HALLEYFY_NO_UPDATE_CHECK=1 "$dir/halleyfy" skills install
fi

# 6. Finish
installed=$(HALLEYFY_NO_UPDATE_CHECK=1 "$dir/halleyfy" --version)
printf 'Installed halleyfy %s at %s\n' "$installed" "$dir/halleyfy"
case ":$PATH:" in
  *":$dir:"*) ;;
  *) printf 'Add it to your PATH:\n  export PATH="%s:\044PATH"\n' "$dir" ;;
esac
printf 'Next: halleyfy login\n'
