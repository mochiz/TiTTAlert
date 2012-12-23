TiTTAlert module
===========================================
Titanium Mobile iOS Module project for [TTAlertView](https://github.com/twotoasters/TTAlertView)

![screenshot 2012-12-24 at 2 17 45](https://f.cloud.github.com/assets/217503/29094/030089e4-4d26-11e2-9722-4c18115d146c.png)

INSTALL MODULE
--------------------
1. Run `build.py` which creates your distribution
2. cd to `/Library/Application Support/Titanium`
3. copy this zip file into the folder of your Titanium SDK

REGISTER MODULE
---------------------
Register your module with your application by editing `tiapp.xml` and adding your module.
Example:

```
<modules>
	<module platform="iphone" version="0.1">com.qnyp.tittalert</module>
</modules>
```

USING MODULE IN CODE
-------------------------
For example

```
var win = Ti.UI.createWindow();
var tittalert = require('com.qnyp.tittlert');
var alert = tittalert.createView();
win.add(alert);

alert.show();
```

USAGE
-------------------------

あとで書く

show
```
あとで書く
```

ABOUT EXAMPLE APP
-------------------------
Example app is in `example` directory.

LICENSE
-------------------------
MIT License
