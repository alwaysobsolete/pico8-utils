---get note waveform
--
--@param note {number} - 2-byte note value
--
--@return {0-7} - note waveform value
function get_note_waveform(note)
	return (note & 0x01c0) >>> 6
end
