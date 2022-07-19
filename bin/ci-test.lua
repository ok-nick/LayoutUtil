local ReplicatedStorage = game:GetService("ReplicatedStorage")

local results = require(ReplicatedStorage.DevPackages.TestEZ).TestBootstrap:run({
	ReplicatedStorage.tests,
})

if #results.errors > 0 or results.failureCount > 0 then
	error("Tests failed")
end
