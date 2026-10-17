# halleyfy skills

Agent skills for halleyfy, which makes images and videos from the shell. The skill teaches a coding agent when to reach for the `halleyfy` CLI, how to keep spending inside your budget, and what to do with each exit code.

## Install

```bash
npx skills add xsirix/halleyfy-skills
```

Works with Claude Code, Codex, Cursor, OpenCode, Gemini CLI and the other agents the [Skills CLI](https://github.com/vercel-labs/skills) supports. Add `-g` to install it for every project.

## Needs

- The `halleyfy` CLI on your `PATH`.
- A signed-in CLI: run `halleyfy login` once. The agent can start the login for you, but you approve it in the browser.

## Skills

| Skill | Use it for |
|---|---|
| [`halleyfy`](skills/halleyfy/SKILL.md) | Images and videos: text to image, image editing with references, text to video, animating a still |

## License

MIT
