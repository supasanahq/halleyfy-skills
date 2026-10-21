# Effects, transformations and transitions

A transformation is where clips fall apart: the model redraws the whole scene, a body melts, the sky changes. These patterns keep the change contained.

## Rules for any effect

1. **Set it up in the start frame, and pin the result with an end frame.** If a wave will freeze, the start frame shows the wave rising and the end frame (an edit of the start frame) shows it frozen as glass. With both ends fixed, the model only invents the change itself.
2. **Change the environment, not the body.** Water, light, fabric, particles, objects and backgrounds transform well. Faces, hands and bodies don't.
3. **Describe it as a physical process with a speed and a time:** "At 4 seconds the crest stops mid-air and turns to clear glass, starting at the top and spreading down over one second."
4. **Name what stays the same, in the same prompt:** "The sky, the light, the beach, her gown and the camera framing stay exactly the same; only the water changes."
5. **Single continuous shot, no scene cuts.** Without it the model tends to cut to a new shot for the "after", and everything else changes too.
6. **One effect per clip:** one change to one element. A wave that stops and turns to glass is one effect; a wave freezing while her dress changes color is two.
7. **Tell the user effects are hit or miss.** Plan for a retake. For freezes and speed ramps, also mention that doing it in editing is the reliable route.

## Patterns that work

| You want | Do this |
|---|---|
| An outfit or look change | **Object wipe with an end frame:** make the end frame by editing the start frame ("change only her outfit to ..."), then prompt a sheet of silk, a passing person, or the camera moving past a pillar crossing the frame; when it clears, she is in the end frame's outfit. Or make two clips with the same camera and cut them on a beat. |
| A reveal | Pull-back reveal, a rack focus from foreground to the subject, light rising on a subject that starts in shadow, fabric or smoke clearing. |
| Freeze, bullet time | Freeze the element, not the people: spray hangs in the air while the camera keeps drifting. Expect retakes; a freeze done in editing is more reliable. |
| Something forming | Particles, liquid or light converging into the object, with "the object stays perfectly still once formed". |
| A loop | Pass the same image as `--image` and `--end-image`, keep the camera still, and describe a steady motion: steam rising, hair moving, water rippling. The frames match at the seam but the motion may not: watch the last second running into the first, and if it jumps, crossfade half a second in editing. |
| Day to night, weather | Keep it slow and say it's the point: "over the 8 seconds the light shifts from golden hour to blue hour". Unasked, light must not change. |
| A match cut between clips | End clip one and start clip two on the same shape or motion direction (a spinning wheel, then a spinning record). |

## Joining clips

halleyfy has no join command. With ffmpeg available, join two clips of the same size like this; otherwise give the user the files to cut in an editor.

```bash
ffmpeg -i a.mp4 -i b.mp4 -filter_complex "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[v][a]" -map "[v]" -map "[a]" joined.mp4
```

## What to avoid

- Full spins, flips and twirls used to hide a change.
- "Turns into" on a person or a garment while they move.
- Two transformations in one clip.
- Effects that depend on readable text or a precise logo.

## Example: an environment change, contained (8 s, start and end frame)

Start frame: the wave rising behind her. End frame: the same image edited so the wave is clear glass with hanging glass beads.

```text
Slow dolly in toward her. At 3 seconds the curling wave behind her stops mid-air and turns to clear glass over one second, spreading from the crest down; the spray hangs as glass beads. Her gown keeps moving in the wind. The sky, the light, the black sand, her pose and the camera framing stay exactly the same; only the water changes. In a single continuous shot, no scene cuts. Audio: rolling surf and wind, then sudden silence when the wave freezes, a single high glass chime. No music. No on-screen text.
```

## Example: outfit change with a wipe (6 s, start and end frame)

Start frame: her in denim. End frame: the same image edited so she wears the silver gown, same pose.

```text
Static camera, full-body framing. At 2 seconds a long sheet of silver silk blows across the frame from left to right, briefly covering her; when it clears at 3 seconds she is wearing a floor-length silver evening gown and holds the same pose, smiling at the lens. The studio, the spotlight, her hair and her face stay exactly the same. In a single continuous shot, no scene cuts. Audio: a soft whoosh of fabric, a shimmering sparkle as it clears. No music. No on-screen text.
```
