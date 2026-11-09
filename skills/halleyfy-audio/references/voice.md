# Voices: voiceovers, new voices, languages, clean recordings

Four jobs, each with its commands. Check every result the way SKILL.md's "Check the result" says: `halleyfy watch` the .mp3 or the revoiced .mp4 itself.

## 1. A voiceover for a product video

The clip is `clip.mp4`, 8 seconds, and the voice should start 1.5 seconds in.

1. Measure the clip: `ffprobe -v error -show_entries format=duration -of csv=p=0 clip.mp4`. At 2.5 words a second, an 8-second clip with a 1.5-second start and a second left at the end has room for about 13 words.
2. Write the line for the ear, in the user's words: a short sentence or two, numbers as they are said.
3. Make it:

```bash
halleyfy speak "Meet Lumen. Warm light for every room, in one soft glow." --voice Brian --json --out ./vo
```

4. Measure the .mp3 (`ffprobe` as above). Longer than the room you have: shorten the text and run again.
5. Put it under the clip at 1.5 seconds. `adelay` takes milliseconds, so 1500 is 1.5 seconds. A clip with its own sound (every halleyfy video has one) keeps it, mixed with the voice. `normalize=0` keeps each sound at its own level; without it `amix` turns every input down by the number of inputs:

```bash
ffmpeg -i clip.mp4 -i vo.mp3 -filter_complex "[1:a]adelay=1500|1500[v];[0:a][v]amix=inputs=2:duration=first:normalize=0" -c:v copy out.mp4
```

To make the clip's own sound quieter under the voice, turn it down first:

```bash
ffmpeg -i clip.mp4 -i vo.mp3 -filter_complex "[0:a]volume=0.5[bg];[1:a]adelay=1500|1500[v];[bg][v]amix=inputs=2:duration=first:normalize=0" -c:v copy out.mp4
```

A clip with no sound: take the voice alone, delayed, and let it pad with silence so the video keeps its length:

```bash
ffmpeg -i silent.mp4 -i vo.mp3 -map 0:v -map 1:a -c:v copy -af "adelay=1500|1500,apad" -c:a aac -shortest out.mp4
```

6. Watch the result: `halleyfy watch out.mp4`. In `transcript.md` the first word should land at about 1.5 seconds and the last well before the end.

A video made with `halleyfy video` can carry its own speech or music. For a voiceover, write "no speech" and "no music" (or the music you want) in that clip's prompt, so the voice has the room.

## 2. Swap the voice of a clip

A generated clip (or a recording) has the right words and timing, and the voice is wrong for the use:

```bash
halleyfy revoice clip.mp4 --voice Brian --dry-run
halleyfy revoice clip.mp4 --voice Brian --out ./revoiced
```

- It saves `<job id>-0.mp3` (the new voice alone) and `<job id>-0.mp4` (the clip with the new voice, at the clip's length). Picture and lip timing are kept: the words land where they did.
- Leave `--no-wait` off: the new voice is put on the video when the job is done.
- The whole recording gets the one voice, so a clip with two people speaking gets both in the new voice.
- `--clean` first when the recording is noisy (wind, a room, a hum). Music and effects under the voice go with the noise. To bring music back, mix it under the revoiced clip:

```bash
ffmpeg -i <job id>-0.mp4 -i music.mp3 -filter_complex "[1:a]volume=0.3[m];[0:a][m]amix=inputs=2:duration=first:normalize=0" -c:v copy final.mp4
```

- Watch the result: `halleyfy watch <job id>-0.mp4`. The transcript should say the same words as the original's.

## 3. One narration in three languages

The same voice, a translation for each language, three runs:

```bash
halleyfy speak "Meet Lumen. Warm light for every room." --voice Rachel --language en --json --out ./vo
halleyfy speak "Découvrez Lumen. Une lumière chaude pour chaque pièce." --voice Rachel --language fr --json --out ./vo
halleyfy speak "Das ist Lumen. Warmes Licht für jeden Raum." --voice Rachel --language de --json --out ./vo
```

- Use the user's translations when they gave them. When you translate, say so, and let them check the brand and product names.
- The same voice name keeps it one narrator across the three.
- Other languages run longer or shorter than English. Measure each .mp3 with `ffprobe`, and fit each to the clip (shorten that translation, not the speed).
- Check each file with `watch` and its language: `halleyfy watch ./vo/<job id>-0.mp3 --language fr`. A name said wrong in one language: write it in IPA there.
- Put each one on a copy of the clip with the ffmpeg line from example 1.

## 4. Clean a noisy recording

An interview recorded in a busy room, `interview.mp4`:

```bash
halleyfy isolate interview.mp4 --dry-run
halleyfy isolate interview.mp4 --out ./clean --json
```

- Only the sound of the video is uploaded. The result is one `<job id>-0.mp3` with the voice and none of the room, the wind or the music.
- Watch the clean .mp3 (`halleyfy watch ./clean/<job id>-0.mp3`) and read its transcript against the original's (`halleyfy watch interview.mp4`). The words should be the same, with the gaps between them quiet.
- Put the clean voice back on the picture, at the video's length:

```bash
ffmpeg -i interview.mp4 -i <job id>-0.mp3 -map 0:v -map 1:a -c:v copy -c:a aac -af apad -shortest interview-clean.mp4
```

- Want the same words in another voice as well? Run `halleyfy revoice` on the clean .mp3 (up to 5 minutes), or on the video with `--clean` to do both in one run.
