# Start frames for video

`halleyfy video --image <frame>` makes the image the first frame of the clip. The video keeps its subject, light, palette and framing. A good start frame does most of the work of a good video.

## Rules

- **Same aspect as the video.** Make it 16:9 or 9:16 (the only video shapes). Any other shape gets cropped.
- **Plan the motion first, then frame for it.** Write down the one move the video will make (a push-in, a walk to the left, a turn of the head) and leave room for it.
- **Room to move:** put the subject on a third, facing into the open space. Keep full body and feet in frame for walking, headroom above the head for push-ins, space around the hands for gestures.
- **Nothing important on the edges.** The camera may drift; edge details get cut or warped.
- **Sharp and readable:** sharp focus, no motion blur. For fast action (a sprint, a jump, a pour), pick a clean, readable moment of it: mid-stride with both feet visible, the pour just starting. Avoid awkward in-between poses.
- **Toward or away from the camera:** center the subject and keep it small enough to grow (about 40% of the frame height for a run toward the lens), with open ground in front.
- **No text.** Headlines, captions and small labels warp once animated. Big logos on a product can hold; fine print won't.
- **Set up the payoff.** If the video's moment is a wave crashing, show the wave rising. If it's a reveal, show the "before".
- **Match the shot to the move:** a centered portrait for a push-in or orbit, a wide scene for a pan, a tall subject for a tilt.
- **Vertical for reels and TikTok:** keep the face and the product in the middle band, about 35-45% from the top; the apps cover the top and bottom.

## Say it in the brief

Tell the model what the frame is for. It frames better when it knows.

```text
Use: first frame of an 8-second clip; the camera will slowly push in while she turns her head toward the lens.
Scene: a woman in a crimson silk gown on a black-sand beach at blue hour, looking back over her shoulder; behind her a dark wave is rising, not yet breaking.
Composition: wide 16:9, she stands right of center with her face in the upper half; open dark sand at the lower left; nothing important touching the edges.
Light: cold overcast sky, a thin band of pale light at the horizon.
Photorealistic, sharp focus, no motion blur. No text, no logos.
```

## Before animating

Look at the frame. If anything is wrong (hands, a face, a detail of the product), fix the frame with another image run. It is cheaper than finding out in the video.

## End frames

An end frame pins the video's last moment, and the video calms down as it arrives there, so make one only when the last picture must be exact: an orbit to a set side, a zoom into a detail, a loop, a real product's after-state. Make it from the approved start frame with an edit run, changing only what differs at the end (the side view, the closer framing, the new outfit) and keeping the rest: "Image 1 is the first frame: keep the person, the clothes, the set, the light, the camera angle and the framing exactly. Change only <the after state>." Check that both frames have the same shape. For a loop, use the start frame as the end frame too.

When the user asked only for the frame, hand over its path together with the `halleyfy video --image <path> --aspect <same> --seconds <n>` command that would animate it, and the price from a dry run if they want it.
