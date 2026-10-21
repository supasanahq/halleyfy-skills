# Reference images, reference videos and edits

## References: who, what and how it moves

`--ref` (up to 10 images) and `--ref-video` (up to 5 clips, 15 s in all) tell the model what people, products, places and movement look like, while it frames the scene itself. They can't be combined with `--image`. Reference videos must be local .mp4/.mov files (or `file_` ids); their seconds are billed on top of the clip's, so trim them to the part that matters.

Each kind is numbered in flag order: `--ref a.png --ref b.png --ref-video dance.mp4` gives Image 1, Image 2 and Video 1. In [Core Task], give each reference one job and say what to take from it:

| Reference | Binding line |
|---|---|
| A person | "The woman corresponds to Image 1, adopting her face, hair and clothing." |
| A person, face only (new outfit) | "The woman corresponds to Image 1, adopting her face and hair; she wears a red raincoat." |
| A product | "The bottle corresponds to Image 2, adopting its shape, label and colors." |
| A place | "The cafe references Image 3, adopting its layout, furniture and light; the people in it are ignored." |
| A style | "The whole film adopts the color grade and film grain of Image 4." |
| Movement | "The woman performs the dance from Video 1." |
| A camera move | "The camera repeats the move in Video 1: a fast push-in that ends in a slow orbit." |

- One reference, one job. A picture of a group defines that group, not one person in it.
- Two references of the same person or product (front and side, two outfits of the same model): "Image 1 and Image 2 show the same woman from the front and in profile; she appears once."
- After the bindings, call things by their names in the steps ("the woman picks up the bottle"), not by number or pronoun alone.
- "Put the person from Image 1 into Video 1" is written as who does what: "The man from Image 1 performs the skateboard trick from Video 1, in the skatepark from Video 1."

### Example: motion transfer (8 s)

`--ref ./dancer.png --ref-video ./routine.mp4`

```text
[Core Task]
Generate a dance video of the woman from Image 1 performing the routine from Video 1 on a sunlit rooftop basketball court. The woman corresponds to Image 1, adopting her face, hair and clothing. Her movement follows the dance in Video 1. The whole film adopts bright late-afternoon sun, long shadows and saturated colors.

[Plot Summary]
1. She dances the routine from Video 1, matching its rhythm and moves.
2. On the last move she spins out and lands facing the camera, breathing hard and laughing.

[Audio Style]
An upbeat hip-hop beat in time with her moves, her sneakers squeaking on the court. She stays silent.

[Camera & Core Constraints]
One continuous full-body shot, the camera slowly circling her at waist height.
```

## Editing a video

`--video` changes an existing 2-10 s clip and keeps everything else: its motion, timing and length (or its first `--seconds`), and its shape (unless `--aspect`). It comes out at 720p or 1080p.

Write one short instruction, then what stays. No labelled parts.

| Edit | Say it as |
|---|---|
| Replace an object | "Replace the red car with a vintage green convertible. Keep everything else the same." |
| Remove an object | "Remove the man in the background. Keep everything else the same." |
| Change the setting | "Change the background to a snowy mountain pass at dawn. Keep the woman and her movement the same." |
| Weather, season, time of day | "Make it a heavy snowfall at night, with snow settling on the street." |
| Restyle the whole clip | "Turn the whole video into stop-motion clay animation." |
| Change from a picture | With one `--ref`: "Replace her jacket with the jacket from the image." |

- One change per run. For two, edit, look, then edit the result.
- Say what must not change when it is at risk: "Keep his face and the camera move the same."
- The original sound may be regenerated; if the clip's own sound matters, keep it in editing: `ffmpeg -i edited.mp4 -i original.mp4 -map 0:v -map 1:a -c:v copy -shortest out.mp4`.
- Editing can't add length, cut out the middle of a clip or change what happens. To change the action, make a new clip from a start frame instead.
