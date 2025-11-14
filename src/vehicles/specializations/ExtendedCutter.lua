ExtendedCutter = {}


function ExtendedCutter.prerequisitesPresent(specializations)
	return SpecializationUtil.hasSpecialization(Cutter, specializations)
end


function ExtendedCutter.registerFunctions(vehicleType) end


function ExtendedCutter.registerOverwrittenFunctions(vehicleType)
	SpecializationUtil.registerOverwrittenFunction(vehicleType, "processCutterArea", ExtendedCutter.processCutterArea)
end


function ExtendedCutter:processCutterArea(superFunc, workArea, dt)

	if not self.isServer and self.currentUpdateDistance > Cutter.CLIENT_DM_UPDATE_RADIUS then return superFunc(self, workArea, dt) end

	if g_realisticWeather ~= nil then g_realisticWeather:preProcessCutterArea(self, workArea, dt) end

	local lastChangedArea, lastTotalArea = superFunc(self, workArea, dt)

	if g_realisticWeather ~= nil then g_realisticWeather:postProcessCutterArea(self, workArea, dt, lastChangedArea) end

	return lastChangedArea, lastTotalArea

end