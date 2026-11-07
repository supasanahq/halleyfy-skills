# Fashion films, lookbooks and beauty

## Start from a frame, or describe everything

Fashion lives on exact styling, so for client work make the start frame with `halleyfy image` first: the model, every garment (fabric, fit, color), hair, makeup, set and light. Leave room for the move: full body with feet for walking, headroom for a push-in, the face on a third when it will turn toward the camera.

Without a frame, the prompt has to carry all of that: who the model is (age, ethnicity, hair), each garment with its fabric, cut and color, the set, the light and the palette. Anything left out is the model's choice.

## Motion

Anything a real model does on set works: a walk toward the camera while it dollies back, a half-turn or a full spin, dancing, a hair flip, a head turn into the light, a slow push-in on a beauty close-up. Name the move and its attitude ("a confident, unhurried walk", "a playful spin"), and say what the fabric and hair do: that is where fashion clips come alive ("the silk ripples and flows behind her in the wind", "the hem flares out on the turn"). Frame full body with room around her for spins and dance. The garment is the product: guard it once with a constraint by its defining features ("the camel coat keeps its wide lapels and belt").

## Changing the outfit

Outfit changes work as a change on the body, as a wipe, or as a cut. Tell it as a process: what triggers it (mid-spin, a sheet of fabric crossing her, a doorway), that the garment itself changes, where it starts and how it spreads, what it becomes and how it moves, and that she wears only the new outfit from then on. When the new outfit is a real product that must look exact, pin it with an end frame (the start frame edited into it, same pose). More in `effects-and-transitions.md`.

## Example: fashion film (8 s, prompt only)

```text
One continuous shot on an 85mm lens, the camera dollying back ahead of him from a full-length view to a medium close-up. A fashion film: a Black man in his late twenties with close-cropped hair, in a long camel wool overcoat with wide lapels over a cream roll-neck and charcoal trousers, stands on a windy concrete rooftop at dusk with the city behind him. Soft dusk light from behind, a warm sodium city glow, a muted camel, cream and slate palette, fine grain. The wind catches the coat and lifts its hem as he turns his head from the skyline toward the camera. Then he walks slowly toward the lens with his hands in his pockets, the coat swinging with each step. Then he stops in a medium close-up, the wind still moving the lapels and the city lights flickering on behind him. The coat keeps its wide lapels and camel color.
Sound: a slow, minimal electronic beat under steady rooftop wind, distant city traffic and his footsteps on concrete. No dialogue.
```

## Beauty

Close-ups hold up best: skin, lips and eyes with the light moving across them. Ask for "real skin texture" in the start frame or the description. Keep the motion small: a blink, a slight turn, a drop of serum sliding.

## Series

For a lookbook of several looks, use one look spec (same model, same set, same light) for every start frame, change only the outfit, and give every clip the same camera move so they cut together. Without start frames, give `--ref` the model's photo and one garment photo per clip, and say what each is: "The woman from the first image, with her face and hair, wears the coat from the second image, with its cut, fabric and color."
