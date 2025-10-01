pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
---utility cart template
--by alwaysobsolete

-->8
--dependencies

#include ../../lib/gfx/printb.lua

-->8
--constants

local MESSAGES = {
	HELP = "\
usage: pico8 -root_path /path/to/root -p \"param_str\" [-x | -run] /path/to/this/cart\
\
param string options:\
help - print this message\
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
	printb("\nutility cart template\n" .. MESSAGES.HELP)
	stop()
end

-->8
--main

--do stuff
