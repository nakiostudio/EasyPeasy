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

/**
     PositionAttribute extension adding some convenience methods to operate with
     UIKit elements as `UIViews` or `UILayoutGuides`
 */
public extension PositionAttribute {
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UIView` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @discardableResult public func to(_ view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UILayoutSupport` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `layoutSupport` parameter by supplying `attribute`.
     
        - parameter layoutSupport: The reference `UILayoutSupport`
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @discardableResult public func to(_ layoutSupport: UILayoutSupport, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutSupport
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UILayoutGuide` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter layoutGuide: The reference `UILayoutGuide`
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @available(iOS 9.0, *)
    @discardableResult public func to(_ layoutGuide: UILayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
}
    
/**
     The object’s left margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class LeftMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .leftMargin
    }
    
}

/**
     The object’s right margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class RightMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .rightMargin
    }
    
}

/**
     The object’s top margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class TopMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .topMargin
    }
    
}

/**
     The object’s bottom margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class BottomMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .bottomMargin
    }
    
}

/**
     The object’s leading margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class LeadingMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .leadingMargin
    }
    
}

/**
     The object’s trailing margin. For UIView objects, the margins are defined
     by their layoutMargins property
 */
public class TrailingMargin: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .trailingMargin
    }
    
}

/**
     The center along the x-axis between the object’s left and right margin.
     For UIView objects, the margins are defined by their layoutMargins property
 */
public class CenterXWithinMargins: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .centerXWithinMargins
    }
    
}

/**
     The center along the y-axis between the object’s top and bottom margin.
     For UIView objects, the margins are defined by their layoutMargins property
 */
public class CenterYWithinMargins: PositionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .centerYWithinMargins
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
    public init(_ edgeInsets: Insets) {
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
    
#endif
