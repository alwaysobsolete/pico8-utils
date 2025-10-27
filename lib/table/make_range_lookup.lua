---make integer range lookup table
--
-- @param ... {[integer[-[integer]]], ...} - integer or integer range to be true
function make_range_lookup(...)
	local lookup = {}

	for key in all({...}) do
		local start, finish = unpack(split(key, "-"))

		if not finish then
			finish = start
		end

		assert(tonum(start), "start must be a number")
		assert(tonum(finish), "finish must be a number")

		for i = start, finish do
			lookup[i] = true
		end
	end

	return lookup
end
