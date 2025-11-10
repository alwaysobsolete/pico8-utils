---sfx uses custom instrument
--
--@depends
--@see get_note_effect
--@see get_note_volume
--@see get_note_waveform
--@see note_has_instrument_bit
--
--@param sfx_idx {0-63} - sfx index
--@param inst_idx {0-7} - custom instrument index
--
--@return {boolean} true if sfx uses instrument
function sfx_uses_instrument(sfx_idx, inst_idx)
	for note_idx = 0, 31 do
		local note = %(0x3200 + sfx_idx * 68 + note_idx * 2)

		if
			note_has_instrument_bit(note)
			and get_note_waveform(note) == inst_idx
			-- note is audible
			and (
				get_note_volume(note) > 0
				or (
					note_idx > 0
					and get_note_effect(note) == 1
				)
			)
		then
			return true
		end
	end
end
