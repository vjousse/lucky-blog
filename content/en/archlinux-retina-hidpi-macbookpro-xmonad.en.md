<!-- 
.. title: Using Archlinux on a Retina (HiDPI) MacBook Pro with Xmonad
.. slug: archlinux-retina-hidpi-macbookpro-xmonad
.. date: 2014-12-08 20:39:20+02:00
.. tags: archlinux, macbook
.. category: 
.. link: 
.. description: 
.. type: text
-->

I've recently installed Archlinux on the latest 15" MacBook Pro Retina (late 2013). This model seems to be known under the name "MacbookPro 11,2" (ME293xx/A) on the [Apple website](http://support.apple.com/kb/ht4132). Here is the exact configuration: 15.4"/2.0 Quad-core i7/8GB/256-Flash. The installation was a little bit painful (especially the EFI part), but somehow I found out how to have a bootable Archlinux.<!-- TEASER_END -->The hardest part (understand, the less documented one) was how to have a Desktop with a "normal" font size. Indeed, by default, the resolution of the screen is 2880x1800, thus you need very good eyes to be able to see something.



## Installation

As I said, the installation was a bit painful. I followed the [Archlinux Wiki instructions](https://wiki.archlinux.org/index.php/MacBookPro11,x). I've used the [Archboot image](https://wiki.archlinux.org/index.php/Archboot), [rEFInd](http://www.rodsbooks.com/refind/) and Grub2.

To be able to access the installer without having glitches on your screen you need to boot it adding the `nomodeset` option to the kernel. To be able to do that you need the Grub menu of the installer to show up and modify the boot options. Unfortunately, when booting directly on my USB key using the Option (alt) button at startup, the Grub menu didn't show up, just a nice black screen.

In order to have the Grub menu showing up, I needed to install rEFInd under Mac OS X first, then to not press the Option (alt) button but let it boot under rEFInd. Then I choosed the "Boot Legacy OS From HD" option, the last one, with a grey icon. And, for whatever reason, it did the trick and I was able to boot under the grub menu and add `nomodeset` to the boot options.

Then, regarding Internet access, I was using the "Thunderbolt to gigabit ethernet adapter" from Apple http://store.apple.com/us/product/MD463ZM/A/thunderbolt-to-gigabit-ethernet-adapter?fnode=51. Hot plugin the adapter is not supported, so you need to boot with the adapter plugged in. Later I installed the `broadcom-wl` package from AUR to have the Wireless card working. It worked out of the box (I'm using `Wicd` to manage my network).

The current kernel is the 3.12 one and it doesn't support the Intel Iris Pro 5200 Graphic card. So for now, in order to have Xorg working, you will need to use the framebuffer (`fbdev`) driver. To do so I created a `/etc/X11/xorg.conf.d/1-monitor.conf` file with this content:

```
Section "Monitor"
        Identifier      "Monitor0"
EndSection

Section "Device"
        Identifier      "Device0"
        Driver          "fbdev"
EndSection

Section "Screen"
        Identifier      "Screen0"
        Device          "Device0"
        Monitor         "Monitor0"
EndSection
```

With the 3.12 kernel, speakers will not be working. If you want to have the speakers working, you will need to install the `linux-mainline` package from AUR or wait for the 3.13 kernel to be released. Don't forget to update the entries in your Grub or to override (symlink) your `/boot/initramfs-linux-fallback.img  /boot/initramfs-linux.img  /boot/vmlinuz-linux` files with the `linux-mainline` ones.

That's it for the installation part. You should now have a working Archlinux install but the fonts should be very small, almost unreadable.


## Fonts and screen resolution/DPI problems

When you search on the web for how to manage retina screens under Linux it seems that the only answer is to use KDE/Qt. As a big fan of Xmonad, this answer didn't satisfied me. So, after some research, here are the things you have to manage to have a good looking Xmonad using a retina screen:

- X font DPI
- Gtk 2.0 and Gtk 3.0 themes / font size
- Terminal's font (I'm using Urxvt)
- Firefox and Thunderbird display size

