pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---instrument extractor
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua
#include ../../lib/note/get_note_effect.lua
#include ../../lib/note/get_note_volume.lua
#include ../../lib/note/get_note_waveform.lua
#include ../../lib/note/note_has_instrument_bit.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
src,dest,wave,[inst],[effect] - extract instrument:\
	example: \"foo.p8,bar.p8,0,false,3\"\
	src      - path to src cart, must be below -root_path\
	dest     - path to dest cart, must be below -root_path\
	wave     - waveform index\
	[inst]   - wave is custom instrument\
	[effect] - filter by effect command\
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
	printb("\ninstrument extractor\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--parse param_str
local params = split(PARAM_STR)
local src = deli(params, 1)
local dest = deli(params, 1)
local wave = tonum(deli(params, 1))
local inst = deli(params, 1) ~= ""
local effect = tonum(deli(params, 1)) or false

assert(src ~= nil and src ~= "", "src is required\n" .. MESSAGES.GET_HELP)
assert(sub(src, 1, 1) ~= "~", "shell expansion of ~ not supported")

assert(dest ~= nil and dest ~= "", "dest is required\n" .. MESSAGES.GET_HELP)
assert(sub(dest, 1, 1) ~= "~", "shell expansion of ~ not supported")

assert(wave >= 0 and wave <= 7, "wave must be a number 0-7")

assert(not effect or (effect >= 0 and wave <= 7), "effect must be a number 0-7")

--get src rom
printb("loading " .. src)

reload(0x3100, 0x3100, 0x1200, src)

--process sfx
printb("extracting " .. (inst and "custom inst " or "waveform ") .. wave)

--loop sfx
for sfx_idx = 0, 63 do
	local sfx_offset = sfx_idx * 68

	--copy sfx ctrl bytes
	local ctrl_offset = sfx_offset + 64

	memcpy(
		0x4400 + ctrl_offset,
		0x3200 + ctrl_offset,
		4
	)

	--copy relevant notes
	for note_idx = 0, 31 do
		local note_offset = sfx_offset + note_idx * 2
		local note = %(0x3200 + note_offset)
		local effect_idx = get_note_effect(note)

		if
			get_note_waveform(note) == wave
			and (
				not inst
				or note_has_instrument_bit(note)
			-- note is audible
			) and (
				get_note_volume(note) > 0
				or (
					note_idx > 0
					and effect_idx == 1
				)
			-- note uses effect
			) and (
				not effect
				or effect_idx == effect
			)
		then
			poke2(0x4400 + note_offset, note)
		end
	end
end

--copy instrument
if inst then
	local offset = wave * 68

	memcpy(
		0x4400 + offset,
		0x3200 + offset,
		68
	)
end

--write dest rom
printb("writing " .. dest)

--copy patterns
cstore(0x3100, 0x3100, 0x0100, dest)
--copy modified sfx
cstore(0x3200, 0x4400, 0x1100, dest)

--message
printb("\
success?\
\
if " .. dest .. " does not exist, was not modified, or was corrupted, ensure both src and dest paths are under -root_path\
")
