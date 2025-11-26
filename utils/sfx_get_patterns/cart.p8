pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---get sfx patterns
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/sfx/get_sfx_patterns.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,sfx_idx - get sfx patterns:\
	example: \"/foo.p8,8\"\
	src - path to src cart, must be below and relative to -root_path\
	sfx_idx - sfx index\
",
	GET_HELP = "\
for help, run:\
pico8 -p help [-x | -run] /path/to/this/cart\
"
}

local PARAM_STR = stat(6)

-->8
--lib

-->8
--init

assert(
	PARAM_STR ~= "",
	"\nerror: param_str is required.\n" .. MESSAGES.GET_HELP
)

if (PARAM_STR == "help") then
	printb("\nget sfx patterns\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = "/" .. deli(params, 1)
local sfx_idx = deli(params, 1)

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)
assert(tonum(sfx_idx), "sfx_idx must be a number")

--get src rom
printb("loading " .. src)

reload(0x3100, 0x3100, 0x0100, src)

local patterns = get_sfx_patterns(sfx_idx)

if #patterns == 0 then
	printb("sfx " .. sfx_idx .. " is unused")
else
	printb("sfx " .. sfx_idx .. " used in " .. #patterns .. " patterns:")

	for pat in all(patterns) do
		printb(pat)
	end
end
