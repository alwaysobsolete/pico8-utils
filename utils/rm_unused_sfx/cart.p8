pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---remove unused sfx utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/music/get_unused_sfx.lua
#include ../../lib/sfx/get_unused_instruments.lua
#include ../../lib/sfx/get_used_instruments.lua
#include ../../lib/sfx/note_uses_instrument.lua
#include ../../lib/sfx/rm_unused_instruments.lua
#include ../../lib/sfx/rm_unused_sfx.lua
#include ../../lib/sfx/sfx_reset.lua
#include ../../lib/sfx/sfx_uses_instrument.lua
#include ../../lib/table/make_range_lookup.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,[dest],[excluded,...] - remove sfx not used in any pattern:\
	example: \"foo.p8,bar.p8,8,12-16\"\
	src - path to src cart, must be below -root_path\
	[dest] - path to dest cart, must be below -root_path\
	[excluded,...] - instrument indexes to exclude\
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
	printb("\nremove unused sfx\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = deli(params, 1)
local dest = deli(params, 1)
local excluded = params

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3100, 0x3100, 0x1200, src)

--remove
printb("removing unused sfx...")

rm_unused_sfx(unpack(excluded))

--write dest rom
printb("writing " .. dest)

cstore(0x3100, 0x3100, 0x1200, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
