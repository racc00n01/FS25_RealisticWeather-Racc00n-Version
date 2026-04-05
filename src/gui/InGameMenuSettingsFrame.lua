RW_InGameMenuSettingsFrame = {}


function RW_InGameMenuSettingsFrame:onFrameOpen(_)
	for name, setting in pairs(RWSettings.SETTINGS) do
		if setting.dependancy then
			local dependancy = RWSettings.SETTINGS[setting.dependancy.name]
			if dependancy ~= nil and setting.element ~= nil then setting.element:setDisabled(dependancy.state ~=
				setting.dependancy.state) end
		end
	end
end

InGameMenuSettingsFrame.onFrameOpen = Utils.appendedFunction(InGameMenuSettingsFrame.onFrameOpen,
	RW_InGameMenuSettingsFrame.onFrameOpen)
