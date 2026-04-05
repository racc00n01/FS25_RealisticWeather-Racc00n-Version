RW_DensityMapHeightManager = {}


function RW_DensityMapHeightManager:loadMapData(superFunc, xmlFile, missionInfo, baseDirectory)
    local returnValue = superFunc(self, xmlFile, missionInfo, baseDirectory)

    g_currentMission.fireSystem = FireSystem.new()

    if g_currentMission:getIsServer() then
        g_currentMission.fireSystem:loadFromXMLFile()
    end

    return returnValue
end

DensityMapHeightManager.loadMapData = Utils.overwrittenFunction(DensityMapHeightManager.loadMapData,
    RW_DensityMapHeightManager.loadMapData)
