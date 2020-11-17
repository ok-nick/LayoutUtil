# [LayoutUtil v1.0.0](https://github.com/Nickuhhh/LayoutUtil/releases/latest)
The largest update yet following a complete rewrite of the [codebase](https://github.com/Nickuhhh/LayoutUtil/tree/master) and [documentation](https://nickuhhh.github.io/LayoutUtil/). Not only that, but there is now complete **typescript** support for use with roblox-ts. Recently, I was looking back at the code lately, wondering what is this for? Why did I add this? I included a ton of redundant features that were totally confusing or completely useless. This is a big reason for a complete remake. Now for the contents of this update, I've fully integrated Luau type checking. Although this feature is still in beta (you might notice a lot of orange highlighted source code), if used properly it should make LayoutUtil a breeze. When linking a new UILayout, to ensure proper type checking, follow the short guide below.
```lua
local class: LayoutUtil.List = LayoutUtil.new(script.Parent.ScrollingFrame) -- considering theres a UIListLayout inside
```
It's as simple as adding a colon followed by LayoutUtil.List for a UIListLayout, or LayoutUtil.Grid for a UIGridLayout.

## That's it? Nahhhh, I've implemented a variety of methods including:
* .new(layout: UIListLayout | UIGridLayout, noStartup: boolean) - *The noStartup parameter is new, replacing the configuration table. This parameter determines if it will immediately start resizing everything (otherwise call :Play() to start).*
* :UpdatePadding() - *Updates the padding manually if it's paused*
* :UpdateSize() - *Updates the children size or CellSize manually if it's paused.*
* :UpdateCanvas() - *Updates the canvas manually if it's paused.*
* :Update() - *Calls the three functions above.*
* :Play() - *Plays it so that it automatically updates.*
* :Pause() - *Pauses it.*
* :Destroy() - *Destroys the class*

### And a couple of read-only properties:
* .Ref: UIGridLayout | UIListLayout - *A reference to the UILayout.*
* .Paused: boolean - *Whether or not it's paused.*
* .Destroyed: boolean - *Whether or not it's destroyed.*

### And a couple of interchangeable properties:
* DoUpdatePadding: boolean - *Whether or not to update the padding.*
* DoUpdateSize: boolean - *Whether or not to update the children's size or CellSize.*
* DoUpdateCanvas: boolean - *Whether or not to update the CanvasSize of the ScrollingFrame.*

Unfortunately, you will have to alter your code to work with the latest API if you have previously used the "advanced" functionality. For the better, this was done. If you have imported LayoutUtil directly from the Roblox catalog, there is no need to worry, for this version I have created a new asset (which I suggest to integrate).

Before version 1.0.0 you had to use methods like :SetDefault(), which was actually the only method that only allowed you to change the default padding (and CellSize for UIGridLayouts). In the latest version you are able to directly change the properties of a UIGridLayout/UIListLayout including Padding, CellSize, CellPadding, and the size of any child within a UIListLayout. LayoutUtil automatically adapts to those changes and retains the aspect ratio around that size.

There were a few bugs located and squashed, unfortunately, I forgot to record all of them. There was a strange behavior that prevented it from working while adjusting the FillDirection during runtime.

I intended on adding a feature to automatically ignore the CanvasSize on startup, but after careful consideration, there would be too many minor exceptions. For example, let's say you have a template that you clone into the ScrollingFrame and it's supposed to be relative to the size of the canvas from startup, the slot would end up compressing. I understand that having to resize the canvas after you had everything perfectly sized is frustrating, but that's where my new plugin comes to play.

# [Introducing LayoutUtilPlugin](https://www.roblox.com/library/5965597514/LayoutUtilPlugin)
### The plugin to end the clash between scale and offset. It contains a total of five buttons:
* Scale - *Converts the selected GuiObject to scale.*
* Offset - *Converts the selected GuiObject to offset.*
* RatioConstraint - *Inserts a UIAspectRatioConstraint into the selected objects, automatically calculating the AspectRatio.*
* Remove Canvas - *Sets the CanvasSize to all zeros while maintaining the size of each child, which makes LayoutUtil happy.*
* Import - *Imports the latest version of LayoutUtil into the StarterGui.*

### A few key features include:
* The ability to convert UIGridLayouts, UIListLayouts, UIPaddings, UICorners, UIPageLayouts, and UITableLayouts to scale or offset.
* Selecting a ScreenGui (or BillboardGui, SurfaceGui, &, etc) will convert every descendant.
* Converting elements in a ScrollingFrame will make sure it's size stays consistent.
* Automatically converts the CanvasSize to scale (which shouldn't be too important for LayoutUtil).
* Utilizes ChangeHistoryService so you could easily revert changes.
* Removing the CanvasSize from a ScrollingFrame will keep the size of each child (accounts for UIGridLayouts).
* A lot of edge cases are checked, being if the parent is a type of Gui it will use the screen size, otherwise if it's not a GuiObject it won't resize. If the property is being affected by the X or Y axis (ex: FillDirection & more in-depth ones).

Hopefully, this plugin should make working with UI in general seamless.

If there are any questions, feature requests, or bugs, please be sure to let me know. The best way to get in contact is via Discord, but I actively read DevForum DMs.

**Roblox - iiNemo  
Discord - nickk#9163**

## [Documentation](https://nickuhhh.github.io/LayoutUtil/) | [Repository](https://github.com/Nickuhhh/LayoutUtil/tree/master) | [Releases](https://github.com/Nickuhhh/LayoutUtil/releases/latest) | [Roblox Library](https://www.roblox.com/library/5968113284/LayoutUtil-v1-0) | [Plugin](https://www.roblox.com/library/5965597514/LayoutUtilPlugin)
