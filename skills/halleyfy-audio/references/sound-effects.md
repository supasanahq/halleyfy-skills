# Sound effects: one sound, an ambience loop, a soundtrack for a clip

For the sounds a clip needs and nobody recorded: a door, rain, footsteps, a room's hum, or a whole soundtrack under a silent or generated clip. `halleyfy sound` makes one effect from a sentence, or a soundtrack from what a clip shows. ffmpeg then lays the result into the clip. Check every result before handing it over (see "Listen before handing it over").

## Describe a sound

A sound is heard, not seen, so write what a microphone would pick up. Five things pin it down:

- **Source**: what makes it. A heavy oak door, a cat, a tin roof.
- **Action**: what it does. Slams shut, scratches, drips.
- **Material**: what it is made of or lands on. Oak, glass, wet gravel. The same action sounds different on each.
- **Space**: where it happens. A stone hallway rings, a carpeted room is dull, an open field has no echo.
- **Distance**: close, mid, far, off screen. Close is dry and loud. Far is soft, with the room in it.

Put them in one sentence: `a heavy oak door slams shut in a stone hallway, short echo, close`. Each one you leave out is left to chance, so give the ones that matter for the shot.

```bash
halleyfy sound "a heavy oak door slams shut in a stone hallway, short echo, close" --seconds 2 --out ./sounds --json
```

- `--seconds` is the length, 0.5 to 30 (default 5). Give a sound the time it takes in life: a door slam is about 2 seconds, a thunder roll 6 to 8.
- The file is saved in `--out` as `<job id>-0.mp3`. stdout is its absolute path; the cost goes to stderr. With `--json`, the path is in `files` and the price is `cost_usd`.
- A take you don't like: run it again. Each run is a new take and costs about a cent (about half a cent for a 2-second effect). When two takes miss in the same way, change the words.

## Prompts that land

Short, with a reason each one works:

1. `a glass is set down on a wooden table, one clink, close`. **One source and one action.** The sound has one thing to be, so it comes out clean, with a clear start and end.
2. `boots on wet gravel, slow steady steps, close`. **A material.** Gravel says what the ground is; "footsteps" alone could be any floor. "Slow steady" gives the rhythm.
3. `a train horn blows twice, far away across an open valley, long faint echo`. **A space and a distance.** Far plus open air gives a soft, spread-out sound that sits behind a scene and not on top of it.
4. `a deep boom in a huge concrete hall, rumbling echo that dies away slowly`. **How to get "epic".** Big is made of parts: a low pitch, a large room, a long tail. Say the parts.
5. `steady rain on a tin roof, close, heard from inside`, with `--loop --seconds 15`. **A loop bed.** Describe a steady state, the same from start to end. An event inside it (a gust, a thunderclap) would come round every 15 seconds, so make those their own effects.

Why a word like "epic" or "cinematic" gives a muddy sound: it names a feeling, not a sound. Hundreds of different sounds fit it, and the result is the average of them, general and blurred. Say what makes the feeling (prompt 4) and the sound follows.

Why a list of five sounds in one prompt is muddy for another reason: they are mixed into one sound, share the same seconds and mask each other, so none is clean. For five sounds, make five effects (each costs about a cent) and place each at its own time (see "Several effects at exact times"). Then you can also move one, or turn one down, without making the rest again.

## Loops

`--loop` makes an effect that repeats without a seam, for ambience under a scene: rain, wind, a room's hum, a forest, a crowd murmur. Use `--seconds 10` to `20`: long enough that the repeat isn't noticed, short enough to cost little.

```bash
halleyfy sound "steady rain on a tin roof, close, heard from inside" --seconds 15 --loop --out ./sounds --json
```

Lay it under a scene for the scene's whole length. `-stream_loop -1` before the sound repeats it for as long as the mix needs, `duration=first` ends the mix with the clip, and `volume=0.4` keeps the bed under the clip's own sound. `normalize=0` keeps each sound at its own level; without it `amix` turns every input down by the number of inputs.

