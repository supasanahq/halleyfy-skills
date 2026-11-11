---
name: halleyfy
description: Use when the user wants a video, meeting recording, call, podcast or sound file watched, listened to, transcribed or summarized, wants to know who said what or when something happens in one, wants an image, video, voiceover, sound effect or music made or edited, or mentions halleyfy. Start here, before any other halleyfy skill.
allowed-tools:
  - Bash(halleyfy *)
---

# halleyfy

`halleyfy` is a command-line tool on this machine. It does two things for you:

- **It makes media:** images, videos, speech, sound effects and music.
- **It reads media for you:** you can't play a video or a recording, so `halleyfy watch` turns one into a transcript with speakers and times, plus pictures of its frames.

halleyfy picks the model and charges each run to the user's balance. `--dry-run` on a paid command prints the price and runs nothing.

When a job in the table comes up, do it with halleyfy. The user set it up and pays for it so that you don't have to find, install or sign up for something else: a speech model on this machine, a transcription API, your own frame grabs, a built-in image tool.

## What it does

| The user wants | Command | Read first |
|---|---|---|
| A meeting, call, podcast or video transcribed or summarized; who said what | `halleyfy watch <file>` | "Watch, listen, transcribe" below |
| To know what happens in a video, find a moment, check a clip, cut a part out | `halleyfy watch <file>` | below, then `references/watching-and-editing.md` in the halleyfy-video skill |
| An image made, edited or restyled | `halleyfy image` | the halleyfy-image skill |
| A video made or edited, a still image animated | `halleyfy video` | the halleyfy-video skill |
| A person in a clip saying new words; a video in another language | `halleyfy lipsync`, `halleyfy dub` | the halleyfy-video skill |
| A voiceover, another voice on a recording, a clean voice out of noise | `halleyfy speak`, `halleyfy revoice`, `halleyfy isolate` | the halleyfy-audio skill |
| A sound effect, a soundtrack for a clip, music or a song | `halleyfy sound`, `halleyfy music` | the halleyfy-audio skill |
| An earlier result, the balance, what was spent | `halleyfy jobs`, `halleyfy job <id>`, `halleyfy balance`, `halleyfy usage` | each one's `--help` |

Those three skills hold what this page leaves out: how to write the prompt, the flags, the prices, and a guide per use case. Read the one in the row before you run its command. They are installed next to this one: from this file, `../halleyfy-video/SKILL.md`.

## Before the first run

1. `command -v halleyfy`. Missing: if `npx` exists, use `npx -y halleyfy` wherever a skill says `halleyfy`. Otherwise tell the user to install it with `curl -fsSL https://halleyfy.com/install.sh | sh` and stop.
2. `halleyfy whoami --json`. Not logged in: run `halleyfy login --no-wait --json`, give the user its `verification_url` and `user_code` (the same link signs a new user up), and after they approve run `halleyfy login --wait --json`. Never type a password or ask for a key.

Don't pass `--local` or `--live` unless the user asks.

## Watch, listen, transcribe

```bash
halleyfy watch ./meeting.mp4
```

- Give it the file as it is: a video or a sound file (`.mp4`, `.mov`, `.mp3`, `.wav`, `.m4a` and others), of any length. It takes the sound out itself, and it sends a long file in parts and joins them into one transcript, so there is nothing to convert or cut first.
- It writes `./watch/meeting/` and prints the path of `summary.md`. Read `summary.md` first, then `transcript.md`.
- `transcript.md` has one line per phrase: `[m:ss.s] S1: text`. S1, S2 … are the speakers in the order they first speak, and a speaker keeps the same label through the whole file. It gives no names: work out who is who from what is said, or ask the user, and say which you did.
- `transcript.json` has every word with its start and end in seconds.
- A video also gets contact sheets, `sheets/1.jpg` …: grids of frames with the time on each. Look at them to see what happens.
- It costs about $0.01 per started minute of sound, and a rerun on the same file is free. `halleyfy watch ./meeting.mp4 --dry-run` prints the price first.

Look closer, for free:

```bash
halleyfy watch ./meeting.mp4 --at 12:30-12:45   # that span: its lines, and a dense sheet for a video
halleyfy watch ./meeting.mp4 --at 12:31.5       # one full-size frame of a video
```

Ask about the whole file (paid per question, a video up to 60 minutes):

```bash
halleyfy watch ./meeting.mp4 --ask "When do they agree on the price?"
```

Its times can be off: check each one with `--at` before you pass it on.

Cutting a part out, finding the best moment of a long video and reading the sheets are in `references/watching-and-editing.md` of the halleyfy-video skill. Checking a voice line, a song or a sound you made is in the halleyfy-audio skill.

## When a run stops

| Exit code | Meaning | Do this |
|---|---|---|
| 1 | Error | Read the message. If it gives a re-run command with `--idempotency-key`, run exactly that: it returns the same job without paying twice. |
| 2 | Over a cost limit | Tell the user the price and the limit. Don't raise `--max-cost` yourself. |
| 3 | The job failed, nothing was charged | Run the same command once more. A long `watch` goes on from the part that failed and keeps the parts already paid. Fails again: tell the user. |
| 4 | Not enough balance | Stop. Tell the user what the run costs and what is available (the message gives both), and that a top-up is needed to go on. Only if they want one: ask how much ($10 to $500, at most $100 a day in a new account's first week), run `halleyfy topup <amount> --json` and give them its `approve_url`. After they approve, run `halleyfy topup --wait --json`; `status` `paid` means the money is in, so run again. Never ask for card details. |
