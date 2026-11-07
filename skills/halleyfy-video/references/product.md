# Product videos

For product heroes, packshots in motion, turntables, food and drink, and app or tech promos.

## Start from a frame, or describe a reference

Make the start frame with `halleyfy image` and the user's product photo as a reference, so the shape, colors and label are right before anything moves. Big logos survive motion; small label text drifts, so keep the label large and front-facing, or accept that it will soften.

Without a start frame, give the product photo as `--ref` and say in the prompt what it is: "the bottle from the first image, with its shape, label and colors." References steer the look but don't fix the composition; when the opening frame matters, make a start frame instead.

## Say how it moves

A product can stay still while light, liquid, steam or the camera move, or it can spin, flip, drop or burst open. Both work. Name the move and how it feels ("drops onto the counter and bounces once", "turns slowly to show its side"), what catches the light, and where the camera ends. Guard the label or shape with a constraint if it matters.

- Camera: an orbit at product height, a push-in, a pull-back reveal, a crane up. Name where it ends.
- Light: a highlight gliding across glass, a rim light rising, a shadow passing.
- Environment: condensation beads sliding, steam rising, dust in a light beam, water rippling around the base.
- Sound: one effect tied to a visible event ("a crisp click as the cap seats"), room tone, "no music" unless the user wants music.

## Example: product hero (8 s, from a frame)

```text
One continuous shot. Animate the image: the camera orbits slowly around the perfume bottle at its height, from the front toward a three-quarter view, as light plays across the glass. A soft highlight glides across the glass as it turns, and two beads of condensation slide down its side. Then the camera settles on the three-quarter view while the highlight keeps moving slowly over the shoulder of the bottle. The label and the black background stay as they are.
Sound: faint cool room tone, and one soft glass ting as the camera settles. No music. No dialogue.
```

## Food and drink

A macro lens, very shallow depth of field, a slow pour or drizzle, backlight through the liquid, steam or condensation, sizzling or pouring sound. Hands from above if someone is cooking; keep them simple (one slow motion, no fiddly knife work).

```text
One continuous macro shot on a 100mm macro lens, a slow push-in. A macro drink commercial: iced coffee pours into a tall clear glass of ice on a walnut counter, in early-morning backlight through the glass, amber and cream tones, very shallow depth of field and subtle film grain. The coffee pours slowly over the clear ice and the cream blooms into soft swirls. Then the pour ends, and the swirls keep turning as condensation beads on the glass. The camera keeps pushing in toward the swirl.
Sound: ice crackling and a gentle pour, a distant cafe murmur. No music. No dialogue.
```

## App and tech promos

Screens are full of small text, and small text warps. Start from a frame that already shows the real interface (a screenshot placed on the device with `halleyfy image` and the screenshot as a reference), move only the hands or the camera slowly, and add the real UI in editing if it must be crisp. Never ask the model to invent a working UI in motion.

## Turntable or 360

The model has to invent any side of the product it hasn't seen. Show it the sides: the front view as `--image` and the side view as `--end-image` (both made with `halleyfy image` from the product photos, same backdrop and light), with "a slow orbit from the front to the side view". For a full 360, chain clips (front to side, side to back, back to front), each ending where the next starts. Without frames, two `--ref` photos of the product from the front and the back, described as one: "The first and second images show the same bottle from the front and the back; it appears once."

## Product in someone's hands

Say what each reference is, in flag order: "the woman from the first image, with her face, hair and clothing" and "the bottle from the second image, with its shape, label and colors". Then tell the events with their names: "The woman picks up the bottle and turns its label toward the camera."
