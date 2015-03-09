---
layout: page
title: Quick Start
---

First, install OfflineIMAP. See `docs/INSTALL.rst` or read <http://docs.offlineimap.org/en/latest/INSTALL.html>
(hint: `sudo python setup.py install`).

Second, set up your configuration file and run it! The distribution includes offlineimap.conf.minimal (Debian users may find this at `/usr/share/doc/offlineimap/examples/offlineimap.conf.minimal`) that provides you with the bare minimum of setting up OfflineIMAP.  You can simply copy this file into your home directory and name it `.offlineimaprc`.  A command such as `cp offlineimap.conf.minimal ~/.offlineimaprc` will do it.  Or, if you prefer, you can just copy this text to `~/.offlineimaprc`:

    [general]
    accounts = Test

    [Account Test]
    localrepository = Local
    remoterepository = Remote

    [Repository Local]
    type = Maildir
    localfolders = ~/Test

    [Repository Remote]
    type = IMAP
    remotehost = examplehost
    remoteuser = jgoerzen


Now, edit the `~/.offlineimaprc` file with your favorite editor.  All you have to do is specify a directory for your folders to be in (on the `localfolders` line), the host name of your IMAP server (on the `remotehost` line), and your login name on the remote (on the `remoteuser` line).  That's it!

If you prefer to be compatible with the [XDG Base Directory spec](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), then substitute the above `~/.offlineimaprc` with `$XDG_CONFIG_HOME/offlineimap/config` and don't forget to set `XDG_CONFIG_HOME` properly if you want it to be different from the default `$HOME/.config` for any reason.

To run OfflineIMAP, you just have to say `offlineimap` ― it will fire up, ask you for a login password if necessary, synchronize your folders, and exit.  See?

You can just throw away the rest of the finely-crafted, perfectly-honed user manual!  Of course, if you want to see how you can make OfflineIMAP FIVE TIMES FASTER FOR JUST $19.95 (err, well, $0), you have to read on our full user documentation and peruse the sample offlineimap.conf (which includes all available options) for further tweaks!
