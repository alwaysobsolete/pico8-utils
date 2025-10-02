pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---sfx transpose utility
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/sfx/sfx_reset.lua
#include ../../lib/sfx/sfx_transpose.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
sfxstart[-sfxend],semitones,src,[dest] - transpose sfx:\
	example: \"1,8-15,foo.p8,bar.p8\"\
	sfxstart - sfx index to modify\
		follow with hyphen and sfxend to specify range\
	semitones - semitones to transpose by\
	src - path to src cart, must be below -root_path\
	[dest] - path to dest cart, must be below -root_path\
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
	printb("\nsfx transpose\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local range, semitones, src, dest = unpack(split(PARAM_STR))

local sfxstart, sfxend = unpack(split(range, "-"))

if (not sfxend or type(sfxend) ~= "number") then
	sfxend = sfxstart
end

assert(type(sfxstart) == "number", "sfxstart must be number\n" .. MESSAGES.GET_HELP)

assert(semitones, "semitones must be a number\n" .. MESSAGES.GET_HELP)

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)

assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

if (not dest or dest == "") then
	dest = src
end

--get src rom
printb("loading " .. src)

reload(0x3200, 0x3200, 0x1100, src)

--transpose
printb("transposing sfx...")

sfx_transpose(semitones, sfxstart, sfxend)

--write dest rom
printb("writing " .. dest)

cstore(0x3200, 0x3200, 0x1100, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
