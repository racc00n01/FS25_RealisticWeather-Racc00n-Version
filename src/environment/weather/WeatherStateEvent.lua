RW_WeatherStateEvent = {}


function RW_WeatherStateEvent.new(snowHeight, timeSinceLastRain, lastFogDay)
    local self = WeatherStateEvent.emptyNew()
    self.snowHeight = snowHeight
    self.timeSinceLastRain = timeSinceLastRain
    self.lastFogDay = lastFogDay
    return self
end

WeatherStateEvent.new = RW_WeatherStateEvent.new


function RW_WeatherStateEvent:readStream(_, streamId, connection)
    self.snowHeight = streamReadFloat32(streamId)
    self.timeSinceLastRain = streamReadFloat32(streamId)
    self.lastFogDay = streamReadUInt16(streamId)

    self:run(connection)
end

WeatherStateEvent.readStream = Utils.overwrittenFunction(WeatherStateEvent.readStream, RW_WeatherStateEvent.readStream)


function RW_WeatherStateEvent:writeStream(_, connection, _)
    streamWriteFloat32(connection, self.snowHeight)
    streamWriteFloat32(connection, self.timeSinceLastRain)
    streamWriteUInt16(connection, self.lastFogDay or 0)
end

WeatherStateEvent.writeStream = Utils.overwrittenFunction(WeatherStateEvent.writeStream, RW_WeatherStateEvent
    .writeStream)


function RW_WeatherStateEvent:run(_, _)
    g_currentMission.environment.weather:setInitialState(self.snowHeight, self.timeSinceLastRain, self.lastFogDay)
end

WeatherStateEvent.run = Utils.overwrittenFunction(WeatherStateEvent.run, RW_WeatherStateEvent.run)
