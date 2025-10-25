# Remove Unused Custom Instruments Utility Cart

Remove custom instruments not used in specified sfx range.

## Usage

### Command

```shell
pico8 -root_path root_path -p "param_str" [-x | -run] /path/to/this/cart

# example:
pico8 -root_path /carts -p "8-15,/carts/foo.p8,/carts/bar.p8" [-x | -run] /path/to/this/cart
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
src,[dest],[excluded,...]
```

* `src`: Path to source cart. *Must be below -root_path*.

* `dest`: Optional path to destination cart. *Must be below -root_path*. Defaults to `src`.

* `excluded,...` - Optional instrument indexes to exclude
