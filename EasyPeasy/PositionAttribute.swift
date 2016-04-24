// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/**
     Superclass for those `Attribute` objects that imply position
     constraints like left, right, top and bottom margins
 */
public class PositionAttribute: Attribute {
    
    /**
        This method overrides super's `createConstraintForView` to set 
        the `UIView` parameter to `superview` as `referenceItem` in case
        this is not specified by using the `to:view:attribute` method
        - parameter view: `UIView` in which the generated 
        `NSLayoutConstraint` will be added
     */
    override func createConstraintsForItem(item: Item) -> [NSLayoutConstraint] {
        if let superview = item.owningView where self.referenceItem == nil {
            self.to(superview)
        }
        return super.createConstraintsForItem(item)
    }
    
    /**
        Establishes a position relationship between the `UIView` the
        attribute is applied to and the `UIView` passed as parameter.
        
        It's also possible to link this relationship to a particular
        attribute of the `view` parameter by supplying `attribute`.
     
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing
        the relationship to
        - returns: The current `Attribute` instance
     */
    public func to(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    @available(iOS 9.0, *)
    public func to(layoutGuide: UILayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
}

/**
    The left side of the object’s alignment rectangle
 */
public class Left: PositionAttribute { }

/**
    The right side of the object’s alignment rectangle
 */
public class Right: PositionAttribute { }

/**
    The top of the object’s alignment rectangle
 */
public class Top: PositionAttribute { }

/**
    The bottom of the object’s alignment rectangle
 */
public class Bottom: PositionAttribute { }

/**
    The leading edge of the object’s alignment rectangle
 */
public class Leading: PositionAttribute { }

/**
    The trailing edge of the object’s alignment rectangle
 */
public class Trailing: PositionAttribute { }

/**
    The center along the x-axis of the object’s alignment rectangle
 */
public class CenterX: PositionAttribute { }

/**
    The center along the y-axis of the object’s alignment rectangle
 */
public class CenterY: PositionAttribute { }

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the topmost line of text
 */
public class FirstBaseline: PositionAttribute { }

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the bottommost line of text
 */
public class LastBaseline: PositionAttribute { }

/**
    The object’s left margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class LeftMargin: PositionAttribute { }

/**
    The object’s right margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class RightMargin: PositionAttribute { }

/**
    The object’s top margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class TopMargin: PositionAttribute { }

/**
    The object’s bottom margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class BottomMargin: PositionAttribute { }

/**
    The object’s leading margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class LeadingMargin: PositionAttribute { }

/**
    The object’s trailing margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
public class TrailingMargin: PositionAttribute { }

/**
    The center along the x-axis between the object’s left and right margin. 
    For UIView objects, the margins are defined by their layoutMargins property
 */
public class CenterXWithinMargins: PositionAttribute { }

/**
    The center along the y-axis between the object’s top and bottom margin. 
    For UIView objects, the margins are defined by their layoutMargins property
 */
public class CenterYWithinMargins: PositionAttribute { }

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
    public init(_ edgeInsets: UIEdgeInsets) {
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

/**
    The object’s margins. For UIView objects, the margins are defined
    by their layoutMargins property
 */
public class Margins: CompoundAttribute {
    
    /**
        Initializer that creates the sub `Attribute` objects
        shaping the `CompoundAttribute` object with `constant = 0.0`,
        `multiplier = 1.0` and `RelatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            TopMargin(),
            LeftMargin(),
            RightMargin(),
            BottomMargin()
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
            TopMargin(value),
            LeftMargin(value),
            RightMargin(value),
            BottomMargin(value)
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
            TopMargin(constant),
            LeftMargin(constant),
            RightMargin(constant),
            BottomMargin(constant)
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
    public init(_ edgeInsets: UIEdgeInsets) {
        super.init()
        self.attributes = [
            TopMargin(CGFloat(edgeInsets.top)),
            LeftMargin(CGFloat(edgeInsets.left)),
            RightMargin(CGFloat(edgeInsets.right)),
            BottomMargin(CGFloat(edgeInsets.bottom))
        ]
    }
    
}

/**
    The center along the x-axis between the object’s left and right margin.
    For UIView objects, the margins are defined by their layoutMargins property
 */
public class CenterWithinMargins: CompoundAttribute {
    
    /**
        Initializer that creates the sub `Attribute` objects
        shaping the `CompoundAttribute` object with `constant = 0.0`,
        `multiplier = 1.0` and `RelatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            CenterXWithinMargins(),
            CenterYWithinMargins()
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
            CenterXWithinMargins(value),
            CenterYWithinMargins(value)
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
            CenterXWithinMargins(constant),
            CenterYWithinMargins(constant)
        ]
    }
    
    /**
        Initializer that creates the sub `Attribute` objects shaping the
        `CompoundAttribute` object with the `constant` properties specified by
        the `CGPoint` parameter, `multiplier = 1.0` and `RelatedBy = .Equal`
        - parameter point: `CGPoint` that gives value to the `constant`
        properties of each one of the sub `Attribute` objects
        - returns: the `CompoundAttribute` instance created
     */
    public init(_ point: CGPoint) {
        super.init()
        self.attributes = [
            CenterXWithinMargins(CGFloat(point.x)),
            CenterYWithinMargins(CGFloat(point.y))
        ]
    }
    
}
