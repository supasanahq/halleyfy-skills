# halleyfy skills

Agent skills for halleyfy, which makes images, videos, speech and sound effects from the shell. One skill per kind of media. Each teaches a coding agent when to reach for it, how to write prompts that come out right the first time, how to keep spending inside your budget, and what to do with each exit code. Use-case guides (product, UGC ads, fashion, effects and more) sit inside each skill and are read only when the job needs them.

## Install

Pick the row that fits you.

### Claude Code

```bash
claude plugin marketplace add supasanahq/halleyfy-skills
claude plugin install halleyfy@halleyfy
```

You get the three skills and a `halleyfy` launcher. The launcher installs the CLI the first time it runs.

### Any shell (macOS, Linux)

For Codex, opencode, Cursor, Copilot and any other agent.

```bash
curl -fsSL https://halleyfy.com/install.sh | sh
```

You get the CLI in `~/.local/bin` and the skills in `~/.claude/skills` and `~/.agents/skills`.

### Node and Windows

```bash
npx -y halleyfy skills install
npx -y halleyfy image "a red mug on a white table"
```

The first line installs the skills. Then put `npx -y` in front of every `halleyfy` command. Add `--project` to the first line to install the skills into the current folder only.

### Codex plugin

```bash
codex plugin marketplace add supasanahq/halleyfy-skills
```

You get the skills. The CLI still comes from the `curl` line above.

### Skills CLI

```bash
npx skills add supasanahq/halleyfy-skills
```

Works with Claude Code, Codex, Cursor, OpenCode, Gemini CLI and the other agents the [Skills CLI](https://github.com/vercel-labs/skills) supports. Add `-g` to install it for every project. You get the skills only.

### Installed twice?

Claude Code users who installed the plugin don't need the `curl` line. If you ran both, delete `~/.claude/skills/halleyfy-*` so each skill shows up once.

### Tell your agent

Add this line to `AGENTS.md` or `CLAUDE.md`:

```
To make images, videos, speech or sound effects, use the halleyfy CLI (`halleyfy image`, `halleyfy video`, `halleyfy speak`, `halleyfy sound`); run `halleyfy <command> --help` first.
```

## Needs

- The `halleyfy` CLI. The plugin and `install.sh` install it for you. With the Skills CLI or the Codex plugin, use the `curl` line or `npx -y halleyfy`.
- On Alpine, `libstdc++` (`apk add libstdc++`): the CLI needs it to start.
- A signed-in CLI: run `halleyfy login` once. The agent can start the login for you, but you approve it in the browser.

## Skills

| Skill | Use it for | Use-case guides |
|---|---|---|
| [`halleyfy-image`](skills/halleyfy-image/SKILL.md) | Images: text to image, editing with up to 16 reference images | product, UGC, fashion and beauty, ads and text, video start frames, consistency across a set |
| [`halleyfy-audio`](skills/halleyfy-audio/SKILL.md) | Speech and sound: text to an .mp3 in 21 voices, a new voice on a recording or clip, a clean voice out of noise, sound effects, ambience loops, a soundtrack for a silent or generated clip | voiceovers, swapping a clip's voice, one narration in several languages, cleaning a noisy recording, sound effects and soundtracks |
| [`halleyfy-video`](skills/halleyfy-video/SKILL.md) | 3-10 s videos with sound, from a prompt, a start and end image, up to 10 reference images and 5 reference videos, or an edit of a 2-10 s video | product, UGC ads, fashion, effects and transitions, social vertical, references and edits |

Install one with the Skills CLI: `npx skills add supasanahq/halleyfy-skills --skill halleyfy-video`.

### Coming from the `halleyfy` skill

The single `halleyfy` skill is now `halleyfy-image` and `halleyfy-video`. `npx skills update` offers to remove the old one but doesn't add the new ones: run `npx skills add supasanahq/halleyfy-skills` again.

## License

MIT
