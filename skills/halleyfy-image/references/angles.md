# Other angles of the same product or scene

For a set of views of one product (a product page, a catalog) or of one scene from several camera positions (a storyboard, start frames), made from a single photo. It is the workflow in `consistency.md` with one difference: the camera moves and everything else stays.

## Workflow

1. **Clean the source if needed.** When the photo has something that shouldn't repeat in every view (a splash, clutter, a floating pose), first make a clean packshot from it (`product.md`). Pass the packshot as Image 1 and the original as Image 2 "for detail only".
2. **Pick the views** from the lists below. Make them at the shape and resolution they will be used at: 1:1 or 4:5 at 2K for a product page, the source frame's shape at 2K for start frames. A later run at a higher resolution draws a new picture; it doesn't enlarge this one.
3. **Write one spec and reuse it word for word.** Its first lines say what the set is for and that only the camera changes: "Show the same shoe from a new camera position: change only the camera position and framing to the SHOT below; keep the product, backdrop, light and color as in Image 1." Then the PRODUCT or CHARACTER and SET lines, LIGHT, LOOK and EXCLUDE, as in `consistency.md`.
4. **One run per view:** the spec, then a last line `SHOT: <the view>`. Every run gets the same references.
5. **Check every view** against Image 1 and against the others. Redo a miss with a sharper SHOT line, from the same references.

## Parts the photo doesn't show

The back, the other side, the sole or a face the photo hides get made up, and differently in each run unless the spec describes them.

- Describe each hidden part once in the spec, in the same words for every run: "black rubber outsole with a fine wave tread".
- On a real product's page a made-up side can be wrong. Tell the user which views are invented, and ask for photos of the sides that matter. Pass them as extra references: "Image 3 is the back of the shoe."
- The other side of a near-symmetric product comes out as a mirror copy of the first. Leave it out unless the user has a photo of it.

## Product views

| View | SHOT line |
|---|---|
| Hero three-quarter | front three-quarter view: the product turned 45 degrees toward the camera, camera slightly above it |
| Side | pure side profile, camera at product height, front pointing left |
| Front | straight-on front view, centered and symmetric |
| Back | straight-on back view, centered and symmetric |
| Rear three-quarter | rear three-quarter view: the back turned 45 degrees toward the camera |
| Top | camera directly above, pointing straight down at 90 degrees |
| Underside | the product upside down, its bottom facing a camera directly above (shoes, devices, anything with a designed base) |
| Detail | macro close-up of its signature detail filling the frame |
| Scale | held in a hand, or worn, so its size reads |

## Film coverage

| Shot | SHOT line |
|---|---|
| Establishing | extreme wide from far and high: the subject small, the whole place around them |
| Wide | full body, feet (or hooves) included, the place behind |
| Medium | from the waist up, turned three-quarters to the camera |
| Close-up | the face filling the upper two-thirds of the frame, eye level |
| Insert | hands or one prop filling the frame |
| Low angle | camera near the ground in front of the subject, looking up |
| Overhead | camera about 30 m directly above, pointing straight down at 90 degrees: no horizon, sky, walls or tree trunks in frame, only the tops of things |
| Over-the-shoulder | from just behind one shoulder: the shoulder and head edge in the foreground, what they look at beyond |
| Profile | square to the subject's side at eye level, facing the open side of the frame |

## Wording that lands

- Place the camera: where it stands, how high, how far, which way it looks. "The camera in the grass 3 m in front of the horse, looking up."
- "Top-down" alone gives a high oblique view. Give the height, say "pointing straight down at 90 degrees", and name what can't show from there: "no horizon, sky or tree trunks, only the tops of things".
- Give small parts their shape and size, not only their name: "a thin round black cord loop rising just above the collar", not "a pull tab". A part named only by its name changes from view to view.
- Keep someone out of a shot by framing them out: "his head out of frame". Asked to be "out of focus", people usually stay sharp, and frame-fill percentages are only loosely followed.
- Say which way the subject faces: "toe pointing left".

## Example (one view of a set)

```text
Use: one of nine product page images of the same shoe, each from a different camera position.
Show the same shoe from a new camera position: change only the camera position and framing to the SHOT below; keep the shoe, backdrop, light and color as in Image 1.
Image 1 is the product: keep its shape, knit, colors and every detail exactly. Image 2 is the original photo, for detail only: ignore its splash and floating pose.
PRODUCT: black slip-on sneaker, black engineered knit upper with tonal curved lines and a perforated forefoot, black sock collar, a thin round black cord loop rising just above the back of the collar, smooth black heel counter, thick grey midsole, translucent orange air pod at the heel, black rubber outsole with a fine wave tread.
SCENE: plain seamless burnt-orange backdrop and floor, as in Image 1.
LIGHT: large soft key from the upper left, soft fill from the right, soft contact shadow.
LOOK: photorealistic commercial product photograph, true-to-life color, one studio shoot.
EXCLUDE: no splash, no text, no logos, no props, no second shoe, no redesign of the shoe.
SHOT: rear three-quarter view: the heel turned 45 degrees toward the camera, toe pointing away to the upper left, camera slightly above shoe height, the whole shoe centered with empty space on every side.
```
