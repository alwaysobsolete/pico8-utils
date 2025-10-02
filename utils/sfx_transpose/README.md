# SFX Transpose Utility Cart

Transpose SFX

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
sfxstart[-sfxend],semitones,src,[dest]
```

* `sfxstart`: SFX index to modify, follow with hypen and `sfxend` to specify range.

* `semitones`: Semitones to transpose by.

* `src`: Path to source cart. *Must be below -root_path*.

* `dest`: Path to destination cart. *Must be below -root_path*. Defaults to `src`.
