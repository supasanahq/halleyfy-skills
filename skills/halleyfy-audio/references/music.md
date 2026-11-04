# Music: a bed under a video, a song with words, a score fitted to a clip

For the music a project needs and nobody wrote: a track under a product demo, a song that sings the user's words, or a score that follows a clip's pacing. `halleyfy music` makes one track per run. ffmpeg then cuts a bed to length or mixes a score into a clip. Check every result before handing it over (see "Before handing it over").

## Which mode

Four jobs, four prices. A price is per track and is the most a run can cost. The charge is what the model really cost plus halleyfy's margin, never more than that. `--dry-run` shows the live price.

| The job | Run | Price |
|---|---|---|
| A bed under a video: music with no words | `halleyfy music "<style>"` | $0.195 |
| A song that sings the user's words | `halleyfy music "<style>" --lyrics-file song.txt` | $0.195 |
| A song when the user has no words | `halleyfy music "<style>" --vocals any` | $0.65 |
| A score fitted to a clip | `halleyfy music --video clip.mp4 "<style>"` | $0.143 |

- **An instrumental** is for under a video. It comes back at its own length, a few minutes (217 s in one check). `--seconds <n>` cuts it to a short bed (see "A short bed").
- **A song from lyrics** is for when the words matter. They are sung as you wrote them, and the prompt sets the style.
- **A song from a prompt** is for a person who wants a song and has no words. The model writes the words. It costs more than three times a song from lyrics: run `--dry-run`, tell the user the price, then run it.
- **A score for a clip** is made for that clip: it runs as long as the clip and the CLI mixes it in.
- **Vocals.** `--vocals female` or `male` need lyrics, and are refused without them. `--vocals any` is the only way to a song from a prompt alone: describe the voice in the prompt ("a warm female vocal").
- **Song length.** A song is 120 to 300 seconds. `--seconds 120` to `300` is the length it aims for, and songs often run longer (asked for 120, one came back at 228). With lyrics and no `--seconds`, the lyrics decide. Measure the file, and don't plan a cut on the exact second.

Files are saved in `--out` as `<job id>-0.mp3`. stdout is one absolute path per line; the cost goes to stderr. With `--json`, the paths are in `files` and the price is `cost_usd`. Use those paths in the next command.

## Prompting music

The prompt is the style. Name what a producer would ask for:

- **Genre**: lo-fi hip hop, cinematic ambient, acoustic folk, synth-pop.
- **Mood**: relaxed, tense, hopeful, playful.
- **Tempo**, in bpm: `80 bpm`. A number says more than "slow".
- **Instruments**: soft Rhodes, brushed drums, a low pulse, fingerpicked guitar.
- **Era and production**: "dusty 90s boom-bap, vinyl crackle, warm tape saturation".
- **Structure**: how it moves, and when. "Starts sparse with keys, drums at 0:15, builds to a full chorus at 0:40, ends on a held chord."
- **The use**: "for a product demo". A bed under speech wants a steady, sparse arrangement.

Each one you leave out is left to chance, so give the ones that matter. Say what the music has and when it has it. Treat the times as a hint, not a promise. A prompt takes up to 1,024 characters, and up to 2,000 for a song from a prompt.

## Prompts that land

Short, with the reason each one works:

1. `warm lo-fi hip hop, 80 bpm, soft Rhodes, brushed drums, vinyl crackle, relaxed, for a product demo`. **An instrumental with every part named.** Genre, tempo, instruments, texture, mood and use leave little to chance.
2. `cinematic ambient, slow strings and a low pulse, building tension, no drums until 1:00`. **A shape in time.** Cinematic is a feeling, so the prompt says what makes it: slow strings, a low pulse, and when the drums come in. Run it with `--seconds 90`, so the bed is long enough to hold the build.
3. `acoustic folk, 92 bpm, fingerpicked guitar, warm and hopeful`, with `--lyrics-file song.txt --vocals female`. **A song from lyrics.** The words come from the file, so the prompt is only the style: genre, tempo, instrument, mood.
4. `an upbeat pop song about a summer road trip, bright female vocal, handclaps, 118 bpm, big singalong chorus`, with `--vocals any --seconds 150`. **A song from a prompt.** The model writes the words, so give it the subject and describe the voice here.

## Lyrics

```
[Verse]
Windows down, the road is wide
Sun on the dash, you by my side

[Chorus]
Take me where the highway ends
Me and you and all our friends
Take me where the highway ends

[Verse]
Gas station coffee, a song we know
Singing it loud as the white lines flow

[Chorus]
Take me where the highway ends
Me and you and all our friends
Take me where the highway ends
```

