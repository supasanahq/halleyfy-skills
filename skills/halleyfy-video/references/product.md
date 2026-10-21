# Product videos

For product heroes, packshots in motion, turntables, food and drink, and app or tech promos.

## Start from a frame

Make the start frame with `halleyfy image` and the user's product photo as a reference, so the shape, colors and label are right before anything moves. Big logos survive motion; small label text drifts, so keep the label large and front-facing, or accept that it will soften.

## Let light and the camera move, not the product

The product staying still while light, liquid, steam or the camera move is what reads as a premium ad, and it is what the model does best. A product that spins, flips or falls tends to change shape.

- Camera: a slow orbit at product height (up to about 90 degrees), a slow push-in, or a pull-back reveal. One move, with a speed word and an end point.
- Light: a highlight gliding across glass, a rim light rising, a shadow passing.
- Environment: condensation beads sliding, steam rising, dust in a light beam, water rippling around the base.
- Sound: one soft effect tied to a visible event ("a crisp click as the cap seats at 5 seconds"), room tone, "No music" unless the user wants music.

## Example: product hero (8 s, from a frame)

```text
Slow, steady orbit 60 degrees to the right at bottle height, ending on a three-quarter view by 7 seconds. The bottle stays perfectly still; a soft highlight glides across the glass and two beads of condensation slide down. The label, cap, colors, the key light from frame left and the black background stay exactly as in the first frame. In a single continuous shot, no scene cuts. Audio: faint cool room tone, one soft glass ting at 6 seconds. No music. No dialogue. No on-screen text.
```

## Food and drink

Macro lens, very shallow depth of field, a slow pour or a slow drizzle, backlight through the liquid, steam or condensation, sizzling or pouring sound. Hands from above if someone is cooking; keep them simple (one slow motion, no fiddly knife work).

```text
Macro close-up, 100mm lens, very shallow depth of field. Iced coffee is poured slowly over clear ice in a tall glass on a walnut counter; cream blooms in soft swirls, condensation beads on the glass. Early-morning backlight through the glass from frame right, amber and cream palette, subtle film grain. A slow push-in settles on the swirl by 6 seconds, then holds. In a single continuous shot, no scene cuts. Audio: ice crackling, a gentle pour, distant cafe murmur. No music. No dialogue. No on-screen text.
```

## App and tech promos

Screens are text, and text warps. Start from a frame that already shows the real interface (a screenshot placed on the device with `halleyfy image` and the screenshot as a reference), move only the hands or the camera slowly, and add the real UI in editing if it must be crisp. Never ask the model to invent a working UI in motion.

## Turntable or 360

A full 360-degree turn reinvents the back of the product. Pin the turn instead: the front view as `--image` and a three-quarter or side view as `--end-image` (both made with `halleyfy image` from the product photos, same backdrop and light), with "slow orbit from the front to the side view". For a full turn, chain clips: front to side, side to back, each ending where the next starts.

## Product in someone's hands without a start frame

`--ref` with the product photo (and a person reference if the user has one) keeps the product right while the model frames the scene: "The woman from <IMAGE_REF_0> picks up the bottle from <IMAGE_REF_1> ...". References steer the look but don't fix the composition; when the opening frame matters, make a start frame instead.
