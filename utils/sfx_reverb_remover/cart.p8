pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---remove sfx reverb utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/sfx/sfx_speed.lua
#include ../../lib/table/make_range_lookup.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,[dest][excluded,...] - remove reverb:\
	example: \"/foo.p8,/bar.p8,8,16-32\"\
	src - path to src cart, must be below and relative to -root_path\
	[dest] - path to dest cart, must be below and relative to -root_path\
	[excluded,...] - sfx indexes to exclude,\
		comma-delimited, can provide hyphen-delimited range, eg, 8-16\
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
	printb("\nremove sfx reverb\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = "/" .. deli(params, 1)
local dest = "/" .. deli(params, 1)
local excluded = make_range_lookup(unpack(params))

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3100, 0x3100, 0x1200, src)

--remove reverb
printb("removing sfx reverb...")

for sfx_idx = 0, 63 do
	if not excluded[i] then
		local addr = 0x3200 + sfx_idx * 68 + 64
		local byte = @addr

		--encode new byte
		local new_byte = byte & 0x7
		new_byte += (byte \ 8 % 3) * 8
		new_byte += (byte \ 72 % 3) * 72

		poke(addr, new_byte)

		printb("updated: " .. sfx_idx)
	end
end

--write dest rom
printb("writing " .. dest)

cstore(0x3100, 0x3100, 0x1200, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
