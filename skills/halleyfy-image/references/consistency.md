# The same product or character across a set

There are no seeds. Consistency comes from fixed references plus a fixed written spec, repeated in every run.

## Workflow

1. **Make the canonical references first.**
   - Product: a clean packshot on a plain backdrop, front-on and evenly lit. Add a side or back view if the set needs them.
   - Character: a sheet with front, three-quarter and side views on a plain background, neutral expression, the full outfit visible.
   Check them carefully: every later image inherits their mistakes.
2. **Write a look spec once and paste it word for word into every brief.** Only the scene part changes.

   ```text
   LOOK: photorealistic editorial, light film grain, true-to-life color
   PALETTE: warm sand, off-white, deep olive accents
   LIGHT: soft window key from the left, gentle falloff
   CAMERA: 50-85mm feel, eye level, shallow depth of field
   PRODUCT: frosted glass bottle, gold dropper cap, label "LUMEN" in a thin serif
   CHARACTER: same face, shoulder-length dark hair, small mole under the left eye, cream linen shirt
   EXCLUDE: extra text, logos, watermarks, redesigns of the product
   SCENE: <the only part that changes>
   ```

3. **Every new image is an edit run** with the canonical references as `--image` (product as Image 1, character as Image 2, an optional scene or style reference after them), each named in the brief.
4. **Start each image from the canonical references, never from the previous output.** Chained edits drift: a little sharper, a little more saturated, a slightly different face each time. Once one image of the set is approved, it may go in after the canonical references as a style reference ("Image 3 shows the look to match"), never as the base to edit.
5. **One change per image.** Want the same scene at a different time of day? That is its own run, with the rest of the spec unchanged.
6. **Check each result** against the references: face, outfit, product shape, label text. Redo the ones that drifted instead of building on them.

## For video

Make every start frame this way, so the clips cut together. The video keeps whatever the frame shows. The canonical references also work directly as `halleyfy video --ref` images when the framing can be left to the video model.
