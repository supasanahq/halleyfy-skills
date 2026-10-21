# Effects, transformations and transitions

Every effect is possible to ask for: freezes, morphs, outfit changes on a moving body, spins, reveals, transitions between shots. What decides whether it works is how much of it you direct. A clip falls apart where the prompt left a gap: an effect described in one clause leaves the model to guess the timing, the mechanics and everything around it.

## Direct an effect

1. **Set it up in the start frame.** If a wave will freeze, the frame shows the wave rising. If a bottle will be revealed, the frame shows what hides it.
2. **Pin the after-state with an end frame** when it must look exact: edit the start frame with `halleyfy image` into the "after" (same shape). The end frame is the clip's last moment, so it must also show where the camera and the person are when the timeline ends. Then the model only invents the change itself.
3. **Describe it as a physical process:** when it starts, how long it takes, which direction it travels, what it is made of, and what light does on it. "At 3 seconds the crest stops mid-air and turns to clear glass, starting at the top and spreading down over one second; the low light refracts through it."
4. **Direct the world around it, beat by beat.** What does the sky do? The light? The background? The person? "The overcast sky and the cold blue light stay exactly as in the first frame for the whole clip." Unspoken, these change with the effect.
5. **Give it time.** A complex change needs about 2 seconds of its own. More effects in one clip are fine when each gets its own time slot.
6. **Plan the retake.** Tell the user complex effects can take a retake or two, and offer a 360p test first. For a freeze or speed ramp that must be perfect, editing software is another route.

## Bodies and outfits

A body that spins, dances or transforms needs choreography, not a verb:

- **Movement:** how many turns, how fast, on which foot, where the arms are, where the head looks, when she stops.
- **Fabric and hair:** how they lag behind the motion and when they settle.
- **The change:** at which moment it happens (best when she faces away or the fabric hides the body), how it spreads (from the hem upward, from the shoulders down), how long it takes, and what light does during it.
- **What stays:** face, hair, body shape, the set, the light, the framing.
- **The result:** pin it with an end frame showing her in the new outfit, same pose.

## Transitions between shots

When the user wants several shots, write the shot plan with times and say how each shot hands over to the next:

| Transition | Direct it as |
|---|---|
| Hard cut | "At 3 seconds, hard cut to a close-up of ..." |
| Match cut | Both shots share a shape or motion: "the spinning wheel ... cut to a spinning record at the same speed and position" |
| Whip pan | "At 3 seconds the camera whips right into a motion blur, and the blur resolves into ..." |
| Object wipe | "A sheet of silk blows across the frame left to right; as it clears, we are in ..." |
| Dissolve or morph | "Over one second the city skyline dissolves into the same shape of mountain ridge" |

Then direct every shot as fully as a single-shot clip: framing, camera, beats, continuity, sound. Keep the location, light and wardrobe rules per shot explicit, since a cut invites the model to change them.

## Other recipes

| You want | Direct it as |
|---|---|
| A reveal | Pull-back from a close detail to the whole; a rack focus from foreground to the subject; light rising on a subject that starts in shadow; fabric or smoke clearing. Say where the camera ends. |
| Freeze or bullet time | Name what freezes and what keeps moving: "the spray stops in mid-air while the camera keeps drifting right and her hair keeps moving". |
| Something forming | Particles, liquid or light converging into the object over a set time, then "the object stays perfectly still once formed". |
| A loop | The same image as `--image` and `--end-image`, a still camera and a steady motion (steam, hair, water). Watch the last second run into the first; if it jumps, crossfade half a second in editing. |
| Day to night, weather | Make it the point and time it: "over the 8 seconds the light shifts from golden hour to blue hour". |

## Joining clips

halleyfy has no join command. With ffmpeg available, join two clips of the same size like this; otherwise give the user the files to cut in an editor.

```bash
ffmpeg -i a.mp4 -i b.mp4 -filter_complex "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[v][a]" -map "[v]" -map "[a]" joined.mp4
```

## Example: a wave freezing into glass (8 s, start and end frame)

Start frame: she stands on the black sand looking into the lens, the wave rising behind her. End frame: the same image edited so the wave is clear glass, a little taller and curled forward, with hanging glass beads. The camera is locked off and she keeps her pose, so the end frame matches the last moment.

```text
Shot plan: one continuous shot, 8 seconds, locked-off camera, wide framing, no cuts.
0-3 s: the wave behind her keeps rising and its crest curls forward, spray lifting off the top. The wind from frame right moves her crimson gown and her hair to the left. She stands still and looks calmly into the lens.
3-4 s: the crest stops mid-air and turns to clear sculpted glass, starting at the top and spreading down to the sea at its foot over one second; the spray hangs as glass beads; the pale light at the horizon refracts through the glass.
4-8 s: the glass wave and the hanging beads stay perfectly still. Her gown and hair keep moving in the wind. She keeps her pose and her gaze on the lens, blinking once at 6 seconds.
Continuity: the dark overcast sky, the thin band of pale light at the horizon, the cold blue light on her, the black sand and her gown stay exactly as in the first frame for all 8 seconds. The sky never brightens or darkens. Only the water changes.
Audio: rolling surf and wind building to 3 seconds; at the freeze, sudden silence, then a single high glass chime; soft wind to the end. No music. No dialogue.
No on-screen text, no captions, no subtitles.
```

## Example: denim to evening gown in a spin (8 s, start and end frame)

Start frame: her in denim in the spotlight, right hand on her hip, facing the lens. End frame: the same image edited so she wears the silver gown, in the same pose. The timeline returns her to that pose.

```text
Shot plan: one continuous shot, 8 seconds, locked-off camera, full-body framing, no cuts.
0-2 s: she stands with her right hand on her hip and smiles; at 1.5 seconds she lowers the hand and shifts her weight onto her left foot.
2-4 s: she makes one slow full turn on the spot to her right over 2 seconds, pivoting on her left foot, arms close to her body, her ponytail swinging out behind her; she keeps her eyes on the lens as long as she can, then whips her head back to it. At 3 seconds, while her back is to the camera, the denim dissolves into silver sequins from the ankles upward over half a second, a ripple of light running up the fabric with it; the skirt of the new gown flares out with the turn.
4-5 s: she faces the lens again and stops; the hem swings once and settles half a second later.
5-8 s: she places her right hand back on her hip, as at the start, and holds the pose, the sequins glinting in the spotlight.
Continuity: her face, her ponytail, the spotlight, the haze, the black floor and the framing stay exactly the same throughout; only her outfit changes, once, at 3 seconds.
Audio: a soft sneaker squeak at 2 seconds, a whoosh with the turn, a shimmering sparkle at 3 seconds, a low bass hit at 4 seconds as she stops, then quiet studio room tone. No music. No dialogue.
No on-screen text, no captions, no subtitles.
```
