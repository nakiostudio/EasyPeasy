![logo](assets_readme/logo.png)

[![CI Status](http://img.shields.io/travis/Carlos Vidal/EasyPeasy.svg?style=flat)](https://travis-ci.org/Carlos Vidal/EasyPeasy)
[![Version](https://img.shields.io/cocoapods/v/EasyPeasy.svg?style=flat)](http://cocoapods.org/pods/EasyPeasy)
[![License](https://img.shields.io/cocoapods/l/EasyPeasy.svg?style=flat)](http://cocoapods.org/pods/EasyPeasy)
[![Platform](https://img.shields.io/cocoapods/p/EasyPeasy.svg?style=flat)](http://cocoapods.org/pods/EasyPeasy)

**EasyPeasy** is a Swift framework that lets you create *Autolayout* constraints
programmatically without headaches and never ending boilerplate code. Besides the
basics, **EasyPeasy** resolves most of the constraint conflicts for you and lets
you attach to a constraint conditional closures that are evaluated before applying
a constraint, this lets you apply (or not) a constraint depending on platform, size
classes, orientation... or the state of your controller, easy peasy!

In this quick tour through **EasyPeasy** we assume that you already know the
advantages and disadvantages of the different *Autolayout* APIs and therefore you
won't see here a comparison of the code side by side, just read and decide
whether **EasyPeasy** is for you or not.

### A touch of EasyPeasy
The example below is quite simple but shows how effortless its implementation
result using **EasyPeasy**.
![touch](assets_readme/first_touch.png)

## Installation

### Cocoapods

EasyPeasy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EasyPeasy"
```

### Compatibility

For now **EasyPeasy** is only compatible with iOS 7 and above, although we aim
to make it compatible with OS X.
The framework has been tested with Xcode 7 and Swift 2.0, however don't hesitate
to report any issues you may find with different versions.

## Usage

This section is W.I.P...

## Author

Carlos Vidal - @carlostify

## License

EasyPeasy is available under the MIT license. See the LICENSE file for more info.
