return function()
	local LayoutUtil = require(game:GetService('ReplicatedStorage').LayoutUtil)

	it('should insert a UIAspectRatioConstraint and calculate the AspectRatio', function()
		local object = Instance.new('Frame')
		LayoutUtil.constraint(object, Vector2.new(100, 50))

		expect(object.UIAspectRatioConstraint.AspectRatio).to.equal(2)
	end)

	it('should constraint the UIGridLayout', function()
		local layout = Instance.new('UIGridLayout')
		layout.CellSize = UDim2.fromOffset(100, 50)
		LayoutUtil.grid(layout, Vector2.new(200, 10))

		expect(layout.UIAspectRatioConstraint.AspectRatio).to.equal(2)
	end)

	it("should constraint each child of the UIListLayout's parent", function()
		local frame = Instance.new('Frame')
		local child = Instance.new('Frame')
		child.Size = UDim2.fromOffset(100, 50)
		child.Parent = frame
		local layout = Instance.new('UIListLayout')
		layout.Parent = frame

		LayoutUtil.list(layout)

		expect(child.UIAspectRatioConstraint.AspectRatio).to.equal(2)
	end)

	it("should automatically constraint each new child of the UIListLayout's parent", function()
		local frame = Instance.new('Frame')
		local layout = Instance.new('UIListLayout')
		layout.Parent = frame

		LayoutUtil.watch(layout)

		local child = Instance.new('Frame')
		child.Size = UDim2.fromOffset(100, 50)
		child.Parent = frame

		expect(child.UIAspectRatioConstraint.AspectRatio).to.equal(2)
	end)
end
