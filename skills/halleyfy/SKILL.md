---
name: halleyfy
description: Use when the user asks to generate, create, edit or restyle images or videos (product photos, hero images, icons, illustrations, mockups, text to video, image to video, animating a still), or mentions halleyfy.
---

# halleyfy

The `halleyfy` CLI makes images and videos from the shell. Each run is priced up front, charged to the user's balance and saved as files. You describe the result; halleyfy picks the model.

## Before the first run

1. `command -v halleyfy`. Missing: tell the user the halleyfy CLI isn't installed and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code`, and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.
3. Read `halleyfy image --help` or `halleyfy video --help`. It lists every flag, its allowed values and the live prices.

Don't pass `--local` or `--live` unless the user asks. The default target is the one they chose.

## Every run

```bash
halleyfy image "a red ceramic mug on white marble, studio light" --json --out ./assets
```

- Always `--json` and an `--out` folder that fits the project. Saved paths are in `files`, the price in `cost_usd`.
- Chain steps: animate a saved image with `halleyfy video "it slowly turns" --image ./assets/<file>.png`.
- A new run makes new files. Keep the old ones unless the user says to replace them.

## Spending

| Situation | Do this |
|---|---|
| User gave a budget | Pass `--max-cost <budget>` and run. |
| No budget, the run costs $1 or less | Run it. |
| No budget, it may cost more than $1 (videos, `--count`, batches, 4K) | `--dry-run --json` first, tell the user the price, run only after a yes. |
| Batch of N | Quote one, multiply by N, ask once for the total. Then start each with `--no-wait --json` and collect with `halleyfy job <id> --wait --json -o <dir>`. |

## Exit codes

| Code | Meaning | Do this |
|---|---|---|
| 0 | Done | Use `files`. |
| 1 | Error | Read the message. If it gives a re-run command with `--idempotency-key`, run exactly that: it returns the same job without paying twice. |
| 2 | Over a cost limit | Tell the user the price and the limit. Don't raise `--max-cost` yourself. |
| 3 | The job failed. Nothing was charged | Retry once without asking, rewording the prompt if the message points at it. Fails again: tell the user. |
| 4 | Not enough balance | Stop. Give the user the billing link from the message. |

## Common mistakes

- Leaving out `--aspect` with a video `--image`: the image is cropped to 16:9. For a vertical image pass `--aspect 9:16`.
- Expecting small print to survive in a video. Logos and big text hold; labels and fine print can blur or change.
- Asking for sound separately. Every video has sound; describe any speech or sound in the prompt.
- Asking the user before a cheap single image. Under $1 with no budget given, just run it.
- Re-running a lost start without the printed `--idempotency-key`, which pays twice.
