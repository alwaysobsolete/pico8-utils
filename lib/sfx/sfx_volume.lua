---modify sfx volume
--
-- @param sfx_idx {integer} - sfx index
-- @param n {integer} volume to increment/decrement by
function sfx_volume(sfx_idx, n)
	local sfx_addr = 0x3200 + sfx_num * 68

	--loop through all notes
	for note_addr = sfx_addr, sfx_addr + 63, 2 do
		local note = %note_addr
		local volume = (note & 0xe00) >>> 9
		local newvolume = volume > 0 and mid(1, volume + n, 7) or 0

		poke2(note_addr, note & 0xf1ff | (newvolume << 9))
	end
end
