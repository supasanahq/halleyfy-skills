---
name: halleyfy-audio
description: Use when the user needs a voiceover, narration, a line read aloud, a different voice on a recording or clip, or a clean voice out of a noisy recording, or needs a sound effect, an ambience loop, or a soundtrack for a silent or generated clip, or needs music (an instrumental bed under a video, a short intro, sting or jingle, a song, or a score fitted to a clip), or mentions halleyfy speak, revoice, isolate, sound or music.
allowed-tools:
  - Bash(halleyfy *)
---

# halleyfy audio

Three commands work with a voice:

- `halleyfy speak` turns text into an .mp3, in one of 21 voices.
- `halleyfy revoice` says a recording's words again in another voice, with the same timing. From a video it also saves the video with the new voice.
- `halleyfy isolate` pulls a clean voice out of noisy sound or a video.

A fourth, `halleyfy sound`, makes sound effects and soundtracks (see "Sound effects"). A fifth, `halleyfy music`, makes music (see "Music").

halleyfy picks the model. You write the line and choose the voice. The voice reads the words you give it, so the text is the whole brief: write it the way it is said, with the pauses and the delivery you want.

## Before the first run

1. `command -v halleyfy`. Missing: if `npx` exists, use `npx -y halleyfy` wherever this skill says `halleyfy`. Otherwise tell the user to install it with `curl -fsSL https://halleyfy.com/install.sh | sh` and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code` (the same link signs a new user up), and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.
3. Read `halleyfy speak --help` once: every flag, the voices and the live price. Read `revoice --help`, `isolate --help`, `sound --help` or `music --help` before the first run of any of them.

Don't pass `--local` or `--live` unless the user asks.

`revoice` and `isolate` take sound from a video with ffmpeg, `sound --video` puts the soundtrack on the clip with it, `music --video` mixes the music into the clip with it, an instrumental's `--seconds` cuts the track with it, and the checks and joins below use it too. If a command stops with `ffmpeg_missing`, tell the user ffmpeg is needed and ask which way they want to get it: `brew install ffmpeg` (macOS), `sudo apt install ffmpeg` (Debian, Ubuntu), or `halleyfy ffmpeg install` (a checked copy for halleyfy only, about 80 MB, in `~/.config/halleyfy/bin`; write `~/.config/halleyfy/bin/ffmpeg` and `~/.config/halleyfy/bin/ffprobe` in the commands below instead of `ffmpeg` and `ffprobe`). Run the one they pick only after a yes. `speak`, `sound` with only a prompt, and `music` with only a prompt or lyrics need no ffmpeg.

## Every run

```bash
halleyfy speak "<text>" --voice Rachel --json --out ./audio
```

- The text is the argument, or `--text-file <path>` for a script in a file; text with a `"`, a `$`, a backtick or a leading `-` goes in a `--text-file`, where the shell can't change it. 1 to 5,000 characters.
- `--voice <name>`: one of the 21 voices below, any case. The default is Rachel.
- `--language <code>`: a 2-letter code like `en`, `de` or `ja`. See "Write the line".
- Files are saved in `--out` as `<job id>-<n>.mp3`. stdout is one absolute path per line; the cost goes to stderr. With `--json`, the paths are in `files` and the price is `cost_usd`. Use those paths in the next command.
- `--dry-run` prints the price and runs nothing. Use it first on anything long.
- Not available yet: a voice copied from a recording. If the user needs one, say so.

## Which command

| The job | Use |
|---|---|
| Words to speech: a voiceover, narration, a line | `speak` |
| The same words in a new voice, keeping the timing (so lips still match) | `revoice <source> --voice <name>` |
| A clean voice out of noise, wind, music or a room | `isolate <source>` |
| A sound effect, an ambience loop, or a soundtrack for a silent or generated clip | `sound` |
| Music: a bed under a video, a song that sings given words, or a score fitted to a clip | `music` |

`<source>` for `revoice` and `isolate` is a sound file (.mp3, .wav or .m4a), a video file (.mp4 or .mov), or a `file_…` id (the id of a sound; `isolate` also takes the id of a video). From a local video, only its sound is uploaded; the picture stays on this machine.

- `revoice` saves `<job id>-0.mp3`. When the source is a local video it also saves `<job id>-0.mp4` (`.mov` for a .mov): the same picture, with the new voice at the video's length. Sound up to 5 minutes. `--clean` takes background noise out before the voice is changed; music and effects under the voice go with it.
- `isolate` saves one `<job id>-0.mp3`, never a video: a clean voice usually goes into an edit. Sound up to 60 minutes.
- The new sound replaces the clip's old sound track whole. When the music or effects are their own file, mix them back in with ffmpeg (example 2 in `references/voice.md`). `revoice` without `--clean` may or may not keep the sound under the voice as it was: that isn't measured, so check the result with `watch`, against the original's summary (its loudest moments and quiet gaps), and tell the user what you found.
- `revoice` gives the whole recording the one voice you pick.

