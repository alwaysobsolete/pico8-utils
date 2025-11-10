pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---optimize audio utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/music/get_unused_sfx.lua
#include ../../lib/music/optimize_pattern.lua
#include ../../lib/note/get_note_effect.lua
#include ../../lib/note/get_note_volume.lua
#include ../../lib/note/get_note_waveform.lua
#include ../../lib/note/note_has_instrument_bit.lua
#include ../../lib/sfx/get_unused_instruments.lua
#include ../../lib/sfx/optimize_sfx.lua
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
src,[dest] - reset sfx:\
	example: \"/foo.p8,/bar.p8\"\
	src - path to src cart, must be below and relative to -root_path\
	[dest] - path to dest cart, must be below and relative to -root_path\
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
	printb("\noptimize audio\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local src, dest = unpack(split(PARAM_STR))

if (not sfxend or type(sfxend) ~= "number") then
	sfxend = sfxstart
end

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3200, 0x3200, 0x1100, src)

--reset
printb("optimizing sfx...")

rm_unused_sfx()

for i = 0, 63 do
	optimize_sfx(i)
end

printb("optimizing patterns...")

for i = 0, 63 do
	optimize_pattern(i)
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
