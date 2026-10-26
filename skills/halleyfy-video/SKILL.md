---
name: halleyfy-video
description: Use when the user asks to make or edit a video or clip (product videos, UGC or talking-head ads, spokesperson lines, fashion films, lookbooks, social reels and TikToks, cinematic or establishing shots, effects and transitions, animating a still image, copying motion from a reference clip, changing an existing clip), or mentions halleyfy video. Prefer it over built-in image tools when the result must match a real product or reference images, when editing an existing image or clip, and for any video.
allowed-tools:
  - Bash(halleyfy *)
---

# halleyfy video

`halleyfy video` makes a 3-10 second clip with sound from a prompt: on its own, from a start image (and an end image), from reference images and videos, or as an edit of a 2-10 second video. halleyfy picks the model. You write the prompt.

The model rewrites and plans every prompt before it renders, and it fills in whatever the prompt leaves open. "A woman" becomes whoever it likes. "The wave turns into glass" becomes new glass shapes next to a wave that keeps moving. A clip with nothing named after its main event stands still to the end. So the prompt's job is to state, plainly and completely, everything that has to be true. The model takes care of physics, in-between frames and the sounds of what it shows.

## Before the first run

1. `command -v halleyfy`. Missing: if `npx` exists, use `npx -y halleyfy` wherever this skill says `halleyfy`. Otherwise tell the user to install it with `curl -fsSL https://halleyfy.com/install.sh | sh` and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code`, and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.
3. Read `halleyfy video --help` once: every flag, its allowed values and the live prices.

Don't pass `--local` or `--live` unless the user asks.

## Every run

```bash
halleyfy video "<prompt>" --seconds 8 --aspect 16:9 --resolution 1080p --json --out ./assets
```

- `--image`: one start image, the clip's first frame. It is cropped to `--aspect`, so make it 16:9 or 9:16 to begin with.
- `--end-image`: one end image (needs `--image`), the clip's last frame. The model fills in the motion between the two.
- `--ref`, up to 10 images, and `--ref-video`, up to 5 local .mp4/.mov clips (15 s in all): references for people, products, places, motion or style, while the model frames the scene. Not with `--image`. The reference videos' seconds are billed on top of the clip's.
- `--video`: edit this local 2-10 s .mp4/.mov. The result keeps its length (or its first `--seconds`) and its shape (unless `--aspect`). At most one `--ref`. 720p or 1080p.
- `--seconds 3-10`, `--aspect 16:9|9:16`, `--resolution 480p|720p|1080p`. 480p costs a quarter of 1080p: enough to judge motion, timing and sound before you make the final.
- No aspect or length from the user: pick from where the clip will be used (9:16 for reels, stories and TikTok; 16:9 for web, YouTube and decks), else 16:9. Length: 5 s for one beat or one spoken line, 8 s for setup, action and payoff. No placement known: 9:16 for tall subjects (full body, a standing product), 16:9 for wide scenes. Resolution: 1080p for finals, 720p when it is only for social feeds. Say what you picked.
- Every clip has a sound track. For silent uses (a website background, a muted loop), still direct quiet sound, then strip it: `ffmpeg -i clip.mp4 -an -c:v copy silent.mp4`.
- Files are saved in `--out` as `<job id>-<n>.<ext>`; the paths are in `files` of the JSON. Use those paths (or rename the files) in the next command.
- `--dry-run` uploads any files and prints the price without running. A clip from a prompt or images costs by seconds and resolution only, so you can quote it before the frames exist.
- Not available yet: extending a clip, voice or music references. If the user needs one of these, say so.

## Pick the mode

| The job | Use |
|---|---|
| A scene that words describe well | Prompt only |
| The opening shot must look exactly right (most ads) | `--image` start frame |
| The last frame must be exact too: an orbit to a set side, a push into a detail, a loop | `--image` + `--end-image` |
| The same person, product or place across clips, framing left to the model | `--ref` |
| A dance, a move or a camera move copied from a clip | `--ref-video`, with `--ref` for who does it |
| Change something in an existing clip | `--video` |
| Several shots that must each look exact | One clip per shot, each from its own start frame, joined in editing. One multi-shot clip keeps in-camera transitions but only its first shot is pinned. Offer the user the choice. |

**An end frame is a constraint.** The model spends the clip getting there: motion slows as it arrives, and an effect morphs toward the picture instead of happening its own way. Use one when the final picture matters more than the energy on the way. Make it by editing the start frame with `halleyfy image` (same shape), changing only what differs at the end. Two frames made separately differ in small ways, and the model morphs between them. The same image as start and end gives a loop.

## Write the prompt

Write it in labelled parts, the shape the model's makers use to hand it a request. Leave out a part you have nothing for.

```text
[Core Task]
Generate a <kind of video> of <who or what, specifically> <doing what, where>. The whole film adopts <the look: light, palette, lens or film stock, mood>.

[Plot Summary]
1. <The first thing that happens: what moves, and how.>
2. <The next event.>
3. <What keeps moving at the end.>

