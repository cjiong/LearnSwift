#3DTouchDemo

![](https://github.com/cjiong/LearnSwift/raw/master/Project 26 - 3DTouchDemo/3DTouchDemo.gif)

# Test 3DTouchDemo on Simulator

![SBShortcutMenuSimulator](https://github.com/DeskConnect/SBShortcutMenuSimulator)

## Requirements

- Xcode 7 GM or later, set as your default version of Xcode

## Build

``` sh
git clone https://github.com/DeskConnect/SBShortcutMenuSimulator.git
cd SBShortcutMenuSimulator
make
```
## Usage

First, start SpringBoard with SBShortcutMenuSimulator enabled (run this from the cloned directory):

``` sh
xcrun simctl spawn booted launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES=$PWD/SBShortcutMenuSimulator.dylib
xcrun simctl spawn booted launchctl stop com.apple.SpringBoard
```

Now, to show an app's quick action menu, send the app's bundle identifier over TCP to port 8000. For example, running this command will show the shortcut menu for Calendar:

``` sh
echo 'com.apple.mobilecal' | nc 127.0.0.1 8000
```
