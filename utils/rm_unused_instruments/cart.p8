pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---remove unused custom instruments utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/sfx/get_unused_instruments.lua
#include ../../lib/sfx/rm_unused_instruments.lua
#include ../../lib/sfx/sfx_reset.lua
#include ../../lib/table/make_range_lookup.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,[dest],[excluded,...] - remove custom instruments:\
	example: \"/foo.p8,/bar.p8,0,3\"\
	src - path to src cart, must be below and relative to -root_path\
	[dest] - path to dest cart, must be below and relative to -root_path\
	[excluded,...] - instrument indexes to exclude,\
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
	printb("\nremove unused custom instruments\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = deli(params, 1)
local dest = deli(params, 1)
local excluded = params

load(src)

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3200, 0x3200, 0x1100, src)

--remove
printb("removing unused custom instruments...")

rm_unused_instruments(unpack(excluded))

--write dest rom
printb("writing " .. dest)

cstore(0x3200, 0x3200, 0x1100, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
