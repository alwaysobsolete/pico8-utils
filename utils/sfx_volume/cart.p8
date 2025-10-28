pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---modify sfx volume utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/sfx/sfx_volume.lua
#include ../../lib/table/make_range_lookup.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,[dest],delta,[excluded,...] - modify sfx volume:\
	example: \"foo.p8,bar.p8,-1,0-7\"\
	src - path to src cart, must be below -root_path\
	[dest] - path to dest cart, must be below -root_path\
	delta - amount to add or subtract from note volume\
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
	printb("\nmodify sfx volume\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = deli(PARAM_STR, 1)
local dest = deli(PARAM_STR, 1)
local delta = deli(PARAM_STR, 1)

assert(tonum(delta), "delta must be a number\n" .. MESSAGES.GET_HELP)

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3200, 0x3200, 0x1100, src)

--transpose
printb("modifying sfx volume by " .. delta .. "...")

local excluded = make_range_lookup(unpack(params))

for i = 0, 63 do
	if not excluded[i] then
		sfx_volume(i, semitones)
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
