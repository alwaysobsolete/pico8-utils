---optimize sfx data
--
-- zero-out unused note data
function optimize_sfx(sfx_idx)
	-- loop notes
	for note_idx = 0, 31 do
		local note_addr = 0x3200 + (sfx_idx * 68) + (note_idx * 2)
		local note = %note_addr

		if
			-- volume is 0
			note & 0xe000 == 0
			and (
				-- does not use slide cmd
				note & 0x7000 ~= 1 << 12
				-- or is not first note
				or i ~= 0
			)
		then
			peek2(note_addr, 0)
		end
	end
end
