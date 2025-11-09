---get note effect
--
--@param note {number} - 2-byte note value
--
--@return {0-7} - note effect value
function get_note_effect(note)
	return (note & 0x7000) >>> 12
end
