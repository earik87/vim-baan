# Archived project. No maintenance.
This project is not maintained anymore. You may fork and make your own changes, freely.

# Vim-baan
 
Baan development plugin for Vim. It is activated with the files having the extension `.bc` or `.cln`.

## Features
- Syntax highlighting. 
- Indentation. 
- Smart marking.
- Solution number tracking. 

## Installation
Vim-baan requires at least Vim 8.0. (Neovim is not tested, yet).

Vim-baan follows the standard runtime path structure. 

To install with Vim 8 packages;

`git clone https://github.com/earik87/vim-baan ~/.vim/pack/plugins/start/vim-baan`

## Quick marking

Shortcuts for quick marking;
- Start new (".sn") - F1
- End new (".en") - F2
- New (".n") - F3
- Old (".o") - F4
- Start old (".so") - F5
- End old (".eo") - F6
- Mark as new - mn (works with multiple lines selected)
- Mark as old - mo (works with multiple lines selected)
- Comment Line - F11
- Uncomment Lines - F12
- Change marker - cm
- Comment block - cb
