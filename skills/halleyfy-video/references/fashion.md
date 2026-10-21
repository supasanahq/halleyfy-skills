# Fashion films, lookbooks and beauty

## Start from a frame

Fashion lives on exact styling, so make the start frame with `halleyfy image` first: the model, every garment (fabric, fit, color), hair, makeup, set and light. Leave room for the move: full body with feet for walking, headroom for a push-in, the face on a third when it will turn toward the camera.

## Motion

Anything a real model does on set works when it is choreographed: a walk toward the camera while it dollies back, a half-turn or a full spin, dancing, a hair flip, a head turn into the light, a slow push-in on a beauty close-up. Direct each one fully:

- **The body:** speed, number of turns or steps, which foot, where the arms and hands are, where she looks, when she stops and how she holds the final pose.
- **Fabric and hair:** "the silk ripples and flows behind her in the wind", "the hem flares out on the turn and settles half a second after she stops".
- **The camera:** locked off, or its move with a start, an end and a speed. Full-body framing with room around her for spins and dance.

## Changing the outfit

Outfit changes work as a transformation on the body, as a wipe, or as a cut. Whichever the user wants, time it and direct it: when it happens (during a turn while she faces away, as a sheet of fabric crosses her, on a beat), how it spreads, how long it takes, and what stays the same. Pin the new outfit with an end frame: the start frame edited into the second outfit, same pose. The full recipe and an example are in `effects-and-transitions.md`.

## Example: fashion film (8 s, from a frame)

```text
Shot plan: one continuous shot, 8 seconds, no cuts.
0-4 s: slow cinematic push-in from the wide shot. The wind lifts her crimson silk gown so it ripples and flows across the black sand to the left; her hair moves with it. She stands still, looking out to sea.
4-5 s: she turns her head over her right shoulder and looks calmly into the lens.
5-8 s: the push-in settles on a medium shot by 7 seconds and holds. The gown keeps moving in the wind.
Continuity: the overcast sky, the waves behind her, the cold blue light and the gown's color stay exactly as in the first frame throughout.
Audio: deep rolling surf and steady wind. No music. No dialogue.
No on-screen text, no captions, no subtitles.
```

## Beauty

Close-ups hold up best: skin, lips and eyes with the light moving across them. Ask for "real skin texture" in the start frame. Keep the motion small: a blink, a slight turn, a drop of serum sliding.

## Series

For a lookbook of several looks, use one look spec (same model, same set, same light) for every start frame, change only the outfit, and give every clip the same camera move and timing so they cut together. Without start frames, `--ref` with the model's canonical reference and one garment reference per clip keeps her the same across the set ("the woman from <IMAGE_REF_0> wearing the coat from <IMAGE_REF_1>").
