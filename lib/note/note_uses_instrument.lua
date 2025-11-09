---note uses custom instrument
--
--@param sfx_idx {0-63} - sfx index
--@param note_idx {0-31} - note index
--@param inst_idx {0-7} - custom instrument index
--
--@return {boolean} true if sfx uses instrument
function note_uses_instrument(sfx_idx, note_idx, inst_idx)
	local note = %(0x3200 + (sfx_idx * 68) + (note_idx * 2))

	return (
		-- custom instrument bit
		note & 0x8000 ~= 0
		-- waveform is i
		and note & 0x01c0 == inst_idx << 6
		and (
			-- volume is not 0
			note & 0xe000 ~= 0
			-- does not use slide cmd
			or note & 0x7000 ~= 1 << 12
		)
	)
end
