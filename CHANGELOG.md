# Changelog

## v.1.4.2

* In previous versions `Priority.highPriority` matched with `UILayoutPriority.required`. This
version introduces a new `Priority.required` case without breaking backwards compatibility as
old priorities have been marked as deprecated in favour of `.low`, `.medium`, `.high` and
`.custom`. Also `.low` now has a `Float` value of `250.0` instead of `1.0`.

## v.1.4.1

* Fixed compilation error when `EASY_RELOAD` compiler flag is set.

## v.1.4

* Swift 3 support.

## v.1.3.1

* Fixed `podspec`.

## v.1.3

* Swift 2.3 compatibility.

## v.1.2.1

* Now you can apply `DimensionAttributes`, like `Width`, `Height` and `Size`,
to views not in the view hierarchy, i.e. when `superview == nil`.

## v.1.2

* Implemented `ContextualConditions`, a variant of the `Condition` closures
where a `Context` struct is passed as parameter to the closure providing some
extra information (size class and device) based on the `UITraitCollection`
of the `UIView` the `Attributes` are going to be applied to. Examples:

```swift
view <- [
	Size(250),
	Center(0)
].when { $0.isHorizontalRegular }
```

```swift
view <- [
  Top(0),
  Left(0),
  Right(0),
  Height(250)
].when { $0.isPad }
```

## v.1.1.1

* Grouped deactivation of `NSLayoutConstraints`. Before, the deactivation of `NSLayoutConstraints` was taking place upon finding
a conflict, whereas now a single `NSLayoutConstraint.deactivateConstraints(_:)` takes place per `<-`, `easy_reload` or  `easy_clear`
operation.

## v.1.1.0

* Now it's possible to combine `multipliers` with `Equal`, `GreaterThatOrEqual`
and `LessThanOrEqual` relations.

```swift
// i.e.
Width(>=20*0.5) // value = 20, multiplier = 0.5, relation = .GreaterThanOrEqual
Width(<=20*0.5) // value = 20, multiplier = 0.5, relation = .LessThanOrEqual
Width(==20*0.5) // value = 20, multiplier = 0.5, relation = .Equal
```

# v.1.0.0

* Improved performance, benchmarks show up to a 250% improvement applying `Attributes` with the apply operator `<-`, resolving
conflicts and using `easy_clear` and `easy_reload` methods.
* `NSLayoutConstraint` conflict resolution is more accurate and strict.
* Added support to `NSLayoutGuide`.

## v.0.3.0

* Supported tvOS and OS X.
* Added OS X sample project.

## v.0.2.5

* Added support to `UIViewController` top and bottom layout guides that conform
the `UILayoutSupport` protocol.

```swift
view <- [
	Size(100),
	CenterX(0),
	Top(0).to(controller.topLayoutGuide)
]
```

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
