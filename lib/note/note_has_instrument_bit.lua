---note has instrument bit
--
--@param note {number} - 2-byte note value
--
--@return {boolean} true if custom instrument bit is 1
function note_has_instrument_bit(note)
	return note & 0x8000 == 0x8000
end
