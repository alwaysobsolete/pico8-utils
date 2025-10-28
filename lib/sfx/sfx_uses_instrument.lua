---sfx uses custom instrument
--
--@depends
--@see note_uses_instrument
--
--@param sfx_idx {0-63} - sfx index
--@param inst_idx {0-7} - custom instrument index
--
--@return {boolean} true if sfx uses instrument
function sfx_uses_instrument(sfx_idx, inst_idx)
	for i = 0, 31 do
		if
			note_uses_instrument(sfx_idx, i, inst_idx)
		then
			return true
		end
	end
end
