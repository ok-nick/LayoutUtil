<img align = 'right' width = '256' src = 'https://github.com/ok-nick/LayoutUtil/blob/master/assets/icon-256.png?raw=true'/>

# LayoutUtil
[![CI Status](https://img.shields.io/github/workflow/status/ok-nick/LayoutUtil/Build)](https://github.com/ok-nick/LayoutUtil/actions?query=workflow%3ABuild) [![Latest Release](https://img.shields.io/github/v/release/ok-nick/LayoutUtil?include_prereleases)](https://github.com/ok-nick/LayoutUtil/releases/latest) [![Discord](https://img.shields.io/discord/834969350061424660)](https://discord.gg/w9Bc6xH7uC)

A Luau library for automatically managing UILayouts.

LayoutUtil's main purpose is to maintain the aspect ratio of each child element within a ScrollingFrame while using a UILayout. With that, it offer features to automatically resize a ScrollingFrames' canvas.\
Although AutomaticCanvasSize natively exists for ScrollingFrames (it's very buggy), it is essential to be used in conjunction with LayoutUtil to prevent your UI from stretching.

## Installation
There are multiple ways to install LayoutUtil:

### Using Studio:
Installing the library is simple, just download the `.rbxm` file from the [releases](https://github.com/ok-nick/LayoutUtil/releases) and import directly into studio.\
I recommend installing [LayoutUtil-Plugin](LayoutUtil-Plugin](https://www.roblox.com/library/6723751472/LayoutUtil-Plugin)) from the catalog, although dragging the `.rbxm` file from the [releases](https://github.com/ok-nick/LayoutUtil/releases) into your plugin folder works.
[LayoutUtil](https://www.roblox.com/library/6723754061/LayoutUtil) and[ LayoutUtil-Plugin](https://www.roblox.com/library/6723751472/LayoutUtil-Plugin) are both available on the catalog.

### Using Rojo:
Install the `.rbxm` from the [releases](https://github.com/ok-nick/LayoutUtil/releases) and add it to your `.project.json` file.

### Using Kayak:
In your `rotriever.toml` file under the `[dependencies]` section, add:\
`LayoutUtil = 'https://github.com/ok-nick/LayoutUtil.git'`

### Using npm (roblox-ts):
Installing through npm is easy, simply run this command in your terminal:
`npm i @rbxts/LayoutUtil`

## Examples
### Maintaining UIListLayouts
```lua
local layout = script.Parent.UIListLayout
LayoutUtil.list(layout)
LayoutUtil.watch(layout)
```
`.list` will immediately maintain the sizes of each child. `.watch` will connect to updates on new children and maintain the size.

### Maintaining UIGridLayouts
```lua
local layout = script.Parent.UIGridLayout
LayoutUtil.grid(layout)
```
Notice how we don't have to use `.watch` function like we did in the [UIListLayout](#Maintaining-UIListLayouts) example. This is because a `UIGridLayout` only needs a `UIAspectRatioConstraint` inserted **ONCE** as it's child. This differs from a `UIListLayout` where you'd need to insert a constraint per child.
### Automatically resizing a ScrollingFrame
```lua
local scrollingFrame = script.Parent.ScrollingFrame
LayoutUtil.resize(scrollingFrame)
```
You might be wondering, "why don't I just use `AutomaticCanvasSize`?" This is because `AutomaticCanvasSize`, despite being released from beta, has numerous problems that haven't been resolved since months from release.

## Documentation
### LayoutUtil.constraint
```lua
LayoutUtil.constraint(object: GuiObject, absoluteSize: Vector2?)
```
Inserts and calculates a `UIAspectRatioConstraint` into the specified `object`. This function will reuse `UIAspectRatioConstraints` if one exists as a child.\
The `absoluteSize` parameter is optionally set to the object's `AbsoluteSize`. If the object (or it's ancestor) hasn't been parented, by default Roblox assigns the `AbsoluteSize` as (0, 0), which is why this parameter is necessary.

### LayoutUtil.grid
```lua
LayoutUtil.grid(layout: UIGridLayout, parentSize: Vector2?)
```
Inserts and calculates a `UIAspectRatioConstraint` into the `UIGridLayout` to maintain each child's aspect ratio.\
Again, as stated in the [constraint](#LayoutUtil.constraint) function, if the object is not a descendant of `game`, the `AbsoluteSize` of the object will be (0, 0), which is why the second parameter is necessary.

### LayoutUtil.list
```lua
LayoutUtil.list(layout: UIListLayout, parentSize: Vector2?)
```
Inserts and calculates a `UIAspectRatioConstraint` into each child neighboring the `UIListLayout` so that they maintain their aspect ratio.\
Again, as stated in the [constraint](#LayoutUtil.constraint) function, if the object is not a descendant of `game`, the `AbsoluteSize` of the object will be (0, 0), which is why the second parameter is necessary.

### LayoutUtil.watch
```lua
LayoutUtil.watch(layout: UIListLayout) -> RBXScriptConnection
```
Watches for new children being added to the parenting ScrollingFrame, then inserts and calculates the `UIAspectRatioConstraint`.\
It is important to recognize that this function is only available to `UIListLayouts`. This is because a `UIGridLayout` only needs a constraint within itself, whereas a `UIListLayout` needs one per neighboring child.

### LayoutUtil.resize
```lua
LayoutUtil.resize(scrollingFrame: ScrollingFrame, layout: UIListLayout | UIGridLayout, axis: Enum.AutomaticSize) -> RBXScriptConnection
```
Automatically resizes the canvas of a ScrollingFrame.\
This function replicates the `AutomaticCanvasSize` property except isn't completely broken. In future versions of LayoutUtil, when `AutomaticCanvasSize` becomes stable, this function will be deprecated and removed.

## FAQ
### What is the purpose of this library if we have the AutomaticCanvasSize property?
Please refer to the explanation described at the top of the [README](#LayoutUtil).

### Any more questions?
The best way to get in contact with me is [through discord](https://discord.gg/w9Bc6xH7uC).

## License
LayoutUtil is [MIT licensed](https://github.com/ok-nick/LayoutUtil/blob/main/LICENSE.md).
