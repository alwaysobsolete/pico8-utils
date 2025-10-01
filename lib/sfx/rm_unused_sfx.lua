---remove sfx not used in music
--
-- call cstore() to save
--
-- @depends
-- @see sfx_reset
--
-- @param sfxstart {integer} start of sfx range to remove
-- @param sfxend {integer} end of sfx range to remove
function rm_unused_sfx(sfxstart, sfxend)
	--store removed sfx indexes
	local removed = {}

	--loop through sfx
	for sfx_num = sfxstart or 8, sfxend or 63 do
		--loop through music patterns
		for pat_num = 0, 63 do
			local addr = 0x3100 + pat_num * 4

			--loop through channels
			for ch_num = 0, 3 do
				local byte = peek(addr + ch_num)
				local enabled = 0x40 & byte == 0
				local match = byte & 0x3f == sfx_num

				if
					enabled
					and match
				then
					goto continue
				end
			end
		end

		sfx_reset(sfx_num)

		add(removed, sfx_num)

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
		printh"no unused sfx"
		print"no unused sfx"
	end
end
