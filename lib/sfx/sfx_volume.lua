---modify volume of all sfx
--
-- @param n {integer} volume to increment/decrement by
-- @param sfxstart {integer} start of sfx range to remove
-- @param sfxend {integer} end of sfx range to remove
function sfx_volume(n, sfxstart, sfxend)
	--loop through
	--all non-instrument sfx
	for sfx_num = sfxstart or 8, sfxend or 63 do
		local sfx_addr = 0x3200 + sfx_num * 68

		--loop through all notes
		for note_num = 0, 31 do
			local note_addr = sfx_addr + note_num * 2
			--get note from ram
			local note = %note_addr
			--get volume bits
			local volume = (note & 0xe00) >>> 9
			--calculate new volume
			local newvolume = volume > 0 and mid(1, volume + n, 7) or 0

			--insert new note
			poke2(note_addr, note & 0xf1ff | (newvolume << 9))
		end
	end
end
