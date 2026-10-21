# UGC ads and talking heads

For creator-style ads, testimonials, reviews, spokesperson lines and anything where a person talks to the camera.

## Start frame

Make it with `halleyfy image` as an ordinary phone photo: the person at arm's length, chest-up, face fully in frame, the product held beside the face with the label toward the lens, a real lived-in room, window light. 9:16 for reels and TikTok, 16:9 for YouTube. The product photo goes in as a reference so the bottle is right.

Without a start frame, `--ref` works too: the person reference first and the product photo second, then "The woman from <IMAGE_REF_0> holds the bottle from <IMAGE_REF_1> beside her face ...". Use the same references for every clip of a series, so it stays one creator. A start frame still gives you more control over the framing.

## The line

- One speaker. Two people talking in one clip mix up who says what.
- After a colon, without quotation marks: `She looks into the lens and says: Day three, and my skin is glowing.`
- Clean, complete sentences. No "...", dashes, "um" or "like": the model acts them out as stutters and false starts. Put the delivery in the description instead ("with a small laugh", "excited but relaxed").
- Short: about 2.5 words per second. At most 10 words in 6 seconds, 15 in 10. Lip sync holds best in the first 6-7 seconds, so finish the line by then and leave a beat at the end.
- Describe the voice outside the line, and reuse the same words in every clip of a series: "a warm, casual voice, late twenties, light American accent, close phone-mic sound."
- If a brand name comes out wrong, spell it the way it sounds ("Lumen, said loo-men").

## Make it look filmed on a phone

Ask for "handheld, with the small drift of a real arm" or "phone propped on the counter". A locked-off frame reads as a tripod, and a tripod reads as an ad. Leave out "cinematic", "4K", "studio lighting".

Count the hands. In an arm's-length selfie one hand holds the phone and the other the product: no other gestures. If she needs to touch her face or apply the product, use "phone propped on the bathroom counter" in both the start frame and the prompt.

## Example (7 s, from a frame, 9:16)

```text
Shot plan: one continuous shot, 7 seconds, vertical selfie, phone at arm's length, handheld with the small drift of a real arm.
0-1 s: she looks into the lens with the serum bottle beside her cheek.
1-4 s: she tilts the bottle toward the lens, smiles, and says in a warm, casual voice, late twenties, close phone-mic sound: Day three, and my skin is literally glowing.
4-7 s: she brings the bottle back beside her cheek and holds the smile.
Continuity: her face, the bottle and its label, the bathroom and the soft window light stay the same throughout.
Audio: only her voice in a small tiled bathroom, faint room tone. No music.
No captions, no subtitles, no on-screen text.
```

## A longer ad

Write it as several clips of one line each, from start frames made with the same look spec (same person, same outfit, same room), and cut them together. One clip per line keeps the lip sync clean.

## Rules

Invented people, or a real person only from their own photo with their clear permission (ask the user to confirm it); never public figures. The model may refuse photos of recognizable people. The voice is always generated: it won't sound like the real person, so say so. Don't put claims in the person's mouth that the user hasn't given you (medical results, prices, guarantees).