```bash
halleyfy music "acoustic folk, 92 bpm, fingerpicked guitar, warm and hopeful" --lyrics-file song.txt --vocals female --out ./music --json
```

- **Tags** `[Verse]`, `[Chorus]` and `[Bridge]` mark the sections and pass through to the model.
- **Short lines, one idea per line.** Each line is one phrase to sing.
- **A chorus that repeats word for word.** Write it out in full every time it comes back, with the same words, and not as a note like "repeat chorus".
- **The prompt sets the style**, not the words: genre, tempo, instruments, mood. Don't put lyrics in it.
- Up to 5,000 characters. Put them in a `--lyrics-file`, where the shell can't change a quote, a `$` or a leading `-`. `--lyrics "<text>"` takes them inline.
- Keep the words the user gave you, and add no claims they didn't give (prices, results, guarantees).

## A short bed

An instrumental comes back at its own length, so ask for the length the clip needs:

```bash
halleyfy music "warm lo-fi hip hop, 80 bpm, soft Rhodes, brushed drums, vinyl crackle, relaxed, for a product demo" --seconds 30 --out ./music --json
```

- `--seconds` is any whole number of seconds, 1 or more. The track is cut here to that length with a 2 second fade at the end, and the `.mp3` you get is the short one.
- The full track stays in the job. `halleyfy job <id> -o <dir>` downloads it.
- A track already shorter than `--seconds` is left as it is.
- Cutting needs ffmpeg. `--no-wait` doesn't work with it, since the cut is made here when the job is done.
- For a song `--seconds` means something else: the length the model aims for, not a cut.
- If the cut stops with `ffmpeg_failed`, the job is done and charged, and the message names the saved full track. Don't run it again (that pays twice): cut the saved track with the command in "Cutting a long track on a quiet moment".

## Fitting music to a clip

```bash
halleyfy music --video ./clip.mp4 "bright, upbeat, light percussion" --dry-run
halleyfy music --video ./clip.mp4 "bright, upbeat, light percussion" --out ./music --json
```

- The clip is a local .mp4 or .mov up to 100 MB, of any length, or a `file_…` id. A URL is not taken. Leave `--no-wait` off for a local clip: the music is mixed in when the job is done.
- The prompt is optional. It sets the style and the mood; the clip carries the pacing.
- It saves `<job id>-0.mp3` (the music) and, for a local clip, `<job id>-0.mp4` (`.mov` for a .mov clip): the clip with the music 12 dB under its own sound, faded out over the last 2 seconds. A `file_…` clip gets only the .mp3, since there is no clip here to mix into. Use the paths the CLI prints, or `files` with `--json`.
- **`--replace`** makes the music the clip's only sound. Use it when the clip has no speech worth keeping: a product turntable, a b-roll montage. Never use it over someone talking. A clip with no sound at all always gets the music alone.
- The music runs as long as the clip. The `.mp3` is about the clip's length (it can run a second longer), and the `.mp4` is exactly the clip's length. A clip under 3 seconds gets 3 seconds of music, and the mix cuts it to the clip. A clip longer than about 3 minutes gets music for its start only: the CLI prints a note that the music ends before the clip does.
- If the run stops with `ffmpeg_failed` after the job is done, the job is charged and the message names the files it saved. Don't run it again: that pays twice. Mix the saved .mp3 yourself (see "Another level").

## Another level

The mix puts the music 12 dB under the clip's own sound. For another level, mix the saved .mp3 under the original clip yourself. Here it is 18 dB under, faded out over the last 2 seconds (`st` is the clip's length minus 2: 8 for a 10 second clip):

```bash
ffmpeg -y -i clip.mp4 -i <job id>-0.mp3 -filter_complex "[1:a]volume=-18dB,afade=t=out:st=8:d=2[m];[0:a][m]amix=inputs=2:duration=first:normalize=0[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k out.mp4
```

