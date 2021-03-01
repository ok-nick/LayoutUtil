# [LayoutUtil v2.0.0](https://github.com/Nickuhhh/LayoutUtil/releases/latest)
<img align = 'right' width = '256' src = 'assets/icon-256.png'/>

[![Actions Status](https://github.com/ok-nick/LayoutUtil/workflows/CI/badge.svg)](https://github.com/ok-nick/LayoutUtil/actions?query=workflow%3ACI) [![Latest Release](https://img.shields.io/github/release/ok-nick/LayoutUtil.svg)](https://github.com/Nickuhhh/LayoutUtil/releases/latest)

In version 2.0.0, LayoutUtil has been completely rewritten... yet again. This time, it's much much better >:). No more of the useless and bloated API. LayoutUtil has been completely cleaned up and is composed of only a single function that can be simply called to apply changes. Along with this, I highly suggest ONLY using the plugin, where <u>no scripting at all is involved</u> (as described below). Circumstance will determine whether you need the library during run-time, but it's always something to keep in mind. The new version of LayoutUtil, no longer allows you to specify the ScrollingFrame directly. This was done to be more explicit and to make the code more readable. With that, this feature was removed due to it being unnecessary and only contributing to the bloat.

To get into the specifics, LayoutUtil no longer has any connections, any run-time manipulation, it simply utilizes and pre-calculates UIAspectRatioConstraints. With the new release of the [AutomaticCanvasSize](https://developer.roblox.com/en-us/api-reference/property/ScrollingFrame/AutomaticCanvasSize) property of a ScrollingFrame, you simply don't need to worry about any prerequisites. This means, no more having to rely on converting your UI to scale (although I strongly suggest doing so). Setting your `CanvasSize` to (0, 0, 0, 0) is optional, but while using the AutomaticSizeConstraint property, it will act as canvas size padding. Unfortunately with this property being so new, there are specific problems as described in this [thread](https://devforum.roblox.com/t/automatic-size-property-now-available/1052320?u=iinemo), but they should be quickly resolved over time.

**One thing to note is LayoutUtil doesn't assign the `AutomaticCanvasSize` property, this should be done by the user.** As a side note, some people will say *"then what's the point of LayoutUtil?"* Its primary goal was to maintain the aspect ratio of each child element within a ScrollingFrame, while utilizing these layouts. This is what it currently does and what it will be doing over updates to come.

## [Typescript Users](https://roblox-ts.com/)
Typescript is still supported under [roblox-ts](https://roblox-ts.com/) and version 2.0.0 has been published to [npm](https://www.npmjs.com/package/@rbxts/layoututil).

## [Roact Users](https://github.com/Roblox/roact)
Unfortunately with how Roact works, a LayoutUtil component just simply isn't feasible. I've tried a variety of solutions, all leading to dead-ends. Although you could fork the code and create a component to automatically calculate a UIAspectRatioConstraint's aspect ratio. A friend recommended [this open-sourced component](https://github.com/sayhisam1/rbx-roact-components/blob/master/src/AutoUIScale.lua), created by @sayhisam1, which utilizes UIScales uniquely and successfully. You can read more about it within the code, but it seems to really help overall with designing UI, especially for keeping a consistent size across all resolutions.

## [LayoutUtil-Plugin v2.0.0](https://www.roblox.com/library/6460099901/LayoutUtil-v2)
Yes, even the plugin had a complete remake. LayoutUtilPlugin gets straight to the point, none of the extra fancy buttons to help with designing your UI, you could simply press the single button while selecting your UILayout/ScrollingFrame(s) to automatically insert and calculate the UIAspectRatioConstraints. LayoutUtilPlugin uses the LayoutUtil library internally... obviously, but I highly recommend it if possible as it would save unnecessary coding.

[LayoutUtil-Plugin v1.0.0](https://www.roblox.com/library/5965597514/LayoutUtilPlugin) did have a few handy extra UI tools, I plan to release a separate plugin which is specifically for this. I know most converter plugins aren't as in-depth with converting and aren't as supportive, which is why this could be useful. Not only that, but automatically calculating aspect ratios is a gift from heaven. There is no guarantee when this will be released, which is why I say it will be some time in the future - stay tuned.

## Where are the docs?
Documentation isn't needed, there is not much of an API and it's fairly basic - straight to the point. The [README.md](https://github.com/ok-nick/LayoutUtil/blob/master/README.md) suffices and should be enough to get a complete understanding of how to use it. Although if there are any questions or concerns, feel free to DM me.

## Examples
Obviously, in this example, you'd need to define `LayoutUtil` and `myUIGridLayout`.
```lua
LayoutUtil(myUIGridLayout)
```
LayoutUtil also provides a second parameter if the parent of your UILayout hasn't been set. This should normally be defined as your ScrollingFrame, although it also accepts a Vector2 since it just needs the AbsoluteSize. If a non-GuiObject is passed it will assume the parent size is the screens resolution. If a GuiObject is passed, it will use its AbsoluteSize.
```lua
LayoutUtil(myUIGridLayout, ScrollingFrame)
```

## Contact
Roblox: `iiNemo`\
Discord: `nickk#9163` *- Try to DM me directly rather than adding (for a quicker response).*


# [Repository](https://github.com/ok-nick/LayoutUtil) | [Release](https://github.com/Nickuhhh/LayoutUtil/releases/latest) | [Roblox Catalog](https://www.roblox.com/library/6460129603/LayoutUtil-v2) | [Plugin](https://www.roblox.com/library/6460099901/LayoutUtil-v2)
