---remove unused instrument sfx
--
-- call cstore() to save
--
-- @depends
-- @see sfx_reset
--
-- @param sfxstart {integer} start of sfx range to remove
-- @param sfxend {integer} end of sfx range to remove
function rm_unused_instruments(sfxstart, sfxend)
	--store removed sfx indexes
	local removed = {}

	--loop through instrument sfx
	for i = 0, 7 do
		--loop through
		--all non-instrument sfx
		for sfx_num = sfxstart or 8, sfxend or 63 do
			local addr = 0x3200 + sfx_num * 68

			--loop through all notes
			for note_num = 0, 31 do
				--get note from ram
				local note = peek2(addr + note_num * 2)

				if
					--note waveform
					--is instrument i
					note & 0x01c0 == i << 6
					--note uses
					--a custom instrument
					and note & 0x8000 ~= 0
					-- note volume is not 0
					and note & 0xe000 ~= 0
				then
					goto continue
				end
			end
		end

		sfx_reset(i)

		add(removed, i)

		::continue::
	end

	--print results
	if #removed > 0 then
		printh"removed sfx:"
		print"removed sfx:"

		for v in all(removed) do
			printh(v)
			print(v)
		end
	else
		printh"no unused instruments"
		print"no unused instruments"
	end
end
