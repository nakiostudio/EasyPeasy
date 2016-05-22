# Changelog

## v.0.2.4

* `Priorities` and `Conditions` now can be easily applied to an `Array` of `Attributes`.

```swift
view <- [
	Width(200),
	Height(240)
].when { Device() == .iPad }

view <- [
	Width(120),
	Height(140)
].when { Device() == .iPhone }
```

## v.0.2.3

* Added `UILayoutGuide` support (iOS 9 and above).

## v.0.2.2

* Fixed bug clearing conflicting `Attributes` using `easy_reload`.
* Apply operator `<-` returns the `NSLayoutConstraints` created.

## v.0.2.1

* `Constant` values of `CGFloat` type.
* Optimized apply `<-` operation.

## v.0.2

* Replaced `addConstraint` and `removeConstraint` methods with `activateConstraints`
and `deactivateConstraints`.
* Extended `UIView` with `easy_clear()`, a method to clear the constraints applied
to the `UIView` using **EasyPeasy**.
* Improved **README** file.
