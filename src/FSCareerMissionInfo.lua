RW_FSCareerMissionInfo = {}

function RW_FSCareerMissionInfo:saveToXMLFile()
    if self.xmlFile ~= nil and g_currentMission ~= nil and g_currentMission.fireSystem ~= nil then
        g_currentMission.fireSystem:saveToXMLFile(self.savegameDirectory .. "/fires.xml")
        RWSettings.saveToXMLFile()
    end
end

FSCareerMissionInfo.saveToXMLFile = Utils.appendedFunction(FSCareerMissionInfo.saveToXMLFile, RW_FSCareerMissionInfo.saveToXMLFile)