```bash
ffmpeg -y -i clip.mp4 -stream_loop -1 -i rain.mp3 -filter_complex "[1:a]volume=0.4[r];[0:a][r]amix=inputs=2:duration=first:normalize=0[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k out.mp4
```

A clip with no sound track has no `[0:a]`. Take the bed alone and let the clip's length end it:

```bash
ffmpeg -y -i silent.mp4 -stream_loop -1 -i rain.mp3 -filter_complex "[1:a]volume=0.4[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest out.mp4
```

## Several effects at exact times

1. **Find the moments.** `halleyfy watch clip.mp4 --at 0-8` (free) makes a sheet of the span with the time in each tile. Find the tile where the door shuts, then look closer around it (`--at 2.0-2.8`, or one time like `--at 2.35` for a full frame) and take the time of the moment it lands.
2. **Make each effect on its own**, one run per sound, as above.
3. **Mix each in at its time.** `adelay` takes milliseconds, so 2.35 seconds is 2350. Here a door at 2.35 s and thunder, turned down, at 6.1 s:

```bash
ffmpeg -y -i clip.mp4 -i door.mp3 -i thunder.mp3 -filter_complex "[1:a]adelay=2350:all=1[d];[2:a]adelay=6100:all=1,volume=0.6[t];[0:a][d][t]amix=inputs=3:duration=first:normalize=0[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k out.mp4
```

- The clip's own sound (`[0:a]`) stays as it is, and `inputs=` is the number of sounds mixed: the clip's plus one for each effect. `volume=` turns an effect down (`0.6` is 60 %) or up (`1.5` is 150 %) to sit right against the clip's sound.
- `adelay` starts the file at that time. The loud part of an effect is usually at its start, so the hit lands about then; if the effect has a lead-in, the hit lands that much later. Check where it lands (see "Listen before handing it over") and move the number.
- A clip with no sound track: add `-f lavfi -t <its length> -i anullsrc=r=48000:cl=stereo` as the first sound and mix from that. The effects then start at input 2, and the silent track is `[1:a]`:

```bash
ffmpeg -y -i silent.mp4 -f lavfi -t 8 -i anullsrc=r=48000:cl=stereo -i door.mp3 -i thunder.mp3 -filter_complex "[2:a]adelay=2350:all=1[d];[3:a]adelay=6100:all=1,volume=0.6[t];[1:a][d][t]amix=inputs=3:duration=first:normalize=0[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k out.mp4
```

## A full soundtrack for a clip

For a silent clip, or a generated clip whose sound is thin:

```bash
halleyfy sound --video clip.mp4 --dry-run
halleyfy sound --video clip.mp4 --out ./sound --json
```

- The clip is a local .mp4 or .mov, or a `file_…` id, from 1 second to 10 minutes. A URL is not taken. A local clip over 100 MB goes up as a 720p copy; the soundtrack still goes on your original.
- The soundtrack follows the picture: steps when someone walks, a door when it shuts, the room sound of the space. The speech already in the clip is kept.
- It saves `<job id>-0.mp3` (the soundtrack) and, for a local clip, `<job id>-0.mp4`: the same clip with the soundtrack on it. A `file_…` clip gets only the .mp3. Leave `--no-wait` off for a local clip: the soundtrack is put on it when the job is done.
- The prompt is optional. Leave it out and the soundtrack comes from the picture alone.
- After a voice swap with `revoice --clean`, run it on the new clip: it rebuilds the room sound and effects around the new voice.

**Off-screen sounds.** The soundtrack follows what the picture shows, so what the picture doesn't show is yours to add. Say it in the prompt the way you would for an effect, with a source, an action and a distance: `halleyfy sound --video clip.mp4 "distant thunder, a dog barks off screen"`. "Distant" and "off screen" place it behind the scene. To keep sounds out of the result, name them with `--avoid`: `--avoid "music, crowd"`.

**`--no-speech`** is for a clip whose old dialogue should go: a voice you will replace with a `speak` voiceover, or speech that is wrong. Without it the speech stays.

