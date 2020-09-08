# docserve

This is a simple hook to keep track of html documentation under `/usr/share` on Arch Linux.

The script creates an index.html page with links to `/usr/share/**/*.html` pages for easy access. It adapts to dark colors (if your browser `prefers-color-scheme: dark`). Your current selection in the list is saved. Navigate with `hjkl` or arrow keys.

![Screenshot](https://raw.githubusercontent.com/sharethewisdom/docserve/master/docserve.gif)

## Installation

```
pacman -Syu git
cd /tmp
wget 'https://raw.githubusercontent.com/sharethewisdom/docserve/master/PKGBUILD'
makepkg -i
```

## Usage

Configure [nginx](nginx/docserve.conf) and then run `systemctl enable --now docserve.service` (the unit will fail if the file `/etc/nginx/docserve.conf` doesn't exist).
