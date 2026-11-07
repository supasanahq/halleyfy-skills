# Lip-sync and dubbing

For making a person in a clip say new words, fixing a clip's dialogue, and putting a video into another language with each speaker's own voice. `halleyfy lipsync` moves the lips in a video to a new sound. `halleyfy dub` translates the speech and, for a video, also moves the lips to the new words.

## New words: speak, then lipsync

Make the line first, then move the lips to it:

```bash
halleyfy speak "Welcome back! Day three, and my skin is glowing." --voice <name> --json
halleyfy lipsync clip.mp4 --audio <speak job id> --dry-run --json
```

- Tell the person the price from the dry run, and run it only after a yes: `halleyfy lipsync clip.mp4 --audio <speak job id> --json --out ./assets`.
- `--audio` takes a speak job's id, a sound file (.mp3, .wav or .m4a), a local video (its sound is used; this needs ffmpeg) or a sound's `file_…` id.
- The result is `<job id>-0.mp4`: the clip with the new sound and the lips moved to it.
- Match the line to the clip. Speech runs about 2.5 words a second, so a 5 s shot holds about 12 words. Check the line's length before the lip-sync: `ffprobe -v error -show_entries format=duration -of csv=p=0 <speak file>`.
- `--fit cut` (the default) ends at whichever is shorter, so a line longer than the clip is cut off mid-word. For a longer line over a short shot, use `--fit loop`: the video loops to the sound's length. Look at the joins, since a loop can show a jump.
- `halleyfy speak --help` lists the voices; the `halleyfy-audio` skill tells you how to pick one and write the line.

## Fixing a clip's dialogue

A generated clip said the wrong words, or mumbled them:

1. Read what it says with `halleyfy watch clip.mp4` (`transcript.md` has the times).
2. Write the corrected line, at the same length or shorter.
3. `speak` it in a voice close to the clip's: same gender, age and energy.
4. `lipsync` the clip with it, as above.

To keep the words and change only the voice, use `revoice` (the `halleyfy-audio` skill) instead: the lips already match the words.

Lip-sync bills every second of the result. When the line is in a long clip, cut out the part with the line first (Cut in `references/watching-and-editing.md`), lip-sync that part, and join it back.

## Dubbing

```bash
halleyfy dub talk.mp4 --to de --dry-run --json
```

- A video gives one file, `<job id>-0.mp4`: the video dubbed, with the lips moved to the new words. It can be at most 10 minutes long; cut a longer one into parts and dub each.
- `--no-lipsync` gives the dubbed video with its original picture instead, at a fraction of the price, with no length limit. Use it when no mouth is on screen: a voice-over, a screen recording, a product shot with a narrator. It takes fewer languages (the last list in `halleyfy dub --help`).
- A sound file (.mp3, .wav, .m4a) gives the dubbed sound, `<job id>-0.mp3`, in the same fewer languages.
- `--to` takes regional codes too, such as `es-MX`, `pt-BR` or `en-GB`, for a lip-synced video. `halleyfy dub --help` lists every code.
- `--from <code>` helps when detection might guess wrong, for example in a short clip or a mix of languages. It takes a code without a region, such as `es`.
- `--speakers <n>` (1-50) helps the same way, but only with `--no-lipsync` or a sound: a lip-synced dub always finds the speakers itself. Each speaker keeps their own voice in the new language.
- For several languages, quote each and add the prices up for the person. After a yes, start each with `--no-wait --json` and collect each with `halleyfy job <id> --wait --json --out <dir>`.
- Check each one: `halleyfy watch <dir>/<job id>-0.mp4 --language <code>`. Its transcript should be in the new language and say what the original said.

## Time

Lip-sync is slow: about half an hour per minute of video, and a minute or two even for a few seconds. A lip-synced dub of a short clip takes a few minutes; dubbing without lip-sync takes under a minute. For anything longer than a few seconds, start with `--no-wait --json`, tell the person it may take a while, and collect it later with `halleyfy job <id> --wait --json --out <dir>`.

## Faces

- One clearly visible face works best. Close-ups, side angles and a partly covered mouth are fine.
- Shots with no face are still processed and billed. Find them on the `watch` sheets and cut them out with ffmpeg before you lip-sync, to save money. For a dub of a video with few faces, `--no-lipsync` may be all it needs.

## Checking

Before you hand it over, look at the frames around the speech with `halleyfy watch <file> --at <span>`, for example `--at 0:01-0:04`. The mouth should open and close with the words, with no smearing around the lips and teeth. Read the transcript to check the words. Tell the person what you checked.

## Costs

- Lip-sync is about $10.40 a minute ($0.17 a second) of the result, counted in started seconds.
- A lip-synced dub is about $14 a minute ($0.23 a second) of the video, counted in started seconds. Dubbing with `--no-lipsync`, or a sound, is $0.78 per started minute. A 30 s video is about $7.02 lip-synced and $0.78 with `--no-lipsync`.
- Quote every `lipsync` and `dub` with `--dry-run`, even under $1. Tell the person the price, and run only after a yes.
- A long lip-sync or dub can be over the key's per-job limit (exit 2). Tell the person the price and the limit; they can raise it in the dashboard.
