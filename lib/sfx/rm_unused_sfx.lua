---remove sfx not used in music
--
-- call cstore() to save
--
-- @depends
-- @see get_note_effect
-- @see get_note_volume
-- @see get_note_waveform
-- @see get_unused_sfx
-- @see get_unused_instruments
-- @see get_used_instruments
-- @see make_range_lookup
-- @see note_has_instrument_bit
-- @see printb
-- @see rm_unused_instruments
-- @see sfx_reset
-- @see sfx_uses_instrument
--
-- @param ... {[0-7[-[0-7]]], ...} - excluded sfx indexes
function rm_unused_sfx(...)
	-- cache excluded indexes
	local excluded = make_range_lookup(...)
	-- cache unused indexes
	local unused = get_unused_sfx()

	-- remove instruments from unused cache
	for instrument in all(get_used_instruments()) do
		del(unused, instrument)
	end

	-- remove unused sfx
	printb("removing sfx...")

	for i in all(unused) do
		if not excluded[i] then
			sfx_reset(i)
			printb("removed: " .. i)
		end
	end

	-- remove remaining unused instruments
	printb("removing instruments...")

	rm_unused_instruments(...)
end