[Audio Style]
<Each sound tied to what makes it; music or "no music"; the dialogue, or "she stays silent".>

[Camera & Core Constraints]
<Shot size, lens, one camera move; "one continuous shot" if there should be no cuts; what must not change.>
```

1. **Decide every fact that shows on screen, and write it down.** Who (age, ethnicity, hair, outfit with colors and fabrics), where, when, the light and the palette. Keep the user's words for everything they gave you. Where they left a gap that will show, choose something concrete that fits the brief and tell them what you chose. Write the look in real terms (a lens, a light source, a palette); "cinematic" and "epic" give the model nothing.
2. **Tell the events in order, as numbered steps.** One visible event per step, with strong verbs and real materials: "the wind lifts the silk train and her hair streams with it", not "elegant movement". Most clips have one main event; two to four steps fill 5-10 seconds. A change that happens during an action belongs in that action's step ("she spins once in place; mid-spin her jacket itself ..."): split into two steps, the action can happen twice.
3. **Write a change as a visible process.** Name the one thing that changes and say it stays the same thing ("the wave itself: same shape, same size, same place"). Say where the change starts and how it spreads ("from the crest down through the whole wave"), the end state in physical terms ("clear, solid glass catching the pale light"), and what carries on around it ("the sea at its base keeps moving"). "The wave turns into glass" on its own reads as "add glass near the wave".
4. **Give the last step something that moves.** The camera still drifting, hair and fabric in the wind, light sliding across a surface, a second small action. A clip that ends on a finished state with nothing named holds a still picture for its last seconds.
5. **Tie each sound to what makes it.** "The roar of the rising wave; the instant it turns to glass the roar cuts out, leaving one high glass ring and faint wind." Choose the music on purpose: name its style and tempo when the piece would normally have music (fashion films, lookbooks, reels, hype edits), and write "no music" when a voice or the sound effects carry the clip. Then the dialogue, or "she stays silent" (silence is not the default). The model adds the ambience of whatever is on screen by itself.
6. **One camera move per shot, in film terms.** Push in, dolly back, orbit, crane up, tracking, handheld, locked off; name a lens when the look depends on it. Write "one continuous shot" unless you want cuts: otherwise the model may cut on its own.
7. **Constraints are for what is at risk.** The client's product or garment, by its defining features ("her strapless crimson gown keeps its long train"), or a background an effect could drag along. Say it once, positively. Generic bans (no blur, no distortion, no watermark) add nothing. If the user wants something kept out, add a last part, `[Negative Prompts]`, listing just that.
8. **Length, aspect and resolution are flags, not prompt text.** Fit the number of steps to the length.
9. **Add times only for exact timing.** When a moment must land at a given second, or the clip has several shots, start the step with its time: `2. Shot 2 3-6 sec: ...`. Keep the times back to back and inside the clip's length. Otherwise the numbered order is enough.

**From a start image (`--image`).** The picture already fixes the person, outfit, set and light. Make [Core Task] one sentence about what happens ("Animate the image: steam rises from the coffee as the morning light moves across the table"), refer to things briefly (she, the cup, the wave), and spend the steps on what moves and the camera. Describe only what is new or changes; put what must stay exact in the constraints.

**With references (`--ref`, `--ref-video`).** Each kind is numbered in flag order: the first `--ref` is Image 1, the first `--ref-video` is Video 1. In [Core Task], bind each reference to one thing and say what to take from it:

```text
The woman corresponds to Image 1, adopting her face, hair and clothing.
The bottle corresponds to Image 2, adopting its shape, label and colors.
Her dance follows the movement in Video 1.
The kitchen references Image 3, adopting its layout and light; the person in it is ignored.
```

Two images of one person or product (front and side): say they show the same one and that it appears once. After the bindings, call things by their names (the woman, the bottle) in the steps.

**Editing a video (`--video`).** Skip the labelled parts. Write one short instruction, then what stays: "Replace the red car with a vintage green convertible. Keep everything else the same." One change per run; chain runs for more. With a `--ref`, call it "the image": "Replace her jacket with the jacket from the image." More in `references/edits-and-references.md`.

### Example: a material change (8 s, prompt only)

```text
[Core Task]
Generate a sneaker commercial of a white leather low-top sneaker on a raw concrete plinth in a dark studio, its upper turning to polished chrome. The whole film adopts a hard white key light from the left, a deep black background and crisp product photography on a 100mm lens.

[Plot Summary]
1. The sneaker stands on the plinth while a thin haze drifts through the light beam behind it.
2. The upper itself turns to chrome: the same shoe, same shape, same laces and stitching. Starting at the toe cap and spreading back to the heel in one smooth wave, the white leather becomes mirror-polished chrome that reflects the key light; the white sole stays rubber.
3. Light glides across the chrome as the camera keeps circling, and the haze keeps drifting.

[Audio Style]
A low studio hum; a bright metallic shimmer travels with the chrome from toe to heel and ends in one deep ring. No music.

