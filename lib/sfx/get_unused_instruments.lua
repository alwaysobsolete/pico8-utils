---get unused custom instruments
--
--@depends
--@see sfx_uses_instrument
--@see get_note_effect
--@see get_note_volume
--@see get_note_waveform
--@see note_has_instrument_bit
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
