OptimisationTest = {}


local OptimisationTest_mt = Class(OptimisationTest)


function OptimisationTest.new()

	local self = setmetatable({}, OptimisationTest_mt)

	self.tests = {}
	self.ticks = 0
	self.timer = {}

	return self

end


function OptimisationTest:registerTest(name)

	self.tests[name] = {}

end


function OptimisationTest:startTest(name)

	self.timer[name] = getTimeSec()

end


function OptimisationTest:endTest(name)

	table.insert(self.tests[name], getTimeSec() - self.timer[name])

	self.timer[name] = nil

end


function OptimisationTest:update()

	self.ticks = self.ticks + 1

	if self.ticks >= 250 then

		self.ticks = 0
		local text = ""

		for name, times in pairs(self.tests) do

			if #times == 0 then continue end

			local totalTime = 0

			for _, time in pairs(times) do totalTime = totalTime + time end

			if #text > 0 then text = text .. ", " end
			text = text .. string.format("%s = %.5f", name, (totalTime / #times) * 1000)

			self.tests[name] = {}

		end

		print(text)

	end

end

g_optimisationTest = OptimisationTest.new()