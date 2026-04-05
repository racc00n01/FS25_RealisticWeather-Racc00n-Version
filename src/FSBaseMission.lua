RW_FSBaseMission = {}
local modDirectory = g_currentModDirectory


function RW_FSBaseMission:onStartMission()

	RWSettings.applyDefaultSettings()

    g_overlayManager:addTextureConfigFile(modDirectory .. "gui/icons.xml", "realistic_weather")
    g_overlayManager:addTextureConfigFile(modDirectory .. "gui/page_icons.xml", "realistic_weather_pages")

    if g_modIsLoaded["FS25_RealisticLivestock"] then RW_Weather.isRealisticLivestockLoaded = true end
    if g_modIsLoaded["FS25_ExtendedGameInfoDisplay"] then RW_GameInfoDisplay.isExtendedGameInfoDisplayLoaded = true end

end

FSBaseMission.onStartMission = Utils.prependedFunction(FSBaseMission.onStartMission, RW_FSBaseMission.onStartMission)


function RW_FSBaseMission:sendInitialClientState(connection, _, _)

    local fireSystem = g_currentMission.fireSystem

    connection:sendEvent(RW_BroadcastSettingsEvent.new())
    connection:sendEvent(FireEvent.new(fireSystem.updateIteration, fireSystem.timeSinceLastUpdate, fireSystem.fieldId, fireSystem.fires))

end

FSBaseMission.sendInitialClientState = Utils.prependedFunction(FSBaseMission.sendInitialClientState, RW_FSBaseMission.sendInitialClientState)


function RW_FSBaseMission:initTerrain(_, _)

    g_currentMission.fireSystem:initialize()

end

FSBaseMission.initTerrain = Utils.appendedFunction(FSBaseMission.initTerrain, RW_FSBaseMission.initTerrain)
