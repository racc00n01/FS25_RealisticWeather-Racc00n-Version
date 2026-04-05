FogUpdater.setTargetFog = Utils.appendedFunction(FogUpdater.setTargetFog, function(self, fog, duration)
	g_server:broadcastEvent(FogStateEvent.new(self))
end)


function FogUpdater:readStream(streamId, connection)
	self.alpha = streamReadFloat32(streamId)
	self.visibilityAlpha = streamReadFloat32(streamId)
	self.duration = streamReadFloat32(streamId)

	self.targetFog:readStream(streamId, connection)
	self.lastFog:readStream(streamId, connection)
	self.currentFog:readStream(streamId, connection)

	self.isDirty = true
end

function FogUpdater:writeStream(streamId, connection)
	streamWriteFloat32(streamId, self.alpha)
	streamWriteFloat32(streamId, self.visibilityAlpha)
	streamWriteFloat32(streamId, self.duration)

	self.targetFog:writeStream(streamId, connection)
	self.lastFog:writeStream(streamId, connection)
	self.currentFog:writeStream(streamId, connection)
end
