# Ads, posters, social posts and thumbnails with text

The model writes accurate text when you tell it exactly what to write and where. Treat every word as a spec.

## Text rules

- Put the exact copy in quotes: `headline "Glass skin in 7 days."`
- Say where it goes, how big, and the type style: "large refined serif, cream white, upper left".
- Say how often: "exactly once". Then: "no other text".
- Keep headlines short. 2-7 words render reliably; paragraphs don't.
- Spell unusual brand names letter by letter if they come out wrong.
- Read every letter of the result. If one word is wrong, run again with that word spelled out, rather than handing it over.

```text
Finished beauty advertisement: a woman in her twenties with radiant dewy skin smiles softly, holding a frosted glass serum bottle with a gold dropper beside her cheek. The label reads "LUMEN" in a thin serif with "GLOW SERUM" in small caps beneath.
Warm peach backdrop, soft sunlight casting a window-frame shadow. She is on the right half of the frame.
Headline in the open space at the upper left, large refined serif, cream white: "Glass skin in 7 days." One small line below in a light sans-serif: "LUMEN Glow Serum".
Every letter correct, no other text, no other logos.
```

## Social formats and safe zones

| Placement | Aspect | Keep text and faces out of |
|---|---|---|
| Stories, Reels, TikTok | 9:16 | The top ~14%, the bottom ~35%, ~6% at each side (app buttons and captions cover them) |
| Feed post | 4:5 or 1:1 | Thin margins only |
| YouTube thumbnail | 16:9 | The bottom-right corner (the timestamp) |

## Thumbnails

One subject with a clear, readable expression, high contrast against the background, 2-4 big words in quotes. It must read at the size of a postage stamp. If the video title is longer, pick the 2-4 strongest words from it and tell the user which.

YouTube takes thumbnails at 1280x720 and up to 2 MB: 1K at 16:9 is enough, and a large PNG may need converting to JPEG (`ffmpeg -i thumb.png -q:v 3 thumb.jpg`).

## Posters and key art

Decide the hierarchy: headline, image, one supporting line, brand. Describe the layout ("headline across the top third, product centered, brand mark bottom center") and the style ("Swiss-style poster", "mid-century travel poster illustration").

## Mockups

Describe the thing as if it already shipped: the device, the real interface parts on its screen, or the packaging with its exact printed text plus "no other text".

## Infographics and slides

Write a spec: title, every label and number in quotes, the order, a plain background, landscape aspect. Check every fact and figure in the result.
