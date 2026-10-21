# UGC ads and talking heads

For creator-style ads, testimonials, reviews, spokesperson lines and anything where a person talks to the camera.

## Start frame or references

Make the start frame with `halleyfy image` as an ordinary phone photo: the person at arm's length, chest-up, face fully in frame, the product held beside the face with the label toward the lens, a real lived-in room, window light. 9:16 for reels and TikTok, 16:9 for YouTube. The product photo goes in as a reference so the bottle is right.

Without a start frame, give `--ref` the person first and the product second, and bind them: "The woman corresponds to Image 1, adopting her face, hair and clothing. The serum corresponds to Image 2, adopting its bottle, label and colors." Use the same references and the same binding lines for every clip of a series, so it stays one creator. A start frame still gives you more control over the framing.

## The line

- One speaker. Two people talking in one clip can mix up who says what.
- Speaker, verb, colon, the line in double quotes: `She looks into the lens and says: "Day three, and my skin is glowing."`
- Clean, complete sentences. Put the delivery in the description ("with a small laugh", "excited but relaxed"), not in the line as "um" or "...".
- Short: about 2.5 words per second, at most 12 words in 5 seconds and 20 in 8. Finish the line a second before the end and leave a beat.
- Describe the voice and reuse the same words in every clip of a series: "a warm, casual voice, late twenties, light American accent, close phone-mic sound". Give the language if it isn't English.
- Add "no subtitles" to the constraints so the line isn't burned into the picture.
- If a brand name comes out wrong, spell it the way it sounds ("Lumen, said loo-men").

## Make it look filmed on a phone

Ask for "handheld, with the small drift of a real arm" or "phone propped on the counter". A locked-off frame reads as a tripod, and a tripod reads as an ad. Leave out "cinematic" and "studio lighting".

Count the hands. In an arm's-length selfie one hand holds the phone and the other the product: no other gestures. If she needs to touch her face or apply the product, use "phone propped on the bathroom counter" in both the start frame and the prompt.

## Example (6 s, from a 9:16 frame)

```text
[Core Task]
Animate the image as a selfie testimonial: she shows the serum to the camera and says one line.

[Plot Summary]
1. She tilts the serum bottle toward the lens and smiles.
2. She says in a warm, casual voice, late twenties, close phone-mic sound: "Day three, and my skin is literally glowing."
3. She brings the bottle back beside her cheek and holds the smile, her arm drifting slightly.

[Audio Style]
Only her voice in a small tiled bathroom, faint room tone. No music.

[Camera & Core Constraints]
One continuous vertical selfie shot, phone at arm's length, handheld with the small drift of a real arm. No subtitles, no on-screen text.
```

## A longer ad

Write it as several clips of one line each, from start frames made with the same look spec (same person, same outfit, same room), and cut them together. One clip per line keeps the lip sync clean.

## Rules

Invented people, or a real person only from their own photo with their clear permission (ask the user to confirm it); never public figures. The model may refuse photos of recognizable people. The voice is always generated: it won't sound like the real person, so say so. Don't put claims in the person's mouth that the user hasn't given you (medical results, prices, guarantees).
