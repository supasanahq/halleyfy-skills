# Music: a bed under a video, a short intro, a song with words, a score fitted to a clip

For the music a project needs and nobody wrote: a track under a product demo, a 15 second intro, a song that sings the user's words, or a score that follows a clip's pacing. `halleyfy music` makes one track per run. ffmpeg then cuts a bed or an intro to length or mixes a score into a clip. Check every result before handing it over (see "Before handing it over").

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
- **Tempo**, in bpm: `80 bpm`. A number says more than "slow". It sets the feel, not the exact speed (see "When the tempo matters").
- **Instruments**: soft Rhodes, brushed drums, a low pulse, fingerpicked guitar. Say which one leads.
- **Era and production**: "dusty 90s boom-bap, vinyl crackle, warm tape saturation".
- **Structure**: how it moves, and when. "Starts sparse with keys, drums at 0:15, builds to a full chorus at 0:40, ends on a held chord."
- **The use**: "for a product demo". A bed under speech wants a steady, sparse arrangement.

Each one you leave out is left to chance, so give the ones that matter. Say what the music has and when it has it. Treat the times as a hint, not a promise. A prompt takes up to 1,024 characters, and up to 2,000 for a song from a prompt.

### Name the band for an older style

A style with a long history has more than one sound, and a genre word alone lets the model pick any of them. `upbeat swing jazz` came back as gypsy jazz led by a violin. Naming the line-up and what leads it got a real big band:

`classic 1950s big band swing jazz, 150 bpm, a loud saxophone section and blaring trumpets playing a punchy riff from the first bar, walking upright bass, swinging ride cymbal, piano comping, brass-led, no violin, no guitar, instrumental`

- **The era and the size of the band**: "classic 1950s big band", not "jazz".
- **The lead instruments, loud**: "a loud saxophone section and blaring trumpets". Say which ones carry the tune, and say it again at the end ("brass-led").
- **The rhythm section**, the way that era played it: "walking upright bass, swinging ride cymbal, piano comping".
- **The cousin it could drift to**, named by its instruments: big band and gypsy jazz are both swing, so "no violin, no guitar" pointed the take at the big band.

The same goes for blues, rock and roll, disco, soul, funk or any style with a few classic sounds: say which decade, which band, and which instrument leads.

### Sing in the genre's language

Part of a genre's sound is its words. A K-pop song with English-only lyrics came back as generic pop. The same style with Korean lyrics and an English hook ("Turn it up, 오늘 밤") sounded like K-pop. Write the lyrics in the language the genre is sung in, mixed the way the genre mixes it (K-pop: Korean lines, English hook words), and say it in the prompt too: `glossy bright female vocals singing in Korean with English hooks`. If the user's own words are in another language, offer a version in the genre's language that keeps their hook, and use it once they agree.

### When the tempo matters

The bpm in the prompt is a hint. The track picks its own tempo, sometimes close and sometimes far:

| Asked for | Came back |
|---|---|
| lo-fi hip hop, 80 bpm | 86 bpm |
| 80s synthwave, 100 bpm | 136 bpm |
| orchestral trailer, 90 bpm | 136 bpm |
| big room EDM, 128 bpm | 129 bpm |

