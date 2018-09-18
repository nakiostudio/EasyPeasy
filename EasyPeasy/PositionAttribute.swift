// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) || os(tvOS)

import UIKit

/// Alias of UIEdgeInsets
public typealias Insets = UIEdgeInsets

#else

import AppKit

#if swift(>=4.0)
public typealias Insets = NSEdgeInsets
#else
public typealias Insets = EdgeInsets
#endif
    
#endif

/**
     Superclass for those `Attribute` objects that imply position
     constraints like left, right, top and bottom margins
 */
open class PositionAttribute: Attribute {
    
    /**
        This method overrides super's `createConstraintForView` to set 
        the `UIView` parameter to `superview` as `referenceItem` in case
        this is not specified by using the `to:view:attribute` method
        - parameter view: `UIView` in which the generated 
          `NSLayoutConstraint` will be added
     */
    @discardableResult override func createConstraints(for item: Item) -> [NSLayoutConstraint] {
        if let superview = item.owningView, self.referenceItem == nil {
            self.to(superview)
        }
        return super.createConstraints(for: item)
    }
    
}

/**
    The left side of the object’s alignment rectangle
 */
public class Left: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .left
    }
    
}

/**
    The right side of the object’s alignment rectangle
 */
public class Right: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .right
    }
    
}

/**
    The top of the object’s alignment rectangle
 */
public class Top: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .top
    }
    
}

/**
    The bottom of the object’s alignment rectangle
 */
public class Bottom: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .bottom
    }
    
}

/**
    The leading edge of the object’s alignment rectangle
 */
open class Leading: PositionAttribute {

    /// `Attribute` applied to the view
    open override var createAttribute: ReferenceAttribute {
        return .leading
    }
    
}

/**
    The trailing edge of the object’s alignment rectangle
 */
public class Trailing: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .trailing
    }

}

/**
    The center along the x-axis of the object’s alignment rectangle
 */
public class CenterX: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .centerX
    }
    
}

/**
    The center along the y-axis of the object’s alignment rectangle
 */
public class CenterY: PositionAttribute {
 
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .centerY
    }

}

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the topmost line of text
 */
public class FirstBaseline: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .firstBaseline
    }
    
}

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the bottommost line of text
 */
public class LastBaseline: PositionAttribute {

    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .lastBaseline
    }

}

/**
    The size of the object’s rectangle
 */
public class Edges: CompoundAttribute {
    
    /**
        Initializer that creates the sub `Attribute` objects
        shaping the `CompoundAttribute` object with `constant = 0.0`,
        `multiplier = 1.0` and `RelatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            Top(),
            Left(),
            Right(),
            Bottom()
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with `constant = value`, `multiplier = 1.0`
        and `RelatedBy = .Equal`
        - parameter value: `constant` of the constraint
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ value: CGFloat) {
        super.init()
        self.attributes = [
            Top(value),
            Left(value),
            Right(value),
            Bottom(value)
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with `constant`, `multiplier` and 
        `RelatedBy` properties defined by the `Constant` supplied
        - parameter constant: `Constant` struct aggregating
        `constant`, `multiplier` and `relatedBy` properties
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ constant: Constant) {
        super.init()
        self.attributes = [
            Top(constant),
            Left(constant),
            Right(constant),
            Bottom(constant)
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with the `constant` properties specified by 
        the `UIEdgeInsets` parameter, `multiplier = 1.0` and `RelatedBy = .Equal`
        - parameter edgeInsets: `UIEdgeInsets` that gives value to the `constant`
        properties of each one of the sub `Attribute` objects
        - returns: the `CompoundAttribute` instance created
     */
    public init(_ edgeInsets: Insets) {
        super.init()
        self.attributes = [
            Top(CGFloat(edgeInsets.top)),
            Left(CGFloat(edgeInsets.left)),
            Right(CGFloat(edgeInsets.right)),
            Bottom(CGFloat(edgeInsets.bottom))
        ]
    }
    
}

/**
    The center along the x and y axis of the object’s alignment rectangle
 */
public class Center: CompoundAttribute {
    
    /**
        Initializer that creates the sub `Attribute` objects
        shaping the `CompoundAttribute` object with `constant = 0.0`,
        `multiplier = 1.0` and `RelatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            CenterX(),
            CenterY()
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with `constant = value`, `multiplier = 1.0`
        and `RelatedBy = .Equal`
        - parameter value: `constant` of the constraint
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ value: CGFloat) {
        super.init()
        self.attributes = [
            CenterX(value),
            CenterY(value)
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with `constant`, `multiplier` and
        `RelatedBy` properties defined by the `Constant` supplied
        - parameter constant: `Constant` struct aggregating
        `constant`, `multiplier` and `relatedBy` properties
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ constant: Constant) {
        super.init()
        self.attributes = [
            CenterX(constant),
            CenterY(constant)
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with the `constant` properties specified by
        the `CGPoint` parameter, `multiplier = 1.0` and `RelatedBy = .Equal`
        - parameter point: `CGPoint` that gives value to the `constant` properties 
        of each one of the sub `Attribute` objects
        - returns: the `CompoundAttribute` instance created
     */
    public init(_ point: CGPoint) {
        super.init()
        self.attributes = [
            CenterX(CGFloat(point.x)),
            CenterY(CGFloat(point.y))
        ]
    }
    
}
