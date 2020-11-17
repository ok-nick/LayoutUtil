-- Variables


local Maid = {}
Maid.__index = Maid


-- Public


function Maid:GiveTask(task)
	local index = #self._tasks + 1
	self._tasks[index] = task

	return function()
		self._tasks[index] = nil
	end
end


function Maid:GiveTasks(...)
	for _, task in next, {...} do
		self:GiveTask(task)
	end
end


function Maid:DoCleaning()
	for index, task in next, self._tasks do
		self._tasks[index] = nil

		local T = type(task)
		if T == 'table' then
			task:Destroy()
		elseif T == 'function' then
			task()
		else -- RbxScriptConnection
			task:Disconnect()
		end
	end
end


Maid.Destroy = Maid.DoCleaning


-- Constructor


function Maid.new()
	return setmetatable({
		_tasks = {}
	}, Maid)
end


-- Export


return Maid