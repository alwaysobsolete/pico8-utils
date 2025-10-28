---set sfx speed
--
--@param sfx_index {integer} sfx index
--@param spd {integer} speed to set
function sfx_speed(sfx_index, spd)
	poke(0x3200 + i * 68 + 65, spd)
end
