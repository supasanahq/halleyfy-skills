# Product videos

For product heroes, packshots in motion, turntables, food and drink, and app or tech promos.

## Start from a frame

Make the start frame with `halleyfy image` and the user's product photo as a reference, so the shape, colors and label are right before anything moves. Big logos survive motion; small label text drifts, so keep the label large and front-facing, or accept that it will soften.

## Direct how the product moves

A product can stay still while light, liquid, steam or the camera move, or it can spin, flip, drop or burst open. Both work; a moving product needs more direction, because its shape has to survive the motion. Say how it moves (axis, speed, how far, where it stops), what it is made of and how it catches the light, and pin the final view with an end frame when it matters.

- Camera: an orbit at product height, a push-in, a pull-back reveal, a crane up. Give each move a speed, a start and an end point.
- Light: a highlight gliding across glass, a rim light rising, a shadow passing.
- Environment: condensation beads sliding, steam rising, dust in a light beam, water rippling around the base.
- Sound: one soft effect tied to a visible event ("a crisp click as the cap seats at 5 seconds"), room tone, "No music" unless the user wants music.

## Example: product hero (8 s, from a frame)

```text
Shot plan: one continuous shot, 8 seconds, no cuts.
0-7 s: slow, steady orbit 60 degrees to the right at bottle height, from the front view to a three-quarter view, arriving at 7 seconds. The bottle stays perfectly still; a soft highlight glides across the glass, and at 3 seconds two beads of condensation start sliding down its side.
7-8 s: the camera holds on the three-quarter view.
Continuity: the label, cap and colors, the key light from frame left and the black background stay exactly as in the first frame.
Audio: faint cool room tone, one soft glass ting at 6 seconds. No music. No dialogue.
No on-screen text, no captions, no subtitles.
```

## Food and drink

Macro lens, very shallow depth of field, a slow pour or a slow drizzle, backlight through the liquid, steam or condensation, sizzling or pouring sound. Hands from above if someone is cooking; keep them simple (one slow motion, no fiddly knife work).

```text
Shot plan: one continuous shot, 8 seconds, no cuts. Macro close-up, 100mm lens, very shallow depth of field.
0-6 s: iced coffee is poured slowly over clear ice in a tall glass on a walnut counter; cream blooms in soft swirls; condensation beads on the glass. The camera pushes in slowly toward the swirl.
6-8 s: the pour ends; the camera settles on the swirl and holds while the cream keeps turning.
Look: early-morning backlight through the glass from frame right, amber and cream palette, subtle film grain; the light stays steady throughout.
Audio: ice crackling, a gentle pour until 6 seconds, distant cafe murmur. No music. No dialogue.
No on-screen text, no captions, no subtitles.
```

## App and tech promos

Screens are text, and text warps. Start from a frame that already shows the real interface (a screenshot placed on the device with `halleyfy image` and the screenshot as a reference), move only the hands or the camera slowly, and add the real UI in editing if it must be crisp. Never ask the model to invent a working UI in motion.

## Turntable or 360

The model has to invent any side of the product it hasn't seen. Show it the sides: the front view as `--image` and the side view as `--end-image` (both made with `halleyfy image` from the product photos, same backdrop and light), with "slow orbit from the front to the side view". For a full 360, chain clips (front to side, side to back, back to front), each ending where the next starts, or give the product's back as a reference image when it is plain.

## Product in someone's hands without a start frame

`--ref` with the product photo (and a person reference if the user has one) keeps the product right while the model frames the scene: "The woman from <IMAGE_REF_0> picks up the bottle from <IMAGE_REF_1> ...". References steer the look but don't fix the composition; when the opening frame matters, make a start frame instead.
