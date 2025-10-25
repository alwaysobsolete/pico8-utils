---remove unused instrument sfx
--
-- call cstore() to save
--
-- @depends
-- @see get_unused_instruments
-- @see printb
-- @see sfx_reset
--
-- @param ... {[0-7], ...} - excluded instrument indexes
function rm_unused_instruments(...)
	-- cache excluded indexes
	local excluded = {}

	for i in all({...}) do
		excluded[i] = true
	end

	-- unused instruments
	for i in all(get_unused_instruments()) do
		if not excluded[i] then
			sfx_reset(i)
			printb("removed: " .. i)
		end
	end
end
