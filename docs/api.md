# API

## LayoutUtil
### LayoutUtil.Version **[read-only]**
```lua
LayoutUtil.Version: string
```
The current version of LayoutUtil.

### LayoutUti.Grid **[read-only]**
```lua
LayoutUtil.Grid: Grid
```
Returns the Grid class.

!!! note
	There is also a type exported, LayoutUtil.Grid, which represents the Grid class.

### LayoutUti.List **[read-only]**
```lua
LayoutUtil.List: List
```
Returns the List class.

!!! note
	There is also a type exported, LayoutUtil.List, which represents the List class.

### LayoutUtil.new()
```lua
LayoutUtil.new(layout: ScrollingFrame | UIGridLayout | UIListLayout, noStartup: boolean?): Grid | List
```
Constructs a new class from a ScrollingFrame, UIGridLayout, or UIListLayout. If you specify a frame be sure to have a UILayout as it's child. The noStartup property represents if you want it to immediatley call :Play().

## UILayout
This represents the methods and properties both the List class and Grid class inherit.

### UILayout.Ref **[read-only]**
```lua
UILayout.Ref: UIGridLayout | UIListLayout
```
Returns the reference to the constructed UIGridLayout or UIListLayout.

### UILayout.Paused **[read-only]**
```lua
UILayout.Paused: boolean
```
Returns whether or not the layout is paused.

### UILayout.Destroyed **[read-only]**
```lua
UILayout.Destroyed: boolean
```
Returns whether or not the layout has been destroyed.

### UILayout.DoUpdatePadding
```lua
UILayout.DoUpdatePadding: boolean
```
Whether or not the layout should automatically update the padding.

### UILayout.DoUpdateSize
```lua
UILayout.DoUpdateSize: boolean
```
Whether or not the layout should automatically update the size.

### UILayout.DoUpdateCanvas
```lua
UILayout.DoUpdateCanvas: boolean
```
Whether or not the layout should automatically update the canvas.

### UILayout:UpdatePadding()
```lua
UILayout:UpdatePadding()
```
Manually updates the padding if it's currently paused.

### UILayout:UpdateSize()
```lua
UILayout:UpdateSize()
```
Manually updates the size if it's currently paused.

### UILayout:UpdateCanvas()
```lua
UILayout:UpdateCanvas()
```
Manually updates the canvas if it's currently paused.

### UILayout:Play()
```lua
UILayout:Play()
```
Plays the UILayout (call :Pause() to stop it).

### UILayout:Pause()
```lua
UILayout:Pause()
```
Pauses the UILayout (call :Play() to continue playing).

### UILayout:Destroy()
```lua
UILayout:Destroy()
```
Destroys the class completely.

### UILayout.new()
```lua
UILayout.new(layout: UIGridLayout | UIListLayout, noStartup: boolean?): Grid | List
```
Layout represents the layout you want it to bind to, while noStartup represents if the class should automatically call :Play() on construction.