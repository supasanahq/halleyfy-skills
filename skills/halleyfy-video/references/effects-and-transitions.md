# Effects, transformations and transitions

Every effect can be asked for: freezes, morphs, material changes, outfit changes on a moving body, reveals, things forming out of particles, transitions between shots. What makes one work is telling it as a visible process. The model builds what you name; what you don't name, it invents, and an effect named in one word ("turns into glass", "transforms") usually comes out as something added next to the subject instead of the subject changing.

## Tell a change

1. **Name the one thing that changes, and say it stays itself.** "The wave itself", "her jacket itself", "the same bottle, same shape, same place". Only that thing changes.
2. **Say where the change starts and how it travels.** "Starting at the crest and spreading down through the whole wave", "rippling up from the hem to the collar", "from the toe cap back to the heel".
3. **Say what it becomes, in physical terms.** Material, finish and how light behaves on it: "clear, solid glass catching the pale light", "mirror-polished chrome", "silver sequins that flash as they turn".
4. **Say what carries on around it.** "The sea at its base keeps moving", "her hair keeps streaming in the wind". The world going on around the change keeps the clip alive and shows that only one thing changed.
5. **Give it a trigger and an energy** when that matters: "at its peak", "mid-spin", "as she steps through the doorway"; "suddenly", "in one smooth wave", "slowly spreading".
6. **Give what follows something that moves.** After a freeze or a finished change, name the camera drift, the light, the hair or a small action. A finished state with nothing named holds a still picture.
7. **Tie a sound to it.** "The instant it turns to glass the roar cuts out, leaving one high glass ring." The model also adds the ambience of what it shows, so a hard silence may keep a faint room tone; cut the track in editing when the silence must be total.
8. **An end frame for an exact after-state.** When the result must look a precise way (a real product, a set design) and takes keep missing it, start from `--image` and end on `--end-image` made by editing that start frame. It calms the motion and makes the change morph toward the picture.

## Bodies and outfits

Name the move and how it feels, then tell the change as a process on the body: "she spins once in place; mid-spin her jacket itself ripples into black velvet from the shoulders down, the hem flaring out as she completes the turn". The model knows how a spin goes; it needs the moment.

- Fabric and hair are where these clips come alive: say what they do (flares out, whips around, ripples, settles).
- Say the result completely: "and from then on she wears only the gown; the jacket is gone". A layer that was only "transformed" can come back.
- Say where she ends and what she does next: "lands facing the camera, then runs a hand down the fabric and glances over her shoulder".
- When the new outfit is a real product that must look exact, pin it with an end frame (the start frame edited into the new outfit, same pose) and accept a calmer landing.

## Other effects

| You want | Tell it as |
|---|---|
| A freeze | What stops, and what keeps moving: "the spray stops in mid-air, every droplet hanging still, while the camera keeps drifting right and her hair keeps moving". |
| A reveal | A pull-back from a detail to the whole, a rack focus, light rising on a subject in shadow, fabric or smoke clearing. Say where the camera ends. |
| Something forming | Where it comes from and how it builds: "particles of light swirl together into the shape of the bottle, which settles softly onto the table". |
| Day to night, weather | Make it the main event: "the light shifts from golden hour to blue hour as the city lights come on, window by window". |
| A loop | The same image as `--image` and `--end-image`, a gentle steady motion (steam, hair, water). If the last second jumps, crossfade half a second in editing. |

## Transitions between shots

For several shots in one clip, describe each shot in order and say how it hands over to the next. Times are optional; start each shot with its range (`[0-3s] ... [3-6s] ...`) when each shot must last a set time, back to back and inside the clip's length.

| Transition | Tell it as |
|---|---|
| Hard cut | "then a hard cut to a close-up of ..." |
| Match cut | Both shots share a shape or motion: "the spinning wheel, then a cut to a spinning record at the same speed and position" |
| Whip pan | "the camera whips right into a motion blur that resolves into ..." |
| Object wipe | "a sheet of silk blows across the frame, and as it clears we are in ..." |
| Dissolve | "the skyline slowly dissolves into a mountain ridge of the same shape" |

Say what carries across the cut once: "the same man, the same grey suit, now at night". Only the first shot can be pinned by a start frame.

## Joining clips

halleyfy has no join command. With ffmpeg available, join two clips of the same size like this; otherwise give the user the files to cut in an editor.

```bash
ffmpeg -i a.mp4 -i b.mp4 -filter_complex "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[v][a]" -map "[v]" -map "[a]" joined.mp4
```

## Example: a suit becoming a tuxedo through a doorway (8 s, prompt only)

```text
One continuous shot on a 35mm lens, the camera dollying back ahead of him at chest height. A menswear film: a tall man in his thirties with short dark hair and a trimmed beard, in a light grey wool suit and white shirt, walks down a narrow marble hallway toward the camera and through an open doorway, where his suit turns into a black tuxedo. Warm tungsten wall lights, deep shadows, a brown and black palette, fine film grain. He walks toward the camera with an easy, unhurried stride, his jacket moving with each step. As he passes through the doorway, his suit itself changes: the same jacket and trousers, same cut and fit, the grey wool darkening into black barathea from the shoulders down in one smooth sweep, the lapels turning to black satin that catches the light, a black bow tie forming at his collar. From then on he wears only the tuxedo. Then he keeps walking toward the camera, buttons his jacket with one hand and looks straight into the lens as the camera eases back ahead of him. The hallway and the lights stay as they are.
Sound: a slow, low jazz double bass under his leather soles echoing on marble; a soft rush of fabric as the suit changes, then one deep bass note. No dialogue.
```

It says it is one shot, describes the man and the place completely, says the suit itself changes and keeps its cut, where the change starts and how it spreads, what he wears from then on, gives the end its own action, and ties sounds to the events and the change. No times: the order is enough.
