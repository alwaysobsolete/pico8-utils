pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---change sfx speed utility
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
src,[dest],spd,[excluded,...] - change sfx speed:\
	example: \"foo.p8,bar.p8,8,16-32\"\
	src - path to src cart, must be below -root_path\
	[dest] - path to dest cart, must be below -root_path\
	spd - new sfx spd\
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
	printb("\nmodify sfx speed\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = deli(PARAM_STR, 1)
local dest = deli(PARAM_STR, 1)
local spd = deli(PARAM_STR, 1)

assert(tonum(spd), "spd must be a number")

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3200, 0x3200, 0x1100, src)

--update spd
printb("updating sfx spd...")

local excluded = make_range_lookup(unpack(params))

for i = 0, 63 do
	if not excluded[i] then
		sfx_speed(i, spd)
		printb("updated: " .. i)
	end
end

--write dest rom
printb("writing " .. dest)

cstore(0x3200, 0x3200, 0x1100, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
