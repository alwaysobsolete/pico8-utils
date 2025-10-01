---set sfx speed
--
--@param speed {integer} speed to set
--@param sfxstart {integer} start of sfx range
--@param sfxend {integer} end of sfx range
function sfx_speed(spd,sfxstart,sfxend)
	for i=sfxstart or 8, sfxend or 63 do
		local addr = 0x3200 + i * 68
		poke(addr + 65, spd)
	end
end

