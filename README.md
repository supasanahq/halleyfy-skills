# halleyfy skills

[![skills.sh](https://skills.sh/b/supasanahq/halleyfy-skills)](https://skills.sh/supasanahq/halleyfy-skills)

Agent skills for halleyfy, which makes images, videos, speech, sound effects and music from the shell. One skill per kind of media. Each teaches a coding agent when to reach for it, how to write prompts that come out right the first time, how to keep spending inside your budget, and what to do with each exit code. Use-case guides (product, UGC ads, fashion, effects and more) sit inside each skill and are read only when the job needs them.

## Install

```bash
npx skills add supasanahq/halleyfy-skills
```

The [Skills CLI](https://skills.sh) asks which agents get them: Claude Code, Codex, Cursor, opencode, Gemini CLI and the others it knows. Add `-g` to install them for every project, and `-y` to skip the questions. Later, `npx skills update -g` fetches the newest version.

The skills drive the `halleyfy` CLI. Install it too:

```bash
npm install -g halleyfy
```

Or `bun add -g halleyfy`. Then sign in once with `halleyfy login`. Without the install, an agent that has `npx` runs the CLI as `npx -y halleyfy`.

### No Node? One line (macOS, Linux)

```bash
curl -fsSL https://halleyfy.com/install.sh | sh
```

You get the CLI in `~/.local/bin` and the skills. On a machine with `npx` and `git`, the script installs the skills with the Skills CLI, the same as the line at the top. On a machine without them, the CLI writes its own copy to `~/.claude/skills` and `~/.agents/skills`, and `halleyfy update` refreshes that copy.

### Windows

```bash
npx skills add supasanahq/halleyfy-skills -g
npx -y halleyfy image "a red mug on a white table"
```

Put `npx -y` in front of every `halleyfy` command.

### Claude Code plugin

```bash
claude plugin marketplace add supasanahq/halleyfy-skills
claude plugin install halleyfy@halleyfy
```

You get the three skills and a `halleyfy` launcher. The launcher installs the CLI the first time it runs.

### Codex plugin

```bash
codex plugin marketplace add supasanahq/halleyfy-skills
```

You get the skills. Install the CLI with the `npm` or `curl` line above.

### Coming from Claude or ChatGPT chat?

A chat can't run commands, so it can't use halleyfy. On a computer, open the Claude desktop app's Code tab (paid Claude plans) or Codex in the ChatGPT desktop app (any plan), and paste the setup prompt from halleyfy.com there.

### Installed twice?

Claude Code users who installed the plugin don't need the Skills CLI line. If you ran both, run `npx skills remove -g halleyfy-image halleyfy-video halleyfy-audio` so each skill shows up once.

### Tell your agent

Add this line to `AGENTS.md` or `CLAUDE.md`:

```
To make images, videos, speech, sound effects or music, use the halleyfy CLI (`halleyfy image`, `halleyfy video`, `halleyfy speak`, `halleyfy sound`, `halleyfy music`); run `halleyfy <command> --help` first.
```

## Needs

- The `halleyfy` CLI: `npm install -g halleyfy`, the `curl` line, or `npx -y halleyfy` with no install. The Claude Code plugin installs it for you.
- On Alpine, `libstdc++` (`apk add libstdc++`): the CLI needs it to start.
- A signed-in CLI: run `halleyfy login` once. The agent can start the login for you, but you approve it in the browser.

## Skills

| Skill | Use it for | Use-case guides |
|---|---|---|
| [`halleyfy-image`](skills/halleyfy-image/SKILL.md) | Images: text to image, editing with up to 16 reference images | product, UGC, fashion and beauty, ads and text, video start frames, consistency across a set |
| [`halleyfy-audio`](skills/halleyfy-audio/SKILL.md) | Speech, sound and music: text to an .mp3 in 21 voices, a new voice on a recording or clip, a clean voice out of noise, sound effects, ambience loops, a soundtrack for a silent or generated clip, an instrumental bed, a song, a score fitted to a clip | voiceovers, swapping a clip's voice, one narration in several languages, cleaning a noisy recording, sound effects and soundtracks, music |
| [`halleyfy-video`](skills/halleyfy-video/SKILL.md) | 3-15 s videos with sound, from a prompt, a start and end image, up to 10 reference images and 3 reference videos, or an edit of a video of up to 15 s | product, UGC ads, fashion, effects and transitions, social vertical, references and edits |

Install one with the Skills CLI: `npx skills add supasanahq/halleyfy-skills --skill halleyfy-video`.

### Coming from the `halleyfy` skill

The single `halleyfy` skill is now `halleyfy-image` and `halleyfy-video`. `npx skills update` offers to remove the old one but doesn't add the new ones: run `npx skills add supasanahq/halleyfy-skills` again.

## License

MIT
