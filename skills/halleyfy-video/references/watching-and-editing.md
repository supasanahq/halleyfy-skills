# Watching and editing a video

For seeing and hearing a video you can't play: what happens when, who says what, where the best moment is, whether a clip you made came out right, and cutting a part out with ffmpeg. `halleyfy watch` turns a video into files you can read: contact sheets with times, a transcript with word times, shots and loudness.

## Watch

```bash
halleyfy watch ./talk.mp4
```

It takes a local video file or a video job id (`job_…`), of any length, and writes `./watch/<name>/` (or `--out <dir>`). stdout is the path of `summary.md`. A sound file (`.mp3`, `.wav`, `.m4a`) works too, with a transcript and loudness but no sheets: the halleyfy-audio skill says how to check one.

Read in this order:

1. **`summary.md` first.** Length, size, sound, which sheet covers which times, every shot, the loudest moments, the quiet gaps, the motion spikes and the sound events. Its "Look closer" block has ready-to-run commands with this video's real times.
2. **The sheets it names**, `sheets/1.jpg`, `sheets/2.jpg` …: up to 25 tiles each (24 for portrait video), the time in each tile's top-left corner, a loudness strip under each tile, and a yellow bar on the first tile of each shot.
3. **`transcript.md`**: one line per phrase, `[m:ss.s] S1: text`. S1, S2 … are the speakers in the order they first speak. Sound events like `(laughter)` or `(applause)` are on their own line.

The other files:

| File | Holds |
|---|---|
| `transcript.json` | Every word with its start and end in seconds: `words: [{ text, start, end, type, speaker_id }]`, where `type` is `word`, `spacing` or `audio_event`. Use it to cut. |
| `shots.json` | `[{ "start", "end" }]`, one per shot. |
| `signals.json` | Loudness per second (dBFS), the silences, and motion per second (0 to 1). |
| `asks.md` | Every `--ask` question with its answer, date and cost. |
| `meta.json` | The source file, its length and the transcript job. |

Running `watch` again on the same unchanged file reuses all of it and costs nothing. `--fresh` makes everything again. If a run was cut off, the next run picks up its paid transcript instead of paying again.

## Look closer

The overview sheets have one tile every second or more. Before you say what happens at a given time, look at it with `--at`:

```bash
halleyfy watch ./talk.mp4 --at 1:20-1:35   # a dense sheet of the span
halleyfy watch ./talk.mp4 --at 1:21.3      # one full-size frame
```

- A span makes `sheets/at-<from>-<to>.jpg` and a `.md` with that span's transcript lines, cuts and loudest seconds.
- One time makes `frames/<time>.jpg`, e.g. `frames/1m21.3s.jpg`. Use it for faces, labels, garments and text, which are too small on a sheet.
- Times are `ss.s`, `m:ss.s` or `h:mm:ss.s`.
- `--at` is free, and on a local file it needs no key and works before any overview.

## Ask

For "when does X happen" in a long video, where reading every sheet would take too long:

```bash
halleyfy watch ./talk.mp4 --ask "When does the speaker first hold up the bottle?"
```

- It looks at the picture and hears the sound of the whole video and answers with times. Videos up to 60 minutes.
- The answer is printed and kept in `asks.md`. It uploads a small copy once and reuses it for later questions.
- **Its times can be wrong.** Check every time it gives with `--at` (a frame, or a few seconds around it) before you use it or tell the user.

## Cut

1. **Find the words** in `transcript.md`, then their exact times in `transcript.json`. With `jq`, list the words in a few seconds around the line:

   ```bash
   jq -r '.words[] | select(.type=="word" and .start>=14 and .start<=20) | "\(.start) \(.end) \(.speaker_id) \(.text)"' watch/talk/transcript.json
   ```

   `speaker_id` is the same speaker as S1, S2 … in `transcript.md`, under another name. Also note where the word just before the cut ends and where the word just after it starts.
2. **Pad the cut:** start = the first word's `start` minus 0.15 s, end = the last word's `end` plus 0.25 s. If that reaches into a word you don't want, pad less on that side. If a shot starts or ends inside the padding (`shots.json`), move that side to the shot's start or end, or the cut opens or closes on a few frames of the other shot.
3. **Cut, re-encoding** so the cut lands exactly on those times:

   ```bash
   ffmpeg -y -ss 14.80 -to 18.30 -i in.mp4 -c:v libx264 -pix_fmt yuv420p -c:a aac out.mp4
   ```

   `-c copy` would be faster, but it can only start on a keyframe, so the cut starts early or late. `-pix_fmt yuv420p` keeps the cut playable everywhere, phones and browsers included.
4. **Check the cut:**
   - `ffprobe -v error -show_entries format=duration -of csv=p=0 out.mp4`: the length should be end minus start, give or take a frame.
   - `halleyfy watch out.mp4 --at 0-3.5` (free), with the cut's length as the span's end: a sheet of the whole cut, to see it starts and ends on the right picture. Its `.md` lists the cuts inside: one in the first or last few tenths of a second means a sliver of another shot got in.
   - `halleyfy watch out.mp4` (paid, like any overview): its `transcript.md` should hold exactly the words you wanted, the first one not clipped and nothing of the line before or after.

To cut several parts and join them, cut each one as above, then join them with the concat demuxer: list them in `parts.txt` as `file 'a.mp4'` lines and run `ffmpeg -f concat -safe 0 -i parts.txt -c copy joined.mp4`.

## The best moment of a 60-minute video

1. `halleyfy watch ./talk.mp4`, then read `summary.md`.
2. Make a list of candidates from it: the loudest moments, the sound events (laughter, applause) and the motion spikes.
3. `halleyfy watch ./talk.mp4 --ask "What are the three most striking moments, with start and end times?"`, and add its answers to the list.
4. Look at each candidate with `--at` (a span from a few seconds before to a few seconds after), and read its lines in `transcript.md`.
5. Pick one. Say why, with the times.
6. Cut it on word times (above), so it starts and ends on whole sentences.
7. Watch the cut before handing it over.

## Costs

- Watching costs about $0.01 per started minute of sound, at least one minute. A video with no sound, or only silence, costs nothing.
- `--at` is free.
- `--ask` costs about $0.008 per minute of video, at least about $0.02. Each question is paid.
- A rerun on an unchanged file costs nothing.
- `--dry-run` prints the price without running. `--max-cost <usd>` refuses a run above that price (exit 2).

## ffmpeg

`watch` makes sheets, shots and loudness on this machine with ffmpeg. If the error is `ffmpeg_missing`, tell the user that ffmpeg is needed and ask which way they want to get it:

- their package manager: `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Debian, Ubuntu);
- or `halleyfy ffmpeg install`, which downloads a checked ffmpeg and ffprobe into `~/.config/halleyfy/bin` (about 80 MB) for halleyfy only.

Run the one they pick only after a yes, then run `watch` again. Installed by halleyfy, ffmpeg is not on the PATH: in the cut commands, write `~/.config/halleyfy/bin/ffmpeg` and `~/.config/halleyfy/bin/ffprobe` instead of `ffmpeg` and `ffprobe`.