- `volume=-18dB` turns the music down by 18 dB. A bigger number is quieter: -12 is the CLI's mix, -18 is a good start under speech, -6 is louder. Check the result (see "Before handing it over"), and move the number if a word is buried.
- On a mono clip the stereo music is mixed down to mono, which adds up to about 3 dB (it depends on how much of the music sits in the middle of the stereo image; one track measured 2.7 dB). The music then lands up to 3 dB louder than the number: use about `-21dB` for the level `-18dB` names. To tell a mono clip, `ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 clip.mp4` prints `1`.
- `normalize=0` keeps each sound at its own level; without it `amix` turns every input down by the number of inputs. `duration=first` ends the mix with the clip.
- Give `out` the clip's own extension: `out.mov` for a `.mov` clip.
- A clip with no sound track has no `[0:a]`. Take the music alone. `apad` pads the music with silence, so a clip longer than the music keeps its whole picture, and `-t` ends the file at the clip's length (`st` is that minus 2; get the length with the `ffprobe` command in "Before handing it over"). Here the clip is 10 seconds:

```bash
ffmpeg -y -i silent.mp4 -i <job id>-0.mp3 -filter_complex "[1:a]volume=-6dB,afade=t=out:st=8:d=2,apad[a]" -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -t 10 out.mp4
```

## Cutting a long track on a quiet moment

`--seconds` cuts on the second you pick. To cut where the music is quietest, find the gaps first:

```bash
ffmpeg -i track.mp3 -af silencedetect=noise=-35dB:d=0.4 -f null - 2>&1 | grep silence_
```

Each gap prints as `silence_start` and `silence_end`, in seconds. A number closer to 0 (`-30dB`, `-25dB`) counts softer sound as quiet too. Music rarely goes fully quiet: in one check a track with vinyl crackle showed only its own ending, even at `-25dB`. With no gap in the middle, use `--seconds`, which cuts on the second you pick with a 2 second fade.

`halleyfy watch` also lists quiet gaps, but only the long ones. Its `summary.md` has a "Quiet gaps" list of gaps of 2 seconds or more, and `signals.json` holds the loudness of each second. It reads videos, so it suits a clip you have mixed; for a bare .mp3, `silencedetect` is free and finer.

Cut at the gap with a short fade. Here the cut is at 62 seconds and the fade covers the last 2 (`-t` is the cut, `st` is the cut minus 2):

```bash
ffmpeg -y -i track.mp3 -t 62 -af "afade=t=out:st=60:d=2" -c:a libmp3lame -b:a 192k cut.mp3
```

## Before handing it over

You can't listen to it, so measure it and read it.

1. **Length.** `ffprobe -v error -show_entries format=duration -of csv=p=0 <file>`. A trimmed instrumental is its `--seconds`. A soundtrack `.mp4`, or your own re-mix, is the clip's length give or take a frame. A song is whatever it came to: say how long.
2. **A song's words.** Wrap the .mp3 in a black video and watch it, the way SKILL.md's "Check the result" says. Read `transcript.md` against the lyrics: the lines in order, the chorus coming back. A word or two off in singing isn't a fail. A missing or swapped verse is a fail: tell the user what another take would cost before you run one. A transcript that shows only tags like `(music)` and no words is inconclusive, not a fail: say so to the user, and don't take it again on that alone.
3. **A mixed clip.** `halleyfy watch <file>`. The speech from the clip should still be in the transcript, every word in order, with the music under it. A word that went missing or got buried means the music is too loud: mix again with a lower `volume` (see "Another level").
4. **An instrumental has no words**, so there is no transcript to read. Check that it isn't silent, for free:

```bash
ffmpeg -i bed.mp3 -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```

A `mean_volume` far above -91 dB means there is sound in it; -91 dB is silence.

5. **The mood**, once, when the user cares about it (paid: `--dry-run` shows the price): `halleyfy watch <video> --ask "What is the mood of the music?"`. `<video>` is the mixed .mp4, or a bare .mp3 wrapped in a black video. Read the answer against the prompt.

Tell the user what you checked.

## ffmpeg

ffmpeg is needed for a local `--video` (the music is mixed in with it), for an instrumental's `--seconds`, and for the commands above. `music` with only a prompt or lyrics needs none. If the error is `ffmpeg_missing`, tell the user that ffmpeg is needed and ask which way they want to get it:

- their package manager: `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Debian, Ubuntu);
- or `halleyfy ffmpeg install`, which downloads a checked ffmpeg and ffprobe into `~/.config/halleyfy/bin` (about 80 MB) for halleyfy only.

Run the one they pick only after a yes, then run the command again. Installed by halleyfy, ffmpeg is not on the PATH: in the commands above, write `~/.config/halleyfy/bin/ffmpeg` and `~/.config/halleyfy/bin/ffprobe` instead of `ffmpeg` and `ffprobe`.
