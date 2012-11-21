PeekabooTabBarController
========================

An iOS UITabBarController that can be toggled in and out of view

![PeekabooTabBarController Example](http://i.imgur.com/jrNSV.gif)

How to Use
----------

PeekabooTabBarController uses ARC, and is compatible with all iOS mobile devices (iPhone, iPod, iPad, iPhone 5, iPad Mini) running iOS 5.0+ (it may well work on lower iOS versions, but I haven't tested this). It can be used in both portrait and landscape mode.

Import, or link the PeekabooTabBarController.h and .m files into your project, then simply set your UITabBarController's class to PeekabooTabBarController (I do this via Interface Builder):

![PeekabooTabBarController Example](http://i.imgur.com/61PDC.png)

Once that's done, you'll need to set your images (for the tabs) the tab bar image, and the on/off tab bar images in the PeekabooTabBarController.m at the top of the file (see demo). Here's a more detailed explanation of those:

### Image Setup
All images referenced below are (obviously) the non-retina filenames.

    #define kTabBarBg               @"tabBar.png"
This is the background image for the tab bar

    #define kTabBarOpenButton       @"tabBarBtnOpen.png"
This is the "Open" image for the tab bar

    #define kTabBarCloseButton      @"tabBarBtnClose.png"
This is the "Close" image for the tab bar

    #define kTabBarClosedBleed      5
The amount of the tab bar you want to still show when the tab bar is closed

    #define kAnimationBounceHeight  8
How far to "over bounce" when the tab bar opens.

    NSString *const TAB_BAR_BUTTON_IMAGES[] = {@"tabBarBtn1", @"tabBarBtn2", @"tabBarBtn3", @"tabBarBtn4", @"tabBarBtn5", @"tabBarBtn6"};
Array of the tab bar images. Here, we're just using the base name (anything before the "On" or "Off"). "On" images must be named as *filename***On.png** and off images named as *filename***Off.png**.

### To-Do

- Fix up for iPad
- Try to use the original UITabBarItem images / text instead of having to rely on custom images.

License
-------
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.