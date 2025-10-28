---get used custom instruments
--
--@depends
--@see note_uses_instrument
--@see sfx_uses_instrument
--
--@return {table} used custom instrument indexes
function get_used_instruments()
	local used = {}

	-- loop instrument indexes
	for inst_idx = 0, 7 do
		-- loop sfx
		for sfx_idx = 0, 63 do
			if
				sfx_uses_instrument(sfx_idx, inst_idx)
			then
				add(used, inst_idx)

				goto next_instrument
			end
		end

		::next_instrument::
	end

	return used
end
