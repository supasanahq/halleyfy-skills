---
name: halleyfy-video
description: Use when the user asks to make a video or clip (product videos, UGC or talking-head ads, spokesperson lines, fashion films, lookbooks, social reels and TikToks, cinematic or establishing shots, effects and transitions, animating a still image), or mentions halleyfy video.
---

# halleyfy video

`halleyfy video` turns a prompt, optionally with a start image (and an end image) or up to 10 reference images, into a 3-10 second clip with sound. halleyfy picks the model. You write the direction: the more of the clip you decide in the prompt, the less the model guesses, and guessing is where clips go wrong.

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
- No aspect or length from the user: pick from where the clip will be used (9:16 for reels, stories and TikTok; 16:9 for web, YouTube and decks), else 16:9. Length: 6 s for one spoken line or one beat, 8 s for setup, action and payoff. No placement known: 9:16 for tall subjects (full body, a standing product), 16:9 for wide scenes. Resolution: 1080p for finals, 720p when it is only for social feeds (same motion, less cost), 4K only when asked. Say what you picked.
- Every clip has a sound track. For silent uses (a website background, a muted loop), still direct quiet audio, then strip it if needed: `ffmpeg -i clip.mp4 -an -c:v copy silent.mp4`.
- Files are saved in `--out` as `<job id>-<n>.<ext>`; the paths are in `files` of the JSON. Use those paths (or rename the files) in the next command.
- A video's price depends only on seconds and resolution, so you can quote it with `--dry-run` before the frames exist: leave the image flags out of the dry run.
- Not available yet: editing an existing video, extending a clip, reference videos. If the user needs one of these, say so.

## Pick how to pin the clip

| The job | Use |
|---|---|
| The opening shot must look exactly right (most ads) | `--image` start frame |
| Where the clip ends matters too: a reveal, a turn to a set angle, an effect's "after", a loop | `--image` + `--end-image` |
| The same person or product across clips, framing left to the model | `--ref` (up to 10) |
| Several shots where each must look exact | One clip per shot, each from its own start frame, joined in editing. One multi-shot clip keeps in-camera transitions (whip pans, match cuts) but only its first shot is pinned. Offer the user the choice. |
| A plain scene that words describe well | Prompt only |

**The end frame is the timeline's last moment.** It must show the camera position, the pose and the state the timeline ends on. Either end the timeline where the start frame's camera and pose are (lock the camera, return to the opening pose), or put every difference into the end frame.

Make the end frame by editing the start frame with `halleyfy image` (same shape): "keep everything; change only" followed by every difference at the end, such as the after-state of the effect, the closer framing, or the new pose. For a camera move, X is the viewpoint: "keep the product, floor, light and framing; change only the viewing angle to its side profile", with a photo of that side as a second reference. Orbit toward the side the end frame shows. Two frames made separately differ in small ways, and the model has to morph between them. The same image as start and end gives a loop.

## Direct the clip

The model fills every gap in the prompt with its own guess: a sky that brightens mid-clip, a cut nobody planned, a camera move from nowhere, a spin that loses the body. **You are the director.** Do the thinking before you write: decide every shot, move, beat and sound, then write all of it down, so the model has nothing left to guess.

### 1. Make the frames or references first

Use `halleyfy image` at the video's aspect and 2K, and check them. Images fix the subject, the look, the light and the composition better than words.

### 2. Decide everything

- **Shot plan.** One continuous shot, or several shots with their times and the transition between each: hard cut, match cut, whip pan, dissolve, object wipe, morph. Never leave it open: the model cuts on its own when the prompt doesn't say.
- **Per shot:**
  - framing and lens
  - the camera move with its start, end and speed (or "locked off")
  - the subject's action as timed beats, with the body mechanics for anything complex
- **Everything else that moves:** fabric, hair, water, smoke, particles, background people, light.
- **Continuity:** what the sky, the light (direction, color, brightness), the location, the wardrobe and the product do across the clip. Say "stays exactly the same" when that is the plan. Anything you leave out, the model may change.
- **Effects:** a physical process with a start time, a duration, a direction and a material, and what the light does on it.
- **Audio timeline:** dialogue, sound effects tied to visible events, ambience, and music or "No music".

### 3. Write it as a timeline

```text
Shot plan: one continuous shot, 8 seconds, no cuts.
0-3 s: <camera>. <subject beat>. <environment>.
3-5 s: <the effect or main beat: what changes, how, how fast, in which direction>.
5-8 s: <camera arrives where>. <subject settles>. <the after-state>.
Continuity: <sky, light, location, wardrobe, product: what stays, what changes and when>.
Audio: <timed sound events>, <ambience>, <music or No music>. <Dialogue, if any>.
No on-screen text, no captions, no subtitles.
```