## Voices

Every voice is a stock voice, not the user's own. Match the voice to the use, and say which one you chose. With no preference from the user, narration and explainers suit Rachel, Brian, Bill, George or Lily; social and conversational reads suit Aria, Will, Jessica or Eric; news reads suit Sarah, Alice or Daniel.

| Voice | Sounds like |
|---|---|
| Rachel | woman, American, calm, young: narration |
| Aria | woman, American, expressive: social media |
| Sarah | woman, American, soft: news |
| Laura | woman, American, upbeat, young |
| Jessica | woman, American, expressive, young: conversational |
| Matilda | woman, American, friendly: narration |
| Alice | woman, British, confident: news |
| Lily | woman, British, warm: narration |
| Charlotte | woman, Swedish, breathy, young: characters |
| Roger | man, American, confident |
| Liam | man, American, articulate, young: narration |
| Will | man, American, friendly, young: social media |
| Eric | man, American, friendly: conversational |
| Chris | man, American, casual |
| Brian | man, American, deep: narration |
| Bill | man, American, trustworthy, older: narration |
| George | man, British, warm: narration |
| Daniel | man, British, authoritative: news |
| Callum | man, transatlantic, intense: characters |
| Charlie | man, Australian, natural: conversational |
| River | non-binary, American, calm |

Say it is a stock voice, not the user's own, when it matters (an ad, a testimonial). Keep the words the user gave you, and add no claims they didn't give (prices, results, guarantees).

## Write the line

The voice says what you write, and writing for the ear is different from writing for the eye.

1. **Punctuation sets the pauses.** A comma is a short breath, a full stop a longer one. Short sentences read crisply; a long sentence runs on without a breath. Break a line where the speaker would breathe.
2. **Write numbers, dates and symbols as they are said.** "Twenty twenty-six", "March third", "fifty dollars", "three point five percent", "nine a.m.". Spell out abbreviations and symbols: "versus", "and", "percent".
3. **Tags in square brackets set the delivery:** `[whispering]`, `[laughs]`, `[sighs]`. Put one right before the words it changes: `[whispering] Don't wake the baby.` A tag counts toward the 5,000 characters and the price.
4. **A name said wrong: write it in IPA between slashes**, the phonetic letters for how it sounds: `Our new lamp, /ˈluːmən/, is here.` Change only that word and run again.
5. **`--language` only when the text is short or mixed.** The text sets the language. A single word like "Gracias." or a line that mixes two languages may come out in the wrong one: add `--language es`.
6. **Fit the length.** A voice reads about 2.5 words a second. For a clip, count the seconds it has, leave a second at the end, and write to that. Check the real length of the result with `ffprobe -v error -show_entries format=duration -of csv=p=0 line.mp3`.

## Long scripts

One run takes up to 5,000 characters (count them with `--dry-run`, which prints the characters it bills: `Cost: $0.0312 (300 characters)`). For a longer script, split it at paragraph breaks into parts of at most 5,000 characters, so every join falls on a pause. Run each part with the same voice and language, then join them in order:

```bash
halleyfy speak --text-file part1.txt --voice Brian --json --out ./vo
halleyfy speak --text-file part2.txt --voice Brian --json --out ./vo
printf "file '%s'\n" /abs/path/vo/<job1>-0.mp3 /abs/path/vo/<job2>-0.mp3 > parts.txt && ffmpeg -f concat -safe 0 -i parts.txt -c copy voiceover.mp3
```

Each run is a new take, so a re-run of one part gives it a slightly different delivery. Re-run only the part that is wrong, then join again.

A recording longer than 5 minutes for `revoice`: cut its sound into pieces (`ffmpeg -i long.mp3 -f segment -segment_time 290 -c copy part%02d.mp3`), revoice each with the same voice, and join them the same way.

## Sound effects

`halleyfy sound` makes sound that isn't a voice:

- `halleyfy sound "<what it sounds like>" --seconds <0.5-30>` gives one sound to drop in at a moment: a door, rain, footsteps. `--loop` makes it repeat without a seam, for ambience under a scene.
- `halleyfy sound --video <clip>` gives a whole soundtrack that matches the picture and keeps the speech. It saves the soundtrack (.mp3) and, for a local clip, the clip with it on (.mp4).

Describe one sound by what a microphone would pick up: its source, action, material, space and distance. "A heavy oak door slams shut in a stone hallway, short echo, close" is a sound; "epic" is a feeling. For several sounds, make one effect each and place each in at its moment with ffmpeg. `references/sound-effects.md` has the prompts and the commands.

After a voice swap with `revoice --clean`, run `sound --video` on the new clip. It rebuilds the room sound and effects around the new voice.

## Music

