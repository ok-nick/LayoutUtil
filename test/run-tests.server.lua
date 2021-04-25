local ReplicatedStorage = game:GetService('ReplicatedStorage')

require(ReplicatedStorage.TestEz).TestBootstrap:run({
	ReplicatedStorage.tests,
})