**`--variations 2`** makes two soundtracks to pick from (up to 4), each billed. They are saved as `<job id>-0` and `<job id>-1`, an .mp3 and an .mp4 each (a `file_…` clip gets only the .mp3 files). Look at each with `halleyfy watch <file> --at <span>` and pick one.

## Costs

- An effect costs about $0.0026 a second: $0.013 for 5 seconds.
- A soundtrack costs about $0.013 a second of video for each variation: $0.13 for a 10-second clip, $0.26 for two variations of it.
- `--dry-run` prints the price: the most the run can cost. The charge is what the model really cost plus halleyfy's margin, never more than that. `--max-cost <usd>` refuses a run above that price (exit 2).
- Several effects cost their seconds added up, still cents. A soundtrack for a long clip is the one to price first.

## Listen before handing it over

You can't play a clip, so measure it and read it. Three steps, the first two free.

**1. An effect on its own, before you mix it in.** It has no words, so there is no transcript to read: check its length and that it isn't silent.

```bash
ffprobe -v error -show_entries format=duration -of csv=p=0 door.mp3
ffmpeg -i door.mp3 -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```

The length should be within about 0.05 s of the `--seconds` you asked for (2.0 for the door slam; a 2.5 s effect can come back 2.48 s). A `mean_volume` and `max_volume` far above -91 dB mean there is sound in it; -91 dB is silence. A take that is silent or farther off than that: run it again.

**2. The mixed clip, around the effect's time** (here the door at 2.35 s):

```bash
ffprobe -v error -show_entries stream=codec_type,codec_name,duration -of compact out.mp4
halleyfy watch out.mp4 --at 2-3
ffmpeg -ss 2.3 -t 0.5 -i clip.mp4 -vn -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
ffmpeg -ss 2.3 -t 0.5 -i out.mp4 -vn -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```

- **`ffprobe`**: one video stream and one aac stream, as long as the clip give or take a frame.
- **`watch --at` (free).** The sheet's loudness strip is drawn in 0.1 second steps, but it is short, so a few dB on top of loud speech is about one pixel. The loudest seconds are whole seconds. Both show an effect that stands out from what is around it: a bed, a thunder roll, a door in a quiet moment or a silent clip (its second is the loudest). An effect under loud speech needs the `volumedetect` check.
- **`volumedetect` on a short window around the effect (free)**, on the original clip and then on the result. Over that window the result's `mean_volume` should be higher than the original's (in the door example, from -22.2 to -19.6 dB). Its `max_volume` should stay under 0 dB: at 0.0 the mix clips, so turn the effect, or the clip's own sound, down with `volume`. A clip with no sound has no original to compare: the result's level should be well above -91 dB.

**3. The whole result, once** (paid, like any `watch`: about $0.01 per started minute of sound, at least one minute; `--dry-run` shows the price):

```bash
halleyfy watch out.mp4
```

`summary.md` lists the loudest moments, and `transcript.md` should still hold the speech, every word in order and clear. A word that went missing or got buried means the effect or the bed is too loud: mix again with a lower `volume`.

With soundtracks from `--variations`, check each one. If an effect lands early or late, change the `adelay` number and mix again. Tell the user what you checked.

## ffmpeg

ffmpeg is needed for a local `--video` (the soundtrack is put on the clip with it) and for every mix above. `sound` with only a prompt needs none. If the error is `ffmpeg_missing`, tell the user that ffmpeg is needed and ask which way they want to get it:

- their package manager: `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Debian, Ubuntu);
- or `halleyfy ffmpeg install`, which downloads a checked ffmpeg and ffprobe into `~/.config/halleyfy/bin` (about 80 MB) for halleyfy only.

Run the one they pick only after a yes, then run the command again. Installed by halleyfy, ffmpeg is not on the PATH: in the commands above, write `~/.config/halleyfy/bin/ffmpeg` and `~/.config/halleyfy/bin/ffprobe` instead of `ffmpeg` and `ffprobe`.
