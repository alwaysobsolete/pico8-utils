---get unused custom instruments
--
--@depends
--@see note_uses_instrument
--@see sfx_uses_instrument
--
--@return {table} unused custom instrument indexes
function get_unused_instruments()
	local unused = {}

	-- loop instrument indexes
	for inst_idx = 0, 7 do
		-- loop sfx
		for sfx_idx = 0, 63 do
			if
				sfx_uses_instrument(sfx_idx, inst_idx)
			then
				goto next_instrument
			end
		end

		add(unused, inst_idx)

		::next_instrument::
	end

	return unused
end
