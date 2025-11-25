pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---sfx combiner utility cart
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
dest,sub,[...] - combine sfx:\
	example: \"/foo.p8,/bar.p8,/biz.p8,/baz.p8\"\
	dest - path to dest cart, must be below and relative to -root_path\
	add  - path to addend cart(s), must be below and relative to -root_path\
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
	printb("\nsfx combiner\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main
local params = split(PARAM_STR)
local dest = deli(params, 1)
local addends = params

assert(dest ~= nil and dest ~= "", "dest is required\n" .. MESSAGES.GET_HELP)
assert(addends[2] ~= nil and addends[2] ~= "", "at least two addends are required\n" .. MESSAGES.GET_HELP)

--process addends
local addend = "/" .. addends[1]

printb("loading " .. addend)

reload(0x3100, 0x3100, 0x1200, addend)

for i = 2, #addends do
	local addend = "/" .. addends[i]

	--load audio data
	printb("loading " .. addend)

	reload(0x4300, 0x3100, 0x1200, addend)

	--loop sfx
	for sfx_idx = 0, 63 do
		for note_idx = 0, 31 do
			local note_offset = sfx_idx * 68 + note_idx * 2
			local note_addr = 0x4400 + note_offset
			local note = %note_addr
			local next_note = %(note_addr + 2)
			local prev_note = %(note_addr - 2)

			if
				--note is audible
				get_note_volume(note) > 0
				--note slides from prev note
				or (
					note_idx > 0
					and get_note_effect(note) == 1
					and get_note_volume(prev_note) > 0
				)
				--next note slides from note
				or (
					note_idx < 31
					and get_note_effect(next_note) == 1
					and get_note_volume(next_note) > 0
				)
			then
				--write note
				poke2(0x3200 + note_offset, note)
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
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure dest path is under -root_path\
")