`halleyfy music` makes music from a style you write:

- **A bed under a video:** `halleyfy music "<style>"` is an instrumental. `--seconds <n>` keeps its first n seconds.
- **A short intro, sting or ad bed:** a track comes back 2 to 4 minutes long, and a song is at least 120 seconds. Tell the user that up front, make a full track, find its best bars by listening with `watch` (they are rarely the first seconds, and you know where they are only after the run), and cut them with ffmpeg.
- **A song with words, for a reel:** `--lyrics-file song.txt` sings the user's words. The prompt sets the style, and `--vocals female` or `male` picks the voice.
- **A song when the user has no words:** `--vocals any`. The model writes the words. It costs more than a song from lyrics: run `--dry-run`, tell the user the price, then run it. It needs a yes only when the run or the batch is over $1 (see "Spending").
- **A score fitted to a clip:** `halleyfy music --video clip.mp4 "<style>"`. It saves the music (.mp3) and the clip with the music mixed 12 dB under its own sound. `--replace` makes the music the clip's only sound: use it only when the clip has no speech worth keeping.

Describe the music the way a producer would: genre, mood, tempo in bpm, instruments, era and how it builds. For an older style, name the era, the band and the instruments that lead ("classic 1950s big band, a loud saxophone section and blaring trumpets"). For a sung genre, write the lyrics in its language (K-pop: Korean, with an English hook). The bpm is a hint: measure the track when the tempo matters. To start on the chorus, put `[Chorus]` first in the lyrics. `sound --video` is the other way to a soundtrack: it makes room sound and effects that match the picture, and `music --video` makes music. `references/music.md` has the prompts, the lyrics format and the prices.

## Use-case guides

Read the guide when the job matches.

| Making | Read |
|---|---|
| A voiceover for a video, swapping the voice of a clip, one narration in several languages, cleaning a noisy recording | `references/voice.md` |
| Sound effects, ambience loops, a soundtrack for a silent or generated clip | `references/sound-effects.md` |
| Music: a short bed, intro or sting, a song from lyrics or a prompt, a style that needs its band or its language, a score fitted to a clip, a quieter or louder mix, cutting a track | `references/music.md` |

## Check the result

Check every result before handing it over, and read what it says.

- A revoiced `.mp4`, or a clip with a soundtrack, effects or music: `halleyfy watch <file>` (for effects, `references/sound-effects.md` says how to check where they land). With music mixed in, the clip's speech should still be in the transcript.
- A sound effect `.mp3` has no words, so there is no transcript to read: check its length with `ffprobe` and that it isn't silent with `volumedetect`, both free (the commands are in `references/sound-effects.md`).
- An instrumental `.mp3` has no words either: check its length with `ffprobe` and that it isn't silent with `volumedetect`, both free, and when it matters ask what only an ear can tell (which instrument leads, clipping, with times) with `watch --ask` (paid; the commands are in `references/music.md`). A song has words: see the next bullet.
- A voice `.mp3` (`speak`, `isolate`, a revoiced sound) or a song `.mp3` (`music` with lyrics or `--vocals any`): `halleyfy watch` reads videos, so wrap the sound in a black video first, then watch that:

```bash
ffmpeg -f lavfi -i color=black:s=320x240:r=1 -i line.mp3 -t "$(ffprobe -v error -show_entries format=duration -of csv=p=0 line.mp3)" -c:v libx264 -tune stillimage -pix_fmt yuv420p -c:a aac check.mp4 && halleyfy watch check.mp4
```

Ignore the black sheets. Read `transcript.md` against the script (for a song, the lyrics): every word there, in order; a name said the way you meant; a tag showing as a laugh or a sigh (a line like `(laughter)` or `([chuckles])`) and not as spoken text; the end not cut off. Add `--language <code>` to `watch` for a line that is not English. The summary also shows the length, the loudest moments and the quiet gaps: a voice with long gaps where the text has none, or one that is nearly silent, needs another take. A song transcript that shows only tags like `(music)` and no words is inconclusive, not a fail: say so to the user, and don't take it again on that alone. Tell the user what you checked.

## Finding past results

- Find a job: `halleyfy jobs --recipe speak --since 7d` (or `--recipe revoice`, `--recipe isolate`, `--recipe music`), with `--search "<words>"` for words from the text.
- Download it again: `halleyfy job <id> -o <dir>`.
- Results are kept 30 days, then deleted.

## Spending

Each command bills by what it works on. Most runs cost far less than $1.

| Command | Billed | Roughly |
|---|---|---|
| `speak` | per character of text | $0.104 per 1,000 characters: a full 5,000-character part is about 52 cents |
| `revoice` | per second of the sound, at least a minute (a 10-second clip costs a minute), up to 5 minutes | about 40 cents a minute |
| `isolate` | per second of the sound, up to 60 minutes | about 13 cents a minute |
| `sound` (an effect) | per second of the effect, 0.5 to 30 | about $0.0026 a second: 5 seconds is $0.013 |
| `sound --video` | per second of video, for each variation | about $0.013 a second: a 10-second clip is $0.13 |
| `music` | per track | an instrumental or a song from lyrics $0.195, a song from a prompt $0.65, music for a video (`--video`) $0.143 |

