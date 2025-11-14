-- Might use this for something else in the future
-- Placeholder for now


GroundMoistureMap = {}

GroundMoistureMap.COLOURS = {
	["LOW"] = {
		{ 1, 0, 0, 1 },
		{ 0.67, 0, 0, 1 },
		{ 0.33, 0, 0, 1 }
	},
	["HIGH"] = {
		{ 0, 0, 1, 1 },
		{ 0, 0, 0.67, 1 },
		{ 0, 0, 0.33, 1 }
	}
}


GroundMoistureMap.NUM_VALUES = 2


local GroundMoistureMap_mt = Class(GroundMoistureMap)


function GroundMoistureMap.new(parent)

	local self = setmetatable({}, GroundMoistureMap_mt)

	self.parent = parent

	return self

end


function GroundMoistureMap:buildOverlay(overlayId, valueFilter, isColourBlindMode)

	print("---", "Building Overlay")

	local moistureSystem = g_currentMission.moistureSystem
	resetDensityMapVisualizationOverlay(overlayId)
	setOverlayColor(overlayId, 1, 1, 1, 1)

	if valueFilter[1] then



	end


	if valueFilter[2] then



	end

	print("Finished Building Overlay", "---")

end


function GroundMoistureMap:getOverviewLabel()

	return "Ground Moisture"

end


function GroundMoistureMap:getShowInMenu()

	return true

end


function GroundMoistureMap:getDisplayValues()

	if self.valuesToDisplay == nil then

		self.valuesToDisplay = {}

		for displayType, colours in pairs(GroundMoistureMap.COLOURS) do

			local displayValue = {
				["colors"] = {
					[true] = colours,
					[false] = colours
				},
				["description"] = displayType
			}

			table.insert(self.valuesToDisplay, displayValue)

		end

	end

	return self.valuesToDisplay

end


function GroundMoistureMap:getValueFilter()

	if self.valueFilter == nil or self.valueFilterEnabled == nil then

		self.valueFilter = {}
		self.valueFilterEnabled = {}
		
		for i = 1, GroundMoistureMap.NUM_VALUES do
			table.insert(self.valueFilter, true)
			table.insert(self.valueFilterEnabled, true)
		end

	end

	return self.valueFilter, self.valueFilterEnabled

end