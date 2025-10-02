# Modify SFX Volume Utility Cart

Modify SFX volume

## Usage

### Command

```shell
pico8 -root_path root_path -p "param_str" [-x | -run] /path/to/this/cart

# example:
pico8 -root_path /carts -p "8-15,-1,/carts/foo.p8,/carts/bar.p8" [-x | -run] /path/to/this/cart
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
sfxstart[-sfxend],delta,src,[dest]
```

* `sfxstart`: SFX index to modify, follow with hypen and `sfxend` to specify range.

* `delta`: Amount to add or subtract from note volume

* `src`: Path to source cart. *Must be below -root_path*.

* `dest`: Path to destination cart. *Must be below -root_path*. Defaults to `src`.
