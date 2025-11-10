# Modify SFX Volume Utility Cart

Modify SFX volume

## Usage

### Command

```shell
pico8 -root_path root_path -p "param_str" [-x | -run] /path/to/this/cart

# example:
pico8 -root_path /carts -p "/carts/foo.p8,/carts/bar.p8,-1,0-7" [-x | -run] /path/to/this/cart
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
src,[dest],delta,[excluded,...]
```

* `src`: Path to source cart. *Must be below and relative to -root_path*.

* `dest`: Path to destination cart. *Must be below and relative to -root_path*. Defaults to `src`.

* `delta`: Amount to add or subtract from note volume

* `excluded,...` - Optional sfx indexes to exclude