So here we go in detail.

### Setting the X font DPI

This part is done using a file called `.Xresources` located in your home. If it doesn't exist, just create it and add the following code:

```
! Fonts {{{
Xft.antialias: true
Xft.hinting:   true
Xft.rgba:      rgb
Xft.hintstyle: hintfull
Xft.dpi:       220
! }}}
```

### Managing Gtk themes

Gtk2 themes are managed using the file `~/.gtkrc-2.0`. Gtk3 themes are managed using `~/.config/gtk-3.0/settings.ini`. I recommand to install the package `lxappearance` to manage the gtk themes. It will create the required files. Personnaly I've installed the `zukitwo-themes` and `faenza-icon-theme` packages. In _lxappearance_ I'm using `Adwaita` for the widgets, `Faenza-Radiance` for the icons and `Adwaita` for the mouse cursor.

Once I did that, the font was still too big in Gtk apps like Firefox and Thunderbird. So I had to override the default font size set by _lxappearance_. To do so I created a file `~/.gtkrc-2.0.mine` with only the font part to override:

```
gtk-font-name="Cantarell 8"
```

For Gtk3 themes, I had to overwrite the file generated by _lxappearance_. So here are my 3 files:

`~/.gtkrc-2.0`

```
# DO NOT EDIT! This file will be overwritten by LXAppearance.
# Any customization should be done in ~/.gtkrc-2.0.mine instead.

gtk-theme-name="Adwaita"
gtk-icon-theme-name="Faenza-Radiance"
gtk-font-name="Cantarell 18"
gtk-cursor-theme-name="Adwaita"
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
gtk-xft-rgba="rgb"
include "/home/vjousse/.gtkrc-2.0.mine"
```

`~/.gtkrc-2.0.mine`

```
gtk-font-name="Cantarell 8"
```

`~/.config/gtk-3.0/settings.ini`

```
[Settings]
gtk-theme-name=Adwaita
gtk-icon-theme-name=Faenza-Radiance
gtk-font-name=Cantarell 8
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
```

### Terminal's font

As I'm using `rxvt-unicode` (if you don't, you should really), I just have to modify the font size in my `.Xresources` file like that:

```
urxvt.font:  xft:DejaVuSansMono:size=8
```

Nothing fancy here.

### Firefox and Thunderbird display size

Here is the final touch. Thanks to the modifications above, the menus are displayed correctly, but the pages are really small, almost unreadable in Firefox and Thunderbird. To have readable pages, you need to change a config value named `layout.css.devPixelsPerPx` and set it to `2`. 

To do so in __Firefox__ type `about:config` in the menu bar and search for the key named `layout.css.devPixelsPerPx`. By default the value is __-1.0__, set it to __2__. 

In __Thunderbird__, go to `Preferences` > `Advanced` and in `Advanced Configuration` click on the `Config Editor` button. The the `layout.css.devPixelsPerPx` value to __2__.

From time time I'm using Opera too. For Opera I've just changed the default Zoom value and it did the trick.

One last thing, sometimes, Firefox is using ugly fonts to display web pages. To avoid that, you just have to disable bitmap fonts in X as mentionned on [the Arch wiki page](https://wiki.archlinux.org/index.php/firefox#Firefox_uses_ugly_fonts_on_certain_web_pages):

```
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
```


## Conclusion

Using a Retina screen on a daily basis with Archlinux is awesome. Font rendering is incredible and it's hard to go back to a non-retina screen. With the above tips, you should be able to have an almostfully working environment. You can find [all my configuration files on Github](https://github.com/vjousse/dotfiles). Some apps are still not displaying very well (Skype for example) but it's not really a problem, it's still totally usable. If I find a way to fix it, I'll let you know here. __Enjoy__!
