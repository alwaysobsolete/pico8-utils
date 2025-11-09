---get note volume
--
--@param note {number} - 2-byte note value
--
--@return {0-7} - note volume value
function get_note_volume(note)
	return (note & 0x0e00) >>> 9
end
