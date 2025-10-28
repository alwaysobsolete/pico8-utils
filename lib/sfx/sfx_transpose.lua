---transpose sfx
--
-- @param sfx_index {integer} - sfx index
-- @param semitones {integer} - number of semitones to transpose up or down
function sfx_transpose(sfx_idx, semitones)
	local sfx_addr = 0x3200 + sfx_idx * 2

	for note_addr = sfx_addr, sfx_addr + 63, 2 do
		local byte = @note_addr
		local pitch = 0x3f & byte
		local newpitch = mid(0, pitch + semitones, 63)
		local new_note = (byte & 0xc0) | newpitch

		poke(note_addr, new_note)
	end
end
