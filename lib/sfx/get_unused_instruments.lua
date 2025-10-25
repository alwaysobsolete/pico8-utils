---get unused custom instruments
--
--@return {table} unused custom instrument indexes
function get_unused_instruments()
	local unused = {}

	-- loop instrument indexes
	for i = 0, 7 do
		-- loop sfx
		for sfx_idx = 0, 63 do
			local addr = 0x3200 + sfx_idx * 68

			-- loop notes
			for note_idx = 0, 31 do
				local note = %(addr + note_idx * 2)

				if
					-- custom instrument bit
					note & 0x8000 ~= 0
					-- waveform is i
					and note & 0x01c0 == i << 6
					and (
						-- volume is not 0
						note & 0xe000 ~= 0
						-- does not use slide cmd
						or note & 0x7000 ~= 1 << 12
					)
				then
					goto next_i
				end
			end
		end

		add(unused, i)

		::next_i::
	end

	return unused
end
