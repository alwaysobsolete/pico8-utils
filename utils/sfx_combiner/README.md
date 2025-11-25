# SFX Combiner Utility Cart

Combine notes contained in addend carts

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
dest,add,[...]
```

* `dest`: Path to dest cart, must be below and relative to -root_path\

* `add`: Path to addend cart(s), must be below and relative to -root_path\
