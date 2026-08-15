PlayAural - Serrebi Radio Palace edition
========================================

This is the official PlayAural Windows app, packaged so that it connects to
the Serrebi Radio Palace server instead of the project's default server.

How to start
------------

1. Unzip this folder somewhere you can find again, such as your Desktop.
2. Run "Play on Serrebi Radio Palace.bat".
3. Choose Register to create an account, or Login if you already have one.

That first run stores the server address for you. After that you can start
PlayAural.exe directly if you prefer, and it will still connect to Serrebi
Radio Palace. The setting is kept in your user profile, so it also survives
the app's own automatic updates.

Server details
--------------

  Name:    Serrebi Radio Palace
  Address: wss://palace.serrebiradio.com
  Port:    443

Playing without installing
--------------------------

You can also play in any modern browser, with nothing to download, at:

  https://webgame.serrebiradio.com

Other platforms
---------------

Android: an APK is published by the PlayAural project. Note that it connects
to the project's default server rather than to Serrebi Radio Palace.

macOS and Linux: no desktop build is published. Please use the web version
above.

What "Play on Serrebi Radio Palace.bat" does
--------------------------------------------

It writes the server address into PlayAural's own settings file at:

  %APPDATA%\ddt.one\PlayAural\identities.json

then starts PlayAural.exe. If you already had that file, only the server
address is changed and your saved accounts are left alone. Nothing is
installed, and nothing outside your own user profile is modified.

Credits
-------

PlayAural is created by the PlayAural project:

  https://github.com/Daoductrung/PlayAural

It is released under the GNU General Public License. This package contains
the unmodified official Windows build plus the two small helper files
described above.
