# Note Subtractor Utility Cart

Subtract notes contained in subtrahend carts from source cart

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
src,dest,sub,[...]
```

* `src`: Path to src cart, must be below and relative to -root_path\

* `dest`: Path to dest cart, must be below and relative to -root_path\

* `sub`: Path to subtrahend cart(s), must be below and relative to -root_path\
