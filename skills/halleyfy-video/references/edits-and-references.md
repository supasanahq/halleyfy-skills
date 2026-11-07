# Reference images, reference videos and edits

## References: who, what and how it moves

`--ref` (up to 10 images) and `--ref-video` (up to 3 clips) tell the model what people, products, places and movement look like, while it frames the scene itself. They can't be combined with `--image`. References are free. They work best within the model maker's guidance: at most 6 images, up to 3 per person and 2 people; reference clips of about 3 s each, and one clip for a video longer than 10 s. Reference videos must be local .mp4/.mov files (or `file_` ids); trim them to the part that matters. A reference clip's sound is ignored.

Say in plain words what each reference is and what to take from it, in flag order: `--ref a.png --ref b.png --ref-video dance.mp4` is the first image, the second image and the reference video. Give each one job:

| Reference | Say it as |
|---|---|
| A person | "The woman from the first image, with her face, hair and clothing." |
| A person, face only (new outfit) | "The woman from the first image, with her face and hair; she wears a red raincoat." |
| A product | "The bottle from the second image, with its shape, label and colors." |
| A place | "The cafe looks like the third image, its layout, furniture and light; the people in that image don't appear." |
| A style | "The whole clip has the color grade and film grain of the fourth image." |
| Movement | "The woman performs the dance from the reference video." |
| A camera move | "The camera repeats the move in the reference video: a fast push-in that ends in a slow orbit." |

- One reference, one job. A picture of a group defines that group, not one person in it.
- Two references of the same person or product (front and side, two outfits of the same model): "The first and second images show the same woman from the front and in profile; she appears once."
- After that, call things by their names ("the woman picks up the bottle"), not by "the first image" or a pronoun alone.
- "Put the person from the first image into the reference video" is written as who does what: "The man from the first image performs the skateboard trick from the reference video, in the skatepark from the reference video."

### Example: motion transfer (8 s)

`--ref ./dancer.png --ref-video ./routine.mp4`

```text
One continuous full-body shot, the camera slowly circling her at waist height. A dance video: the woman from the first image, with her face, hair and clothing, performs the routine from the reference video on a sunlit rooftop basketball court, in bright late-afternoon sun, long shadows and saturated colors. She dances the routine, matching its rhythm and moves. Then on the last move she spins out and lands facing the camera, breathing hard and laughing.
Sound: an upbeat hip-hop beat in time with her moves, her sneakers squeaking on the court. No dialogue.
```

## Editing a video

`--video` changes an existing clip of up to 15 s and keeps everything else: its motion, timing, length and shape. `--seconds`, `--aspect` and `--ref` can't be used with it, so an edit takes no reference image: describe the new thing in words. It takes the same `--resolution` sizes as a new clip. To edit part of a longer clip, cut that part out first: `ffmpeg -ss 4 -t 10 -i in.mp4 -c copy part.mp4`.

Write one short instruction, then "Keep everything else the same." Longer descriptions change more than you asked.

| Edit | Say it as |
|---|---|
| Replace an object | "Replace the red car with a vintage green convertible. Keep everything else the same." |
| Remove an object | "Remove the man in the background. Keep everything else the same." |
| Change the setting | "Change the background to a snowy mountain pass at dawn. Keep the woman, her movement and everything else the same." |
| Weather, season, time of day | "Make it a heavy snowfall at night, with snow settling on the street. Keep everything else the same." |
| Restyle the whole clip | "Turn the whole video into stop-motion clay animation. Keep everything else the same." |

- One change per run. For two, edit, look, then edit the result.
- Say what must not change when it is at risk: "Keep his face and the camera move the same."
- The original sound may be regenerated; if the clip's own sound matters, keep it in editing: `ffmpeg -i edited.mp4 -i original.mp4 -map 0:v -map 1:a -c:v copy -shortest out.mp4`.
- Editing can't add length, cut out the middle of a clip or change what happens. To change the action, make a new clip from a start frame instead.
