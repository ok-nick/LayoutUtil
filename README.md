<img align = 'right' width = '256' src = 'https://github.com/ok-nick/LayoutUtil/blob/master/assets/icon-256.png?raw=true'/>

# `LayoutUtil`
[![CI Status](https://img.shields.io/github/workflow/status/ok-nick/LayoutUtil/Build)](https://github.com/ok-nick/LayoutUtil/actions?query=workflow%3ABuild)
[![Latest Release](https://img.shields.io/github/v/release/ok-nick/LayoutUtil?include_prereleases)](https://github.com/ok-nick/LayoutUtil/releases/latest)
[![Discord](https://img.shields.io/discord/834969350061424660)](https://discord.gg/w9Bc6xH7uC)

`LayoutUtil` is a library for dynamically sized `ScrollingFrames` with dynamically sized elements, without stretching.

## Installation

### Using Wally:
```toml
[dependencies]
LayoutUtil = "ok-nick/LayoutUtil@3.0.0"
```

### Using npm (via roblox-ts):
```bash
$ npm install @rbxts/LayoutUtil
```

## Examples
### `UIListLayouts`
```lua
LayoutUtil.list(layout)
LayoutUtil.watch(layout)
```
`list` will immediately insert `UIAspectRatioConstraints` for each child, while `watch` will ensure any subsequent children also get the same procedure.

### `UIGridLayouts`
```lua
LayoutUtil.grid(layout)
```
`UIGridLayouts` work differently than `UIListLayouts`. Instead of each child needing a `UIAspectRatioConstraint`, only the `UIGridLayout` needs one.

### Automatically resize a ScrollingFrame
```lua
LayoutUtil.resize(scrollingFrame)
```
You may prefer using the `AutomaticCanvasSize` property, but it is known to have bugs, [read here](#LayoutUtilresize).

## Documentation
### `LayoutUtil.constraint`
```lua
LayoutUtil.constraint(object: GuiObject, absoluteSize: Vector2?)
```
Calculates and inserts a `UIAspectRatioConstraint` into the specified `object`. This function will reuse `UIAspectRatioConstraints` if one exists as a child.\
If the object (or its ancestor) hasn't been parented, by default Roblox assigns the `AbsoluteSize` property to (0, 0). If this is the case, be sure to specify the `absoluteSize` parameter explicitly.

### `LayoutUtil.grid`
```lua
LayoutUtil.grid(layout: UIGridLayout, parentSize: Vector2?)
```
Calculates and inserts a `UIAspectRatioConstraint` into the specified `UIGridLayout`. This function will reuse `UIAspectRatioConstraints` if one exists as a child.\\
If the object (or its ancestor) hasn't been parented, by default Roblox assigns the `AbsoluteSize` property to (0, 0). If this is the case, be sure to specify the `absoluteSize` parameter explicitly.

### `LayoutUtil.list`
```lua
LayoutUtil.list(layout: UIListLayout, parentSize: Vector2?)
```
Calculates and inserts a `UIAspectRatioConstraint` into each child neighboring the `UIListLayout` so that they maintain their aspect ratio.\
If the object (or its ancestor) hasn't been parented, by default Roblox assigns the `AbsoluteSize` property to (0, 0). If this is the case, be sure to specify the `absoluteSize` parameter explicitly.

### `LayoutUtil.watch`
```lua
LayoutUtil.watch(layout: UIListLayout) -> RBXScriptConnection
```
Watches for new children in the parenting `ScrollingFrame`, then calculates and inserts a `UIAspectRatioConstraint`.\
This function is only applicable to `UIListLayouts`. `UIGridLayouts` only need one `UIAspectRatioConstraint` as its child.

### `LayoutUtil.resize`
```lua
LayoutUtil.resize(scrollingFrame: ScrollingFrame, layout: UIListLayout | UIGridLayout, axis: Enum.AutomaticSize) -> RBXScriptConnection
```
Automatically resizes the `CanvasSize` property of a ScrollingFrame.\
`resize` uses the `AbsoluteContentSize` of the `UILayout` to calculate the `CanvasSize` for the `ScrollingFrame`. You may choose to use the `AutomaticCanvasSize` of a `ScrollingFrame`, but it is known to have bugs. 

## FAQ
### Why not use offset?
Using offset for each element of the `ScrollingFrame` works, but it doesn't adjust to the user's resolution. On a small screen, the UI may look fine; however, on a large screen it may be too small.

### Why not use scale?
Scale will adapt each element's size to the user's resolution, but it will not prevent them from stretching.

### Why not use a `UIAspectRatioConstraint`?
`LayoutUtil` uses `UIAspectRatioConstraints` internally! For a `UIGridLayout`, it will calculate and insert one as its child, and for a `UIListLayout`, it will calculate and insert one for each element, as necessary. 
