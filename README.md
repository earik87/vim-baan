# vim-baan
 
Baan development plugin for Vim. It is activated with the files having the extension `.bc` or `.cln`.

Features; Syntax highlighting, indentation, quick marking.

## Installation

- You can use Vim's built-in package support.(Vim 8.0 onwards)

`git clone https://github.com/earik87/vim-baan ~/.vim/pack/plugins/start/vim-baan`

## Quick marking

Quick marking has auto-detection of last solution number in the script. It will prompt a message about its status in the start-up. 

Shortcuts for quick marking;
- New (".n") - F3
- Start new (".sn") - F4
- End new (".en") - F5
- Old (".o") - F6
- Start old (".so") - F7
- End old (".eo") - F8

If the marker does not have the right solution number, then you can set this variable manually.

`let b:project = "#1234567"`