`--dry-run` shows the price: the most the run can cost. The charge is what the model really cost plus halleyfy's margin, never more than that. For `revoice`, `isolate` and `sound --video` it uploads the sound or video first (uploads are free) so the price can use its length. `music --video` uploads the clip first too.

| Situation | Do this |
|---|---|
| User gave a budget | Pass `--max-cost <budget>` and run. |
| No budget, the run costs $1 or less | Run it. |
| No budget, the run or the whole batch may cost more than $1 (a long script, a long recording, several takes) | `--dry-run --json` one run, multiply by the number of runs, tell the user the total, run only after a yes. |
| Several runs | Start each with `--no-wait --json`, collect with `halleyfy job <id> --wait --json --out <dir>`. A `revoice` of a local video always waits. |

## Exit codes

| Code | Meaning | Do this |
|---|---|---|
| 0 | Done | Use `files`. |
| 1 | Error | Read the message. If it gives a re-run command with `--idempotency-key`, run exactly that: it returns the same job without paying twice. |
| 2 | Over a cost limit | Tell the user the price and the limit. Don't raise `--max-cost` yourself. |
| 3 | The job failed, nothing was charged | Retry once, rewording the text if the message points at it. Fails again: tell the user. |
| 4 | Not enough balance | Stop. Tell the user the balance is too low for this run (the message gives the price and what's available) and that a top-up is needed to go on. Only if they want one: ask how much ($10 to $500, at most $100 a day in a new account's first week), run `halleyfy topup <amount> --json` and give them its `approve_url`. They approve it in their browser: one tap with a saved card, or they pay on Stripe's page. Then run `halleyfy topup --wait --json` (run it again if it times out); `status` `paid` means the money is in, so run again. Never ask for card details. |

## Before you hand it over

Run the check above on every file you made, read what it says (the transcript, for a voice), and fix what is wrong before showing it.

If `watch` can't run, don't skip the check without a word:

- Not enough balance (exit 4): measure the file for free (`ffprobe` for the length, `ffmpeg -i line.mp3 -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'` for the level), tell the user the sound wasn't checked and why, and offer a top-up as in the exit-code table.
- `ffmpeg_missing`: ask how to get ffmpeg (see "Before the first run"). Until then, say the sound wasn't checked.

## Common mistakes

- `revoice` of a video with `--no-wait`: refused, because the new voice is put on the video when the job is done. Leave `--no-wait` off.
- `revoice` ends with a `video_failed` error that says the job is done and charged and names the saved .mp3: the new voice is in that .mp3. Put it on the clip with ffmpeg and don't run `revoice` again (it would pay twice): `ffmpeg -i clip.mp4 -i <job id>-0.mp3 -map 0:v -map 1:a -c:v copy -c:a aac -af apad -shortest out.mp4`. Give `out` the clip's own extension: `out.mov` for a `.mov` clip, since not every `.mov` picture fits in an `.mp4`.
- Expecting music or effects to survive `--clean`: they go with the noise. Mix them back in afterward from the music's own file, or leave `--clean` off when the sound under the voice matters and then check the result: whether it stays as it was isn't measured.
- More than 5,000 characters in one `speak` run: split at a paragraph and join the parts.
- Numbers, dates and symbols written as digits and signs ("3.5%", "03/04"): the voice may read them in a way you didn't mean. Write them as they are said.
- A hard name left as plain letters when it came out wrong: write it in IPA between slashes.
- A short or mixed-language line with no `--language`: it may come out in the wrong language.
- A voiceover longer than the clip it goes on: measure the .mp3 with `ffprobe` before mixing, and shorten the text, not the speed.
- Handing over a voice .mp3 unheard: wrap it in a black video and read its transcript first.
- `--vocals female` or `male` with no lyrics: refused. Use `--vocals any` and describe the voice in the prompt, or write lyrics.
- Expecting `--seconds` to give a song its exact length: it is the length the model aims for, and songs often run longer. Measure the file. For an instrumental, `--seconds` is a real cut.
- `--replace` on a clip with someone talking: it removes the speech. Leave it off, and the music goes 12 dB under the clip's sound.
- `music` ends with `ffmpeg_failed` after the job is done: the job is charged, and the message names the saved files. Don't run it again (it pays twice). Mix or cut the saved .mp3 with the ffmpeg commands in `references/music.md`.
- A song from a prompt run without a quote: it costs $0.65, over three times a song from lyrics. `--dry-run` first, tell the user the price, then run it.
