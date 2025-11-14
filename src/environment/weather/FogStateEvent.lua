FogStateEvent = {}
local FogStateEvent_mt = Class(FogStateEvent, Event)
InitEventClass(FogStateEvent, "FogStateEvent")


function FogStateEvent.emptyNew()

	return Event.new(FogStateEvent_mt)

end


function FogStateEvent.new(fogUpdater)

	local self = FogStateEvent.emptyNew()
	
	self.fogUpdater = fogUpdater

	return self

end


function FogStateEvent:readStream(streamId, connection)

	local fogUpdater = g_currentMission.environment.weather.fogUpdater
	fogUpdater:readStream(streamId, connection)
	self:run(connection)

end


function FogStateEvent:writeStream(streamId, connection)

	self.fogUpdater:writeStream(streamId, connection)

end


function FogStateEvent:run(connection)



end