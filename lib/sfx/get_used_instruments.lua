---get used custom instruments
--
--@depends
--@see get_note_effect
--@see get_note_volume
--@see get_note_waveform
--@see note_has_instrument_bit
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