- Tell the user the feel ("a fast swing, around 150 bpm"), not an exact number.
- When the tempo has to match something (cuts on the beat, a voiceover's rhythm, another track), measure the file. A beat tracker gives the real tempo and the time of each beat: `aubio tempo track.mp3`, or `librosa.beat.beat_track` in Python. If none is installed, ask the user before installing one. Plan the cut on what you measured.

## Prompts that land

Short, with the reason each one works:

1. `warm lo-fi hip hop, 80 bpm, soft Rhodes, brushed drums, vinyl crackle, relaxed, for a product demo`. **An instrumental with every part named.** Genre, tempo, instruments, texture, mood and use leave little to chance.
2. `cinematic ambient, slow strings and a low pulse, building tension, no drums until 1:00`. **A shape in time.** Cinematic is a feeling, so the prompt says what makes it: slow strings, a low pulse, and when the drums come in. Run it with `--seconds 90`, so the bed is long enough to hold the build.
3. `acoustic folk, 92 bpm, fingerpicked guitar, warm and hopeful`, with `--lyrics-file song.txt --vocals female`. **A song from lyrics.** The words come from the file, so the prompt is only the style: genre, tempo, instrument, mood.
4. `an upbeat pop song about a summer road trip, bright female vocal, handclaps, 118 bpm, big singalong chorus`, with `--vocals any --seconds 150`. **A song from a prompt.** The model writes the words, so give it the subject and describe the voice here.
5. `bright K-pop girl group dance pop, 120 bpm, punchy synths, snappy trap-pop drums, glossy bright female vocals singing in Korean with English hooks`, with `--lyrics-file song.txt` (the lyrics in "Start on the chorus"). **A sung genre in its own language.** The lyrics are Korean with an English hook, and the prompt says so.

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

### Start on the chorus

The model follows the order of the sections in the lyrics more than a line in the prompt: "the chorus comes in right away" in the prompt doesn't reliably bring it forward. To hear the hook early, put `[Chorus]` first, before the first `[Verse]`:

```
[Chorus]
Turn it up, 오늘 밤
반짝이는 모든 빛
Turn it up, 같이 날아
네온 하늘 위로

[Verse]
불이 켜지면 심장이 뛰어
멈출 수 없어 나 너에게로

[Chorus]
Turn it up, 오늘 밤
반짝이는 모든 빛
Turn it up, 같이 날아
네온 하늘 위로
```

The track may still open on a few bars of music before the first word. Find where the chorus really lands by listening: `halleyfy watch song.mp3`, then read the times in `transcript.md` (each sung line starts with its time, like `[0:10.7]`). For a song that isn't in English, give `watch` its language (`--language ko`).

## A short piece: an intro, a sting, an ad bed

A track comes back as a whole piece, 2 to 4 minutes long, for the same price per track. A song is at least 120 seconds (its `--seconds` starts at 120). So a 15 second intro is cut from a full track. Its first seconds are rarely the best ones: a track builds in, and a song plays some bars before the first word. In an eight-genre reel, every cut came from between 0:32 and 2:17 into its track.

Tell the user before the run, in your own words: "Music comes back as a full track of a few minutes. I'll make one, find its best 15 seconds and cut those. You get the full track too."

Three steps, and the second one picks the cut:

```bash
# 1. The full track. Leave --seconds off an instrumental.
halleyfy music "<style>" --out ./music --json
# 2. Listen, and pick <start>: the second the best bars begin.
halleyfy watch ./music/<job id>-0.mp3
# 3. Cut 15 seconds from <start>, with a 2 second fade at the end.
ffmpeg -y -ss <start> -i ./music/<job id>-0.mp3 -t 15 -af "afade=t=in:d=0.05,afade=t=out:st=13:d=2" -c:a libmp3lame -b:a 192k intro.mp3
```

- **`<start>` comes from listening**, so you know it only once the track is made. In a plan you show before the run, keep it as the listening step. A cut from 0 gives the track's build-in, or the bars before the first word.
- **Where to listen for it.** `summary.md` lists the loudest moments and `signals.json` the loudness of each second: the full band is usually where the track gets loud. For a song, `transcript.md` gives each line's time, so the hook starts where its first line lands. For what only an ear can tell, ask with times (see "Before handing it over"): "When does the full horn section first play the riff?"
- **A sting with vocals:** put the chorus first in the lyrics (see "Start on the chorus"), so the hook comes early, then cut from its first line.
- `-t` is the length and `st` is the length minus 2. In one reel the swing cut started at 36.3 seconds.
- The 0.05 second fade in keeps the cut from clicking.
- With a measured tempo (see "When the tempo matters"), start on a beat time from the beat tracker, and pick a length in whole bars when the end has to land: a bar of 4 beats is `240 / bpm` seconds, 1.6 at 150 bpm.

**A bed where the opening will do.** Under a product demo, any stretch of an even track works. There `--seconds` on an instrumental is the short way: it keeps the first n seconds with a 2 second fade. Ask for an opening that is already the piece ("full band from the first bar"). The same up-front word applies: it is a cut from a full track.

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
- **`--replace`** makes the music the clip's only sound. Use it when the clip has no speech worth keeping: a product turntable, a b-roll montage. Never use it over someone talking. A clip with no sound at all always gets the music alone. In both cases the music fades out over the last 2 seconds.
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

`halleyfy watch` also lists quiet gaps, but only the long ones. Its `summary.md` has a "Quiet gaps" list of gaps of 2 seconds or more, and `signals.json` holds the loudness of each second. It takes a bare .mp3 too (`halleyfy watch track.mp3`), but that run pays for a transcript; to find a gap in an instrumental, `silencedetect` is free and finer.

Cut at the gap with a short fade. Here the cut is at 62 seconds and the fade covers the last 2 (`-t` is the cut, `st` is the cut minus 2):

```bash
ffmpeg -y -i track.mp3 -t 62 -af "afade=t=out:st=60:d=2" -c:a libmp3lame -b:a 192k cut.mp3
```

## Before handing it over

You can't listen to it, so measure it and read it.

1. **Length.** `ffprobe -v error -show_entries format=duration -of csv=p=0 <file>`. A trimmed instrumental is its `--seconds`. A soundtrack `.mp4`, or your own re-mix, is the clip's length give or take a frame. A song is whatever it came to: say how long.
2. **A song's words.** `halleyfy watch song.mp3` (add `--language <code>` for a song not in English). Read `transcript.md` against the lyrics: the lines in order, the chorus coming back. A word or two off in singing isn't a fail. A missing or swapped verse is a fail: tell the user what another take would cost before you run one. A transcript that shows only tags like `(music)` and no words is inconclusive, not a fail: say so to the user, and don't take it again on that alone. To read one part again, `halleyfy watch song.mp3 --at 0:40-0:55` (free) gives that span's lines and its loudest seconds.
3. **A mixed clip.** `halleyfy watch <file>`. The speech from the clip should still be in the transcript, every word in order, with the music under it. A word that went missing or got buried means the music is too loud: mix again with a lower `volume` (see "Another level").
4. **An instrumental has no words**, so there is no transcript to read. Check that it isn't silent, for free:

```bash
ffmpeg -i bed.mp3 -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```

A `mean_volume` far above -91 dB means there is sound in it; -91 dB is silence.

5. **What only an ear can tell**: which instrument leads, where the chorus or the words fall, clipping or distortion. Ask once with `--ask` (paid, about $0.004 a minute of sound and at least $0.008, so 1 to 2 cents for a 2 to 4 minute track: `--dry-run` shows the price):

```bash
halleyfy watch song.mp3 --ask "Which instruments carry the melody? Is there any clipping or distortion? Give times."
```

Ask about concrete things, with times, and read the answer against the prompt: "a violin carries the melody" on a big band prompt means another take with the lead named louder (see "Name the band for an older style"). A score out of 10 tells you little: the same cut got 8.5 on one ask and 6.5 on the next. Judge the take on the concrete answers.

Tell the user what you checked.

## ffmpeg

ffmpeg is needed for a local `--video` (the music is mixed in with it), for an instrumental's `--seconds`, and for the commands above. `music` with only a prompt or lyrics needs none. If the error is `ffmpeg_missing`, tell the user that ffmpeg is needed and ask which way they want to get it:

- their package manager: `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Debian, Ubuntu);
- or `halleyfy ffmpeg install`, which downloads a checked ffmpeg and ffprobe into `~/.config/halleyfy/bin` (about 80 MB) for halleyfy only.

Run the one they pick only after a yes, then run the command again. Installed by halleyfy, ffmpeg is not on the PATH: in the commands above, write `~/.config/halleyfy/bin/ffmpeg` and `~/.config/halleyfy/bin/ffprobe` instead of `ffmpeg` and `ffprobe`.
