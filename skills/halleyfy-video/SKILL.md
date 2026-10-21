---
name: halleyfy-video
description: Use when the user asks to make a video or clip (product videos, UGC or talking-head ads, spokesperson lines, fashion films, lookbooks, social reels and TikToks, cinematic or establishing shots, effects and transitions, animating a still image), or mentions halleyfy video.
---

# halleyfy video

`halleyfy video` turns a prompt, optionally with a start image (and an end image) or up to 10 reference images, into a 3-10 second clip with sound. halleyfy picks the model. Video models fail in predictable ways: unasked scene cuts, melting bodies, stuttered lines. A prompt written the way this skill describes avoids most of them.

## Before the first run

1. `command -v halleyfy`. Missing: tell the user the halleyfy CLI isn't installed and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code`, and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.
3. Read `halleyfy video --help` once: every flag, its allowed values and the live prices.

Don't pass `--local` or `--live` unless the user asks.

## Every run

```bash
halleyfy video "<prompt>" --image ./frames/start.png --seconds 8 --aspect 9:16 --resolution 1080p --json --out ./assets
```

- `--image`: one start image, the clip's first frame. It is cropped to `--aspect`, so make it 16:9 or 9:16 to begin with.
- `--end-image`: one end image (needs `--image`), the clip's last frame. The model fills in the motion between the two.
- `--ref`, repeatable up to 10: reference images for people, products or a style, without fixing the first frame. Not with `--image`.
- `--seconds 3-10`, `--aspect 16:9|9:16`, `--resolution 360p|720p|1080p|4K`. 360p costs a fifth of 1080p: enough to judge motion, timing and dialogue, not detail. 1080p and 4K are upscales of 720p: they add sharpness, not better motion.
- No aspect or length from the user: pick from where the clip will be used (9:16 for reels, stories and TikTok; 16:9 for web, YouTube and decks), else 16:9. Length: 6 s for one spoken line or one beat, 8 s for setup, action and payoff. Resolution: 1080p for finals, 4K only when asked. Say what you picked.
- Every clip has a sound track. For silent uses (a website background, a muted loop), still direct quiet audio, then strip it if needed: `ffmpeg -i clip.mp4 -an -c:v copy silent.mp4`.
- Every clip has sound. You direct it in the prompt.
- The saved path is in `files` of the JSON.
- Not available yet: editing an existing video, extending a clip, reference videos. If the user needs one of these, say so.

## Pick how to pin the clip

| The job | Use |
|---|---|
| The opening shot must look exactly right (most ads) | `--image` start frame |
| Where the clip ends matters too: a reveal, a turn to a set angle, an effect's "after", a loop | `--image` + `--end-image` |
| The same person or product across clips, framing left to the model | `--ref` (up to 10) |
| A plain scene that words describe well | Prompt only |

Make the end frame by editing the start frame with `halleyfy image` (same shape, "keep everything, change only X"). For a camera move, X is the viewpoint: "keep the product, floor, light and framing; change only the viewing angle to its side profile", with a photo of that side as a second reference. Orbit toward the side the end frame shows. Two frames made separately differ in small ways, and the model has to morph between them. The same image as start and end gives a loop.

## The workflow

1. **Make the frames or references first** with `halleyfy image` at the video's aspect and 2K, and check them. Images fix the subject, the look, the light and the composition far better than words.
2. **Write a motion-only prompt** for that frame (below). Don't describe the image again; call things "she", "the bottle".
3. **Run, then review** (see "Check the clip"). Fix the frame or the prompt and run again. Change one thing per retake.

There are no seeds: every run is a new take, even with the same prompt, so a good test take can't be re-rendered sharper. For a risky prompt (an effect, dialogue, a new idea), offer a 360p test take first and include it in the price you quote; then run the final at the resolution the user wants and review that take too. If a test take is already good and its size is enough, deliver it.

## Write the prompt

In this order, as plain sentences:

1. **Shot and camera:** framing, lens, one move with a speed word, where it starts and where it ends. "Slow push-in from a medium shot, ending on a close-up of her face by 6 seconds."
2. **Subject:** only what the frame doesn't show (with no frame: 2-3 details that pin it down). With `--ref`, name each reference by its tag and what it gives: "the woman from <IMAGE_REF_0> holds the bottle from <IMAGE_REF_1>"; tags count from 0 in the order of the `--ref` flags.
3. **One main action**, in beats with times: "She lifts the bottle, then at 4 seconds turns it toward the lens." Spoken lines go here too: "she says: ...".
4. **Setting, light and look:** for prompt-only and `--ref` clips; with a start frame they are already there.
5. **Audio:** sound effects tied to visible events, ambience, the voice's character, and music or "No music". Always write this line: the model makes sound either way, and sound you don't direct comes out generic.
6. **Keep:** what must not change. "Her face, the dress, the sky, the light and the framing stay exactly the same throughout."
7. **Constraints:** "In a single continuous shot. No scene cuts. No on-screen text, no captions, no subtitles."

