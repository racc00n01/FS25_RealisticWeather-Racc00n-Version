local modName = g_currentModName
local specialisations = {
	["sprayer"] = { modName .. ".extendedSprayer" },
	["cutter"] = { modName .. ".extendedCutter" },
	["mower"] = { modName .. ".extendedMower" }
}


TypeManager.finalizeTypes = Utils.appendedFunction(TypeManager.finalizeTypes, function(self)

	if self.typeName == "vehicle" then

		for typeName, vehicleType in pairs(self:getTypes()) do

			for i = #vehicleType.specializationNames, 1, -1 do

				for specName, specs in pairs(specialisations) do

					if vehicleType.specializationNames[i] ~= specName then continue end

					for _, spec in pairs(specs) do
						if vehicleType.specializationsByName[spec] == nil then self:addSpecialization(typeName, spec) end
					end

				end

			end

		end

	end

end)