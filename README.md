# givenv

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This very simple project lets you import simple
[Nix development shells](https://nixos.wiki/wiki/Development_environment_with_nix-shell)
to your current directory through the `givenv` command. You can
then use these shells to develop your projects and manage your
dependencies [the Nix way](https://github.com/the-nix-way)!

These devshells are made for myself, so you should modify each
template to your own needs after running `givenv`.

## Requirements

- [Nix](https://nixos.org/) with
  [flakes](https://wiki.nixos.org/wiki/Flakes#Setup) enabled
- (optional)
  [direnv](https://github.com/nix-community/nix-direnv)

## Usage

To copy a template to your current working directory, run

```sh
nix run github:vicgeentor/givenv -- <template>
```

or (if you install givenv on your system; see
[Installation](#installation))

```sh
givenv <template>
```

where `<template>` is one of the directory names inside the
[templates directory](./templates).

This will copy all the template files (`flake.nix`,
`flake.lock`, `.envrc`, `.gitignore`, etc.) to your current
directory. You can then run

```bash
direnv allow
```

or

```bash
nix develop
```

to activate the development environment, depending on if you
have [direnv](https://github.com/nix-community/nix-direnv)
installed or not.

## Installation

Add this project's flake to your NixOS or home-manager flake
inputs:

```nix
...

inputs = {
  ... 

  givenv = {
    url = "github:vicgeentor/givenv";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  ...
};

...
```

And then add it either `environment.systemPackages` or
`home.packages` as

```nix
inputs.givenv.packages.${pkgs.stdenv.hostPlatform.system}.default
```

Then rebuild your NixOS or home-manager system.

> [!TIP]
> If you are unfamiliar with these practices, check out
> [this amazing source](https://nixos-and-flakes.thiscute.world/)
> to learn how Nix flakes work and how they make your
> development life easier.

## Acknowledgement

This project is heavily inspired by
[the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates).

## License

givenv is licensed under the MIT license. see
[LICENSE](./LICENSE) for more information.