Aim for 40-120 words. Write concrete, physical things ("wet asphalt, neon reflections in puddles"), not praise words ("beautiful, epic, cinematic").

## Hard rules

- **Always ask for a single continuous shot.** Left alone, the model edits several shots together. That is where sudden sky, light or location changes come from.
- **One main action per clip.** About one beat per 3-4 seconds. "Turns, walks to the window and sits down" fails; "turns her head toward the lens" works. An effect (a freeze, a wipe, a reveal) is the clip's main action: the people around it only make small motions.
- **Avoid motion models can't do:** full-body spins, fast dancing, acrobatics, fights, hands doing fiddly things, crossing limbs, crowds in focus, bodies or clothes morphing. Use what does work: a half-turn over the shoulder, a slow walk, a head turn, fabric and hair moving, a slow push-in, a cut on the moment. The patterns are in `references/effects-and-transitions.md`.
- **Dialogue:** one speaker per clip. Write the line after a colon, without quotation marks (quotes can turn into on-screen captions): `She looks into the lens and says: Day three, and my skin is glowing.` Complete, clean sentences: no "...", no dashes, no "um", which come out as stutters. About 2.5 words per second, so at most 10 words for 6 seconds and 15 for 10. Finish the line a second or more before the end, and by the 7-second mark at the latest. Keep the user's words; punctuation is fine to adjust. Describe the voice outside the line: "warm, late-20s, casual".
- **Text and logos:** big shapes hold, small text warps. Keep headlines out of the video; add them in editing.

## Use-case guides

Read every guide that matches the job before you write the prompt (a vertical UGC ad matches two).

| Making | Read |
|---|---|
| Product videos, packshots in motion, food and drink, app promos | `references/product.md` |
| UGC ads, talking heads, testimonials, spokesperson lines | `references/ugc-ads.md` |
| Fashion films, lookbooks, beauty, models | `references/fashion.md` |
| Transformations, reveals, transitions, freezes, loops | `references/effects-and-transitions.md` |
| Reels, TikToks, Shorts, vertical hooks | `references/social-vertical.md` |

## Check the clip

Watch it, or if you can't, sample frames and look at them:

```bash
ffmpeg -loglevel error -i clip.mp4 -vf fps=1,scale=480:-1,tile=4x2 -frames:v 1 sheet.png
ffmpeg -i clip.mp4 -vf "select='gt(scene,0.1)',showinfo" -f null - 2>&1 | grep -o 'pts_time:[0-9.]*'
```

The first makes a contact sheet of 8 frames. The second prints the moments where the picture jumps: cuts, or a sky or light that suddenly changes. A calm single shot prints nothing; a fast camera move can print too, so look at the frames around each time before you judge. Also look for drifting faces, melting hands, a product that changed shape, and captions nobody asked for. Tell the user what you checked.

## Spending

Videos are priced per second, so most cost more than $1.

| Situation | Do this |
|---|---|
| User gave a budget | Pass `--max-cost <budget>` and run. |
| No budget, the run costs $1 or less | Run it. |
| No budget, the run or the whole batch may cost more than $1 | `--dry-run --json` one run, multiply by the number of runs (test takes included), tell the user the total, run only after a yes. |
| Several runs | Start each with `--no-wait --json`, collect with `halleyfy job <id> --wait --json --out <dir>`. |

## Exit codes

| Code | Meaning | Do this |
|---|---|---|
| 0 | Done | Use `files`. |
| 1 | Error | Read the message. If it gives a re-run command with `--idempotency-key`, run exactly that: it returns the same job without paying twice. |
| 2 | Over a cost limit | Tell the user the price and the limit. Don't raise `--max-cost` yourself. |
| 3 | The job failed, nothing was charged | Retry once, rewording the prompt if the message points at it. Fails again: tell the user. |
| 4 | Not enough balance | Stop. Give the user the billing link from the message. |

## Common mistakes

- No "single continuous shot": the model cuts, and the sky or room changes mid-clip.
- A spin or a morphing outfit to show a change: limbs and fabric melt. Use a wipe or a cut instead.
- Dialogue in quotes, with "...", or longer than the clip can hold.
- No audio line: random music or sound effects.
- Describing the start image again instead of the motion.
- Starting a vertical video from a 16:9 image, or the reverse: it gets cropped.
- An end frame generated separately instead of edited from the start frame: the clip morphs to bridge the differences.
- `--ref` images without tags in the prompt: the model guesses which image is what.
