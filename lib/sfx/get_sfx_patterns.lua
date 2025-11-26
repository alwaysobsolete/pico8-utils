--- get patterns using sfx
---
-- @param sfx_id {integer} - sfx id
--
-- @returns {table} - table of pattern indexes
function get_sfx_patterns(sfx_idx)
	local patterns = {}

	for pat_idx = 0, 63 do
		for ch_idx = 0, 3 do
			local ch = @(0x3100 + pat_idx * 4 + ch_idx)

			if
				-- sfx used
				ch & 0x3f == sfx_idx
				-- channel enabled
				and ch & 0x40 == 0
			then
				add(patterns, pat_idx)
				goto next_pat
			end
		end

		::next_pat::
	end

	return patterns
end
