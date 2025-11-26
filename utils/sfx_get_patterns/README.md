# Get SFX Patterns Utility Cart

Get list of patterns using sfx id

## Usage

### Command

```shell
pico8 -root_path root_path -p "param_str" [-x | -run] /path/to/this/cart

# example:
pico8 -root_path /carts -p "/carts/foo.p8,8" [-x | -run] /path/to/this/cart
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
src,sfx_idx
```

* `src`: Path to source cart. *Must be below and relative to -root_path*.

* `sfx_idx`: sfx index
