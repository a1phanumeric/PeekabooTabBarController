PeekabooTabBarController
========================

An iOS UITabBarController that can be toggled in and out of view

![PeekabooTabBarController Example](http://i.imgur.com/jrNSV.gif)

How to Use
----------

PeekabooTabBarController uses ARC, and is compatible with all iOS mobile devices (iPhone, iPod, iPad, iPhone 5, iPad Mini) running iOS 5.0+ (it may well work on lower iOS versions, but I haven't tested this). It can be used in both portrait and landscape mode.

Import, or link the PeekabooTabBarController.h and .m files into your project, then simply set your UITabBarController's class to PeekabooTabBarController. Once that's done, you'll need to set your images (for the tabs) the tab bar image, and the on/off tab bar images in the PeekabooTabBarController.m at the top of the file (see demo).

### To-Do

- Fix up for iPad
- Try to use the original UITabBarItem images / text instead of having to rely on custom images.

License
-------
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.