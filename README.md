# halleyfy skills

Agent skills for halleyfy, which makes images and videos from the shell. One skill per CLI command. Each teaches a coding agent when to reach for it, how to write prompts that come out right the first time, how to keep spending inside your budget, and what to do with each exit code. Use-case guides (product, UGC ads, fashion, effects and more) sit inside each skill and are read only when the job needs them.

## Install

```bash
npx skills add xsirix/halleyfy-skills
```

Works with Claude Code, Codex, Cursor, OpenCode, Gemini CLI and the other agents the [Skills CLI](https://github.com/vercel-labs/skills) supports. Add `-g` to install it for every project.

## Needs

- The `halleyfy` CLI on your `PATH`.
- A signed-in CLI: run `halleyfy login` once. The agent can start the login for you, but you approve it in the browser.

## Skills

| Skill | Use it for | Use-case guides |
|---|---|---|
| [`halleyfy-image`](skills/halleyfy-image/SKILL.md) | Images: text to image, editing with up to 16 reference images | product, UGC, fashion and beauty, ads and text, video start frames, consistency across a set |
| [`halleyfy-video`](skills/halleyfy-video/SKILL.md) | 3-10 s videos with sound, from a prompt, a start and end image, up to 10 reference images and 5 reference videos, or an edit of a 2-10 s video | product, UGC ads, fashion, effects and transitions, social vertical, references and edits |

Install one with `npx skills add xsirix/halleyfy-skills --skill halleyfy-video`.

### Coming from the `halleyfy` skill

The single `halleyfy` skill is now `halleyfy-image` and `halleyfy-video`. `npx skills update` offers to remove the old one but doesn't add the new ones: run `npx skills add xsirix/halleyfy-skills` again.

## License

MIT
