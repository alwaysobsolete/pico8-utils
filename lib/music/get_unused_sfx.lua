---get unused sfx
--
--@return {table} unused sfx indexes
function get_unused_sfx()
	local unused = {}

	-- loop sfx
	for sfx_idx = 0, 63 do
		-- loop patterns
		for pat_idx = 0, 63 do
			local addr = 0x3100 + pat_idx * 4

			-- loop channels
			for ch_idx = 0, 3 do
				local byte = @(addr + ch_idx)

				if
					-- channel enabled
					byte & 0x40 == 0
					-- channel uses sfx_idx
					and byte & 0x3f == sfx_idx
				then
					goto next_sfx
				end
			end
		end

		add(unused, sfx_idx)

		::next_sfx::
	end

	return unused
end