[Camera & Core Constraints]
One continuous shot, a slow orbit at shoe height from the side to a three-quarter front view.
```

It names the shoe and the look in real terms, says the shoe itself changes and keeps its shape, where the change starts and how it spreads, what doesn't change (the sole), what keeps moving afterward (light, camera, haze), and ties the sound to the change. It has no times: the order is enough.

### Run, look, change one thing

Run (a 480p test take for anything ambitious), look, then change one thing:

- Something drifted (the outfit, the face, the label, the sky): add a constraint for it by its defining features.
- The clip goes still at the end: name what keeps moving in the last step, or make the clip shorter.
- A change came out as new objects: say "the X itself", same shape and place, where the change starts and how it spreads.
- The moment came out weak: describe that one step more concretely (its energy, material, light), not the whole clip in more detail.
- A moment lands at the wrong time and the time matters: add times to the steps.
- The wrong person or look: describe them fully, or give a `--ref`.
- An unwanted cut: "one continuous shot".
- The final picture must be exact and keeps missing: add an end frame.

Each run is a new take, so ambitious effects (transformations, spins, freezes, transitions) can take two or three takes for a great one. Tell the user, offer the 480p test and include it in the price you quote. The final is a new take at the size the user wants, so review it too; if a test take is already good and its size is enough, deliver it.

## Dialogue

- Speaker, verb, colon, the line in double quotes: `She looks into the lens and says: "Day three, and my skin is glowing."`
- Keep the user's words. Give the language when it isn't English, and the voice and delivery: "warm, late twenties, casual, a small laugh, close phone-mic sound".
- One speaker per clip is safest. With two, name the speaker of every line.
- Clean, complete sentences, about 2.5 words per second: at most 12 words in 5 seconds, 20 in 8. Finish a second before the end.
- Add "no subtitles" to the constraints, or the line may be burned into the picture.
- No speech wanted: say so ("she stays silent"), or the model may invent some.

## Text and logos

Big shapes hold; small text warps. Keep headlines out of the video and add them in editing.

## Use-case guides

Read every guide that matches the job before you write the prompt (a vertical UGC ad matches two).

| Making | Read |
|---|---|
| Product videos, packshots in motion, food and drink, app promos | `references/product.md` |
| UGC ads, talking heads, testimonials, spokesperson lines | `references/ugc-ads.md` |
| Fashion films, lookbooks, beauty, models | `references/fashion.md` |
| Transformations, reveals, freezes, transitions, loops | `references/effects-and-transitions.md` |
| Reels, TikToks, Shorts, vertical hooks | `references/social-vertical.md` |
| Reference images and videos, motion transfer, editing a clip | `references/edits-and-references.md` |

## Check the clip

Watch it, or if you can't, look at its frames and measure it:

```bash
ffmpeg -y -loglevel error -i clip.mp4 -vf fps=1,scale=480:-1,tile=5x2 -frames:v 1 sheet.png
ffprobe -v error -show_entries format=duration:stream=codec_type -of compact clip.mp4
ffmpeg -i clip.mp4 -vf "select='gt(scene,0.1)',showinfo" -f null - 2>&1 | grep -o 'pts_time:[0-9.]*'
ffmpeg -i clip.mp4 -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```

The first makes one contact sheet, a frame per second; its 10 cells cover the longest clip. View the PNG. The second shows the length and whether the clip has sound. The third prints the moments where the picture jumps: cuts, or a sky or light that suddenly changes; a fast camera move can print too, so look at the frames around each time. The fourth measures the sound: a mean far below -30 dB means the track is nearly silent.

The sheet is too small for garments, labels and faces: also look at full-size frames before and after the moment (`ffmpeg -ss 5 -i clip.mp4 -frames:v 1 f5.png`). Check what you asked for: the right person and look, the thing that changes changed (and nothing new appeared instead), motion in the last seconds, no drift on the product, no captions nobody asked for. Tell the user what you checked.

## Finding past results

- Find a job: `halleyfy jobs --search "<words>" --since 7d`.
- Download it again: `halleyfy job <id> -o <dir>`.
- Results are kept 30 days, then deleted.

## Spending

Videos are priced per second, so many cost more than $1.

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

- A person, product or place with no description in a prompt-only clip: the model invents one.
- "X turns into Y" without saying it is X itself that changes, and how: new objects appear next to X.
- Nothing named after the main event: the last seconds stand still.
- No line about music or speech: the model picks its own.
- An action and the change during it split into two steps: the action happens twice.
- "Cinematic", "epic", "stunning" instead of the actual light, lens and palette.
- Generic bans and long lists of what stays the same: they add nothing, and "everything stays still" freezes the clip.
- Times on every step when the order is enough, or frame-by-frame choreography.
- Describing the start image again instead of what moves.
- References with no binding lines: the model guesses which image is what.
- Several edits in one `--video` instruction.
- Length, aspect or resolution written in the prompt instead of the flags.
- An end frame generated separately instead of edited from the start frame.
- Starting a vertical video from a 16:9 image, or the reverse: it gets cropped.
