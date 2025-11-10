# Instrument Extractor Utility Cart

Extract all notes by waveform, custom instrument, or waveform with specific effect

## Usage

### Command

```shell
pico8 -root_path root_path -p "param_str" [-x | -run] /path/to/this/cart

# example:
pico8 -root_path /carts -p "help" [-x | -run] /path/to/this/cart
```

* `root_path`: Path to use as Pico-8 root directory. Defaults to `folder`.

* `param_str`: Utility cart params.

### param_str

### Help

```shell
help
```

* `"help"`: Prints help

### Options

```shell
src,dest,wave,[inst],[effect]
```

* `src`: Path to src cart, must be below and relative to -root_path\

* `dest`: Path to dest cart, must be below and relative to -root_path\

* `wave`: Waveform index

* `inst`: Optional, wave is custom instrument

* `effect`: Optional, filter by effect command
