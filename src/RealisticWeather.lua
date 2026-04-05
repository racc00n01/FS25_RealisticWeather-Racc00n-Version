RealisticWeather = {}
local RealisticWeather_mt = Class(RealisticWeather)
local modDirectory = g_currentModDirectory

source(modDirectory .. "src/test/OptimisationTest.lua")


function RealisticWeather.new()

	local self = setmetatable({}, RealisticWeather_mt)

    self.changedFunctions = {}

	return self

end


function RealisticWeather:initialise()

end


function RealisticWeather.loadMap()

    g_realisticWeather:executeFunctionChanges()

end


function RealisticWeather:registerFunction(object, oldFunc, newFunc, changeFunc)

	table.insert(self.changedFunctions, {
		["object"] = object,
		["oldFunc"] = oldFunc,
		["newFunc"] = newFunc,
		["changeFunc"] = changeFunc or "overwritten"
	})

end


function RealisticWeather:executeFunctionChanges()

	for _, func in pairs(self.changedFunctions) do

		func.object[func.oldFunc] = Utils[func.changeFunc .. "Function"](func.object[func.oldFunc], func.newFunc)

	end

end


g_realisticWeather = RealisticWeather.new()
g_realisticWeather:initialise()
addModEventListener(RealisticWeather)
