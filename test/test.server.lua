local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.DevPackages.TestEZ).TestBootstrap:run({
	ReplicatedStorage.tests,
})
