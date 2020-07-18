# dotDoomDir

This is where I'm keeping my Doom Emacs configuration files. I've finally given up on maintaining my own config, and figure I might as well save some time and use a framework. High level changes to Doom features will be changed in `init.el`, any additional packages added in will be in `packages.el`, and lastly any custom configurations like keybindings will be found in `config.el`

For the initial setup, you'll need to clone this repository to the `~/.doom.d` directory, install emacs, and download the doom framework (In no particular order). To get the doom framework just run:

``` sh
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

remember to run `~/.emacs.d/bin/doom sync` after changing these files and restart emacs for changes to take place. I don't promise that these configurations will change your life, but my objective was to be able to get my editor up and running on any machine with two or three commands and this fits the bill.
