---
name: halleyfy-image
description: Use when the user asks to make, edit or restyle an image (product shots, packshots, lifestyle photos, ads or posters with a headline, UGC or phone-photo style pictures, fashion or beauty campaigns, thumbnails, icons, mockups, a first frame for a video, the same product or character across several images), or mentions halleyfy image.
---

# halleyfy image

`halleyfy image` turns a written brief, plus up to 16 reference images, into finished image files. halleyfy picks the model. Your job is the brief: the clearer it is, the less you pay for retakes.

## Before the first run

1. `command -v halleyfy`. Missing: tell the user the halleyfy CLI isn't installed and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code`, and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.
3. Read `halleyfy image --help` once: every flag, its allowed values and the live prices.

Don't pass `--local` or `--live` unless the user asks.

## Every run

```bash
halleyfy image "<brief>" --aspect 4:5 --resolution 2K --json --out ./assets
```

- `--aspect`: the shape of the place it will be used. 1:1 or 4:5 for feeds, 9:16 for stories, reels and vertical video frames, 16:9 for web heroes, thumbnails and video frames, 21:9 for banners. Make it at the final shape; cropping later loses the composition.
- `--resolution`: 1K for drafts, 2K for finals, 4K only when the user asks (print, big screens).
- `--image <path|file id|url>`, repeatable up to 16: reference images. With at least one, the run edits instead of drawing from scratch. Each extra reference adds to the price (2-4 cost more per image than one, 5-16 more again), so pass only the ones that matter.
- `--count 2-4` gives small variations of one brief. For real alternatives, change the brief and run again.
- The saved paths are in `files` of the JSON. Look at every result before you hand it over, and read any text in it letter by letter.

## Write the brief

The model fills what the brief leaves open with a default: a generic backdrop, flat light, a centered stock composition, a made-up label. Spend your words on what makes this image this one: the subject and what it is made of, where it sits, the light, the one striking element, the exact text. Concrete, visible words beat adjectives, and no two lines may conflict. OpenAI's guide for GPT Image asks for visible details (materials, light, color, framing, texture), so images take more detail than video prompts do.

Write it in this order, as plain sentences or labeled lines:

1. **Use:** what it is for. "Hero image for a skincare launch ad."
2. **Subject and scene:** concrete, visible things: materials, surfaces, props, place, time of day.
3. **Composition:** where the subject sits, the camera height and lens feel, the empty space you need for copy.
4. **Light:** the source and its direction. "Soft window light from the left, thin rim light from behind."
5. **Look:** "photorealistic commercial photograph", "an ordinary phone photo", "flat vector icon".
6. **Text:** the exact words in quotes, where they go, the type style, "exactly once", then "no other text".
7. **Exclude:** "no logos, no watermark, no extra props", whatever must not appear.

For people, give framing ("full body, feet included"), gaze, and how hands touch objects. Say "real skin texture" for faces that should not look airbrushed. Leave out keyword piles like "8k, masterpiece, hyper-detailed": they decide nothing and push toward glossy stock pictures. When a result misses, change the one thing that went wrong and run again.

## Edit with reference images

- The order of `--image` flags is Image 1, Image 2 and so on. Name each one's role in the brief: "Image 1 is the product: keep its shape, cap, colors and label exactly. Image 2 is the lighting reference."
- Say what changes, then what stays: "Change only the background to a sunlit kitchen. Keep the bottle, its label, the camera angle and the framing."
- One change per run. For a series, start every image from the same clean references, not from the last output: each pass adds a little sharpening and color drift. An approved image may join as a style reference ("Image 2 shows the look to match"); the product or person still comes from the original reference.
- A real person from a photo (usually the user themselves): "Image 1 is the person: keep their face, identity, skin tone and hair exactly." Only with the person's own photo or their clear permission; never public figures or strangers.

## Use-case guides

Read every guide that matches the job before you write the brief.

| Making | Read |
|---|---|
| Product shots, packshots, lifestyle scenes, cutouts | `references/product.md` |
| UGC, creator or phone-photo style pictures | `references/ugc.md` |
| Fashion, beauty, models, outfit try-on | `references/fashion-beauty.md` |
| Ads, posters, social posts or thumbnails with a headline | `references/ads-and-text.md` |
| A frame that `halleyfy video --image` will animate | `references/start-frames.md` |
| The same product or character across a set | `references/consistency.md` |

## Finding past results

- Find a job: `halleyfy jobs --search "<words>" --since 7d`.
- Download it again: `halleyfy job <id> -o <dir>`.
- Results are kept 30 days, then deleted.

## Spending

| Situation | Do this |
|---|---|
| User gave a budget | Pass `--max-cost <budget>` and run. |
| No budget, the run costs $1 or less | Run it. |
| No budget, the run or the whole batch may cost more than $1 (`--count`, 4K, several images) | `--dry-run --json` one run, multiply by the number of runs, tell the user the total, run only after a yes. |
| Several runs | Start each with `--no-wait --json`, collect with `halleyfy job <id> --wait --json --out <dir>`. |

## Exit codes

| Code | Meaning | Do this |
|---|---|---|
| 0 | Done | Use `files`. |
| 1 | Error | Read the message. If it gives a re-run command with `--idempotency-key`, run exactly that: it returns the same job without paying twice. |
| 2 | Over a cost limit | Tell the user the price and the limit. Don't raise `--max-cost` yourself. |
| 3 | The job failed, nothing was charged | Retry once, rewording the brief if the message points at it. Fails again: tell the user. |
| 4 | Not enough balance | Stop. Give the user the billing link from the message. |

## Common mistakes

- Making a square image for a 9:16 story or a 16:9 hero, then cropping it.
- A brief made of style words with no concrete subject, place or light.
- Putting text into an image that will be animated: text warps in video.
- Trusting the spelling of a headline without reading it in the result.
- Chaining edit after edit on the last output instead of the original references.
