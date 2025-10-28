---optimize pattern data
--
-- zero out unused channel data
--
-- @param pat_idx {integer} - pattern index to optimize
function optimize_pattern(pat_idx)
	local pat = $(0x3100 + pat_idx * 4)
	local mask = 0

	for channel = 0, 3 do
		-- channel bit offset
		local offset = 8 * channel

		-- channel enabled
		if byte & 0x0000.0040 << offset == 0 then
			mask = mask | 0x0000.003f << offset
		end
	end

	-- if any channel active,
	-- preserve loop bits
	if mask ~= 0 then
		mask = mask | 0x8080.8080
	end

	-- write optimized pattern
	poke4(pat_addr, pat & mask)
end
