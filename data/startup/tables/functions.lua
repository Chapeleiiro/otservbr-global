
function loadLuaMapAction(tablename)
	-- It load actions
	for index, value in pairs(tablename) do
		for i = 1, #value.itemPos do
			local tile = Tile(value.itemPos[i])
			local item
			-- Checks if the position is valid
			if tile then
				-- Checks that you have no items created
				if tile:getItemCountById(value.itemId) == 0 then
					-- If not have items created, this create the item
					item = Game.createItem(value.itemId, 1, value.itemPos[i])
				end
				if not item then
					item = tile:getItemById(value.itemId)
				end
				-- If he found the item, add the action id.
				if item and value.actionId then
					item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, index)
				end
				if value.itemId == false and tile:getTopDownItem() then
					tile:getTopDownItem():setAttribute(ITEM_ATTRIBUTE_ACTIONID, index)
				end
				if value.itemId == false and tile:getTopTopItem() then
					tile:getTopTopItem():setAttribute(ITEM_ATTRIBUTE_ACTIONID, index)
				end
			end
		end
	end
end

function loadLuaMapUnique(tablename)
	-- It load uniques
	for key, value in pairs(tablename) do
		local tile = Tile(value.itemPos)
		local item
		-- Checks if the position is valid
		if tile then
			-- Checks that you have no items created
			if tile:getItemCountById(value.itemId) == 0 then
				-- If not have items created, thisc create the item
				item = Game.createItem(value.itemId, 1, value.itemPos)
			end
			if not item then
				item = tile:getItemById(value.itemId)
			end
			-- If he found the item, add the unique id
			if item then
				item:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, key)
			end
		end
	end
end

function loadLuaMapSign(tablename)
	-- It load signs on map table
	for key, value in pairs(tablename) do
		local tile = Tile(value.itemPos)
		local item
		-- Checks if the position is valid
		if tile then
			-- Checks that you have no items created
			if tile:getItemCountById(value.itemId) == 0 then
				-- Create item
				item = Game.createItem(value.itemId, 1, value.itemPos)
			end
			if not item then
				item = tile:getItemById(value.itemId)
			end
			-- If he found the item, add the text
			if item then
				item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, value.text)
			end
		end
	end
	print("> Loaded " .. (#SignTable) .. " signs in the map.")
end

function loadLuaMapBook(tablename)
	-- It load book on map table
	for key, value in pairs(tablename) do
		local tile = Tile(value.itemPos)
		local item
		-- Checks if the position is valid
		if tile then
			-- Checks that you have no items created
			if tile:getItemCountById(value.itemId) == 0 then
				-- Create item
				item = Game.createItem(value.itemId, 1, value.itemPos) 
			end
			if not item then
				item = tile:getItemById(value.itemId)
			end
			-- If he found the item, add the text
			if item then
				item:setAttribute(ITEM_ATTRIBUTE_TEXT, value.text)
			end
		end
	end
	print("> Loaded " .. (#BookTable) .. " books in the map.")
end

function loadLuaNpcs(tablename)
	for index, value in pairs(tablename) do
		if value.name and value.position then
			local spawn = Game.createNpc(value.name, value.position)
			if spawn then
				spawn:setMasterPos(value.position)
				Game.setStorageValue(Storage.NpcSpawn, 1)
			end
		end
	end
	print(string.format("> Loaded ".. (#NpcTable) .." npcs and spawned %d monsters.\n> \z
	Loaded %d towns with %d houses in total.", Game.getMonsterCount(), #Game.getTowns(), #Game.getHouses()))
end

function loadCustomMaps()
	for index, value in ipairs(CustomMapTable) do
		if value.enabled then
			-- It's load the map
			Game.loadMap(value.file)
			Game.setStorageValue(Storage.NpcSpawn, 1)
		end
	end
	print("> Loaded " .. (#CustomMapTable) .. " custom maps.")
end