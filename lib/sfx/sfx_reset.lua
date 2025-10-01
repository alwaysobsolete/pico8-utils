---reset sfx to default
--
--@param index {integer} index of sfx to reset
function sfx_reset(index)
	--reset sfx to default
	print("\^!" .. sub(tostr(0x3200 + index * 68, true), 3, 6) .. "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0▮\0\0")
end
