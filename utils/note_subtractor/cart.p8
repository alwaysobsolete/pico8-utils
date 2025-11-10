pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---note subtractor utility cart
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/note/get_note_effect.lua
#include ../../lib/note/get_note_volume.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,dest,sub,[...] - subtract notes:\
	example: \"/foo.p8,/bar.p8,/biz.p8,/baz.p8\"\
	src  - path to src cart, must be below and relative to -root_path\
	dest - path to dest cart, must be below and relative to -root_path\
	sub  - path to subtrahend cart(s), must be below and relative to -root_path\
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
	printb("\nnote subtractor\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main
local params = split(PARAM_STR)
local src = deli(params, 1)
local dest = deli(params, 1)
local subtrahends = params

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)
assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

assert(dest ~= nil and dest ~= "", "dest is required\n" .. MESSAGES.GET_HELP)
assert(sub(dest, 1, 1) ~= "~", "shell expansion of ~ not supported")

assert(subtrahends[1] ~= nil and subtrahends[1] ~= "", "at least one subtrahend is required\n" .. MESSAGES.GET_HELP)
assert(sub(subtrahends[1], 1, 1) ~= "~", "shell expansion of ~ not supported")

--get src rom
printb("loading " .. src)

reload(0x3100, 0x3100, 0x1200, src)

--process subtrahends
for subtrahend in all(subtrahends) do
	--load audio data
	printb("loading " .. subtrahend)

	reload(0x4300, 0x3200, 0x1100, subtrahend)

	--loop sfx
	for sfx_idx = 0, 63 do
		--loop notes
		for note_idx = 0, 31 do
			local note_offset = sfx_idx * 68 + note_idx * 2
			local note = %(0x4300 + note_offset)

			if
				--note is audible
				get_note_volume(note) > 0
				or (
					note_idx > 0
					and get_note_effect(note) == 1
				)
			then
				--subtract note
				poke2(0x3200 + note_offset, 0)
			end
		end
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
