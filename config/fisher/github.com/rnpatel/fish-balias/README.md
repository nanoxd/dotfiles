# fish-balias
A simple port of [oh-my-fish/plugin-balias](https://github.com/oh-my-fish/plugin-balias) to fisher


#### Better Alias
> Aliases with completions for [fisher][fisher-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](http://fishshell.com)

<br/>

`balias` works like `alias`, but you get command completion as if you'd used the unaliased command.

## Install

```fish
$ fisher add rnpatel/fish-balias
```

## Usage

```fish
$ balias apti 'sudo apt-get install'
$ balias gc   'git checkout'
```

# License

[MIT][mit] © [Rajiv Patel][author]

Original Author [Bruno Ferreira Pinto][original-author]

[mit]:            http://opensource.org/licenses/MIT
[fisher-link]:    https://github.com/jorgebucaran/fisher
[author]:         http://github.com/rnpatel
[original-author]: http://github.com/bpinto

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
