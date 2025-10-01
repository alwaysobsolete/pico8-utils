---transpose sfx
--
-- @param semitones {integer} number of semitones to transpose up or down
-- @param sfxstart {integer} start of sfx range to transpose
-- @param sfxend {integer} end of sfx range to transpose
function sfx_transpose(semitones, sfxstart, sfxend)
	for i=0x3200 + (sfxstart or 8) * 68, 0x3200 + (((sfxend or 63) + 1) * 68) - 1, 68 do
		for j=i, i+63, 2 do
			local byte = peek(j)
			local pitch = 0x3f & byte
			local newpitch = mid(0, pitch + semitones, 63)

			poke(j, (0xc0 & byte) | newpitch)
		end
	end
end
