ExtendedMower = {}


function ExtendedMower.prerequisitesPresent(specializations)
	return SpecializationUtil.hasSpecialization(Mower, specializations)
end


function ExtendedMower.registerFunctions(vehicleType) end


function ExtendedMower.registerOverwrittenFunctions(vehicleType)
	SpecializationUtil.registerOverwrittenFunction(vehicleType, "processMowerArea", ExtendedMower.processMowerArea)
end


function ExtendedMower:processMowerArea(superFunc, workArea, dt)

	if not self.isServer and self.currentUpdateDistance > Mower.CLIENT_DM_UPDATE_RADIUS then return superFunc(self, workArea, dt) end

	if g_realisticWeather ~= nil then g_realisticWeather:preProcessMowerArea(self, workArea, dt) end

	local lastChangedArea, lastTotalArea = superFunc(self, workArea, dt)

	if g_realisticWeather ~= nil then g_realisticWeather:postProcessMowerArea(self, workArea, dt, lastChangedArea) end

	return lastChangedArea, lastTotalArea

end