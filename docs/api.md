## Global Functions
### LayoutUtil:ConvertToScale
```lua
LayoutUtil:ConvertToScale(Layout: UILayout) -> void
```
If you've already created and setup a UILayout you could call this function within the studio command bar to covert it and it's children to scale.
### LayoutUtil.new
```lua
LayoutUtil.new(Layout: UILayout, Config: table) -> class
```
Creates a new class based off the type of UILayout specified. Config parameter is optional to specify what you don't want to run.

!!! warning
    **MAKE SURE** to follow the [easy mistakes](mistakes.md) page to ensure that it will be setup correctly!

```lua
Config = {
    Bind = false, -- Removes instant binding.
    ResizeCanvas = false, -- Removes canvas resizing.
    ResizeContent = false, -- Removes content resizing.
    OnResize = false, -- Updates when it's resized.
    OnWindowResize = false, -- Updates when the content size changes.

    -- UIGridLayout Exclusives
    CellPadding = UDim2.new(), -- Default CellPadding.
    CellSize = UDim2.new(), -- Default CellSize.

    -- UIListLayout Exclusives
    Padding = UDim.new(), - Default Padding.
    OnAxisChange = false, -- Updates when FillDirection changes.
    OnAdd = false, -- Adds object to the resize cache.
    OnRemove = false, -- Removes object from the resize cache.
}
```
## UILayout API
### Class:ResizeCanvas
```lua
Class:ResizeCanvas() -> void
```
Changes the CanvasSize of the ScrollingFrame to automatically fit the content size.
### Class:ResizeContent
```lua
Class:ResizeContent() -> void
```
Resizes the CellPadding and CellSize of a UIGridLayout. For a UIListLayout it will resize each child and it's Padding.
### Class:Bind
```lua
Class:Bind() -> void
```
Subscribes a series of events to handle the scaling.
### Class:Unbind
```lua
Class:Unbind() -> void
```
Destroys all connections that automatically handle scaling.
## UIGridLayout Exclusives
### Class:SetDefault
```lua
Class:SetDefault(CellPadding: UDim, CellSize: UDim) -> void
```
Set's the default CellPadding and CellSize to maintain aspect ratio around.
## UIListLayout Exclusives
### Class:SetDefault
```lua
Class:SetDefault(Padding: UDim) -> void
```
Set's the default Padding to maintain aspect ratio around.
### Class:GetAxis
```lua
Class:GetAxis(FillDirection: EnumItem) -> void
```
Returns the axis relative to the FillDirection EnumItem.
### Class:AddObject
```lua
Class:AddObject(Object: GuiObject) -> void
```
Adds an object to the resize cache.
### Class:RemoveObject
```lua
Class:RemoveObject(Object: GuiObject) -> void
```
Removes an object from the resize cache.