With a start frame, refer to what it shows ("she", "the bottle", "the wave") instead of describing it again. Use `<IMAGE_REF_n>` tags for `--ref` images: "the woman from <IMAGE_REF_0> holds the bottle from <IMAGE_REF_1>", counted from 0 in the order of the `--ref` flags.

The length follows the plan. A simple clip takes a few lines; an effect, a transition or choreography takes a line per beat. Every sentence must be a decision: concrete and physical ("wet asphalt, neon reflections in puddles"), never praise ("beautiful, epic, cinematic"), and never in conflict with another line.

### 4. Run, check, and fix the gap

Run, then check the clip (below). When something goes wrong, find the gap the model filled: what did the prompt not decide? Add that decision and run again. Don't just re-roll the same prompt; each run is a new take anyway, since there are no seeds.

For a complex prompt (an effect, a transition, choreography, dialogue), offer a 360p test take first and include it in the price you quote. The final is a new take at the resolution the user wants, so review it too. If a test take is already good and its size is enough, deliver it.

## Ambitious motion and effects

Spins, dancing, transformations, outfit changes, freezes and transitions between shots are all fair game. They are where missing direction shows first, so they need the most:

- **Choreograph the body.** For a spin: how many turns and over how long ("one slow full turn on the spot over 2 seconds, weight on her left foot"), arms ("close to her body, right hand trailing"), head ("she keeps her eyes on the lens as long as she can, then whips back to it"), hair and fabric ("the hem flares out and settles half a second after she stops").
- **Time the change.** "At 3 seconds, as she faces away, the denim dissolves into silver sequins from the hem upward over half a second, a ripple of light running up with it."
- **Hold the rest still.** Say what stays fixed while the effect runs: background, light, framing, her face and hair.
- **Pin the after-state with an end frame** when it must look exact (see "Pick how to pin the clip").
- **Give it room.** The motion around a change (a spin, a walk, a camera move) needs about 2 seconds; the change itself can be quick. In a multi-shot clip give each shot at least 2-3 seconds.
- **Slow motion** works in the prompt: "shot 3 in half-speed slow motion". Time its beats in seconds of the finished clip.
- **Tell the user** that complex motion can take a retake or two, and offer the 360p test.

Recipes for common effects and transitions are in `references/effects-and-transitions.md`.

## Dialogue

- One speaker per clip.
- Write the line after a colon, without quotation marks: `She looks into the lens and says: Day three, and my skin is glowing.` Quotes can turn into on-screen captions.
- Use complete, clean sentences. No "...", no dashes, no "um": they come out as stutters. Put the delivery in the description instead ("with a small laugh").
- About 2.5 words per second: at most 10 words for 6 seconds, 15 for 10. Finish the line a second or more before the end, and by the 7-second mark at the latest.
- Keep the user's words; punctuation is fine to adjust.
- Describe the voice outside the line: "warm, late-20s, casual, close phone-mic sound".

## Text and logos

Big shapes hold; small text warps. Keep headlines out of the video and add them in editing.

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
ffmpeg -loglevel error -i clip.mp4 -vf fps=1,scale=480:-1,tile=5x2 -frames:v 1 sheet.png
ffmpeg -i clip.mp4 -vf "select='gt(scene,0.1)',showinfo" -f null - 2>&1 | grep -o 'pts_time:[0-9.]*'
```

The first makes a contact sheet of one frame per second (up to 10 seconds). The second prints the moments where the picture jumps: cuts, or a sky or light that suddenly changes. Compare them with your shot plan: a planned cut should print, nothing else should. A fast camera move can print too, so look at the frames around each time before you judge. Also look for drifting faces, melting hands, a product that changed shape, and captions nobody asked for. Tell the user what you checked.

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

- Leaving the shot plan open: the model adds cuts of its own.
- Directing the effect but not the world around it: nothing said what the sky does while the wave freezes, so the sky changed too.
- Complex motion in one sentence ("she spins and her outfit transforms"): give each beat its time, its mechanics and its speed.
- Re-rolling a failed prompt unchanged instead of adding the decision that was missing.
- Dialogue in quotes, with "...", or longer than the clip can hold.
- No audio line: random music or sound effects.
- Describing the start image again instead of directing what happens.
- Starting a vertical video from a 16:9 image, or the reverse: it gets cropped.
- An end frame generated separately instead of edited from the start frame: the clip morphs to bridge the differences.
- `--ref` images without tags in the prompt: the model guesses which image is what.
