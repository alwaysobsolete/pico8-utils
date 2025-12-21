---transpose sfx
--
-- @param sfx_index {integer} - sfx index
-- @param semitones {integer} - number of semitones to transpose up or down
function sfx_transpose(sfx_idx, semitones)
	local sfx_addr = 0x3200 + sfx_idx * 68

	for note_idx = 0, 31 do
		local note_addr = sfx_addr + note_idx * 2
		local note = %note_addr
		local newpitch = (note & 0x3f) + semitones

		if
			--newpitch out of range
			(
				newpitch < 0
				or newpitch > 63
			)
			--note is audible
			and (
				get_note_volume(note) > 0
				or (
					get_note_effect(note) == 1
					and note_idx > 0
					and get_note_volume(%(note_addr - 2)) > 0
				)
			)
		then
			printb("warning: sfx " .. sfx_idx .. ", note " .. note_idx .. " is out of range")
		end

		poke2(
			note_addr,
			(note & 0xffc0) | mid(0, newpitch, 63)
		)
	end
end
