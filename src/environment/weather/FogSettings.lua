function FogSettings:readStream(streamId, connection)
	self.groundFogCoverageEdge0 = streamReadFloat32(streamId)
	self.groundFogCoverageEdge1 = streamReadFloat32(streamId)
	self.groundFogExtraHeight = streamReadFloat32(streamId)
	self.groundFogGroundLevelDensity = streamReadFloat32(streamId)
	self.groundFogMinValleyDepth = streamReadFloat32(streamId)
	self.heightFogMaxHeight = streamReadFloat32(streamId)
	self.heightFogGroundLevelDensity = streamReadFloat32(streamId)
	self.groundFogStartDayTimeMinutes = streamReadUInt16(streamId)
	self.groundFogEndDayTimeMinutes = streamReadUInt16(streamId)

	local numWeatherTypes = streamReadUInt8(streamId)

	self.groundFogWeatherTypes = {}

	for i = 1, numWeatherTypes do
		local weatherTypeName = streamReadString(streamId)
		local weatherType = WeatherType.getByName(weatherTypeName)

		if weatherType ~= nil then self.groundFogWeatherTypes[weatherType] = true end
	end
end

function FogSettings:writeStream(streamId, connection)
	streamWriteFloat32(streamId, self.groundFogCoverageEdge0)
	streamWriteFloat32(streamId, self.groundFogCoverageEdge1)
	streamWriteFloat32(streamId, self.groundFogExtraHeight)
	streamWriteFloat32(streamId, self.groundFogGroundLevelDensity)
	streamWriteFloat32(streamId, self.groundFogMinValleyDepth)
	streamWriteFloat32(streamId, self.heightFogMaxHeight)
	streamWriteFloat32(streamId, self.heightFogGroundLevelDensity)
	streamWriteUInt16(streamId, self.groundFogStartDayTimeMinutes)
	streamWriteUInt16(streamId, self.groundFogEndDayTimeMinutes)

	local numWeatherTypes = 0

	for weatherType, _ in pairs(self.groundFogWeatherTypes) do numWeatherTypes = numWeatherTypes + 1 end

	streamWriteUInt8(streamId, numWeatherTypes)

	for weatherType, _ in pairs(self.groundFogWeatherTypes) do streamWriteString(streamId, WeatherType.getName(weatherType)) end
end
