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
    Superclass for those `Attribute` objects that imply dimension
    constraints like width and height
 */
public class DimensionAttribute: Attribute {
    
    /**
        Establishes a relationship between the dimension attribute 
        applied to the `UIView` and the reference `UIView` passed as 
        parameter.
        
        It's also possible to link this relationship to a particular
        attribute of the `view` parameter by supplying `attribute`.
         
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing
        the relationship to
        - returns: The current `Attribute` instance
     */
    public func like(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UILayoutGuide` 
        passed as parameter.
     
        It's also possible to link this relationship to a particular
        attribute of the `layoutGuide` parameter by supplying `attribute`.
     
        - parameter layoutGuide: The reference `UILayoutGuide`
        - parameter attribute: The attribute of `layoutGuide` we are 
        establishing the relationship to
        - returns: The current `Attribute` instance
     */
    @available (iOS 9.0, *)
    public func like(layoutGuide: UILayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
    // MARK: Overriden methods
    
    /**
        Method overriden to indicate that `PositionAttributes` are
        owned by `createItem` and not `superview`
        - returns boolean if the resulting constraint is owned by
        the superview
     */
    override func ownedBySuperview() -> Bool {
        return false
    }
    
}

/**
    The width of the object’s alignment rectangle
 */
public class Width: DimensionAttribute { }

/**
    The height of the object’s alignment rectangle
 */
public class Height: DimensionAttribute { }

/**
    The size of the object’s rectangle
 */
public class Size: CompoundAttribute {
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = 0.0`,
        `multiplier = 1.0` and `relatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            Width(),
            Height()
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = value`,
        `multiplier = 1.0` and `relatedBy = .Equal`
        - parameter value: `constant` of the constraint
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ value: CGFloat) {
        super.init()
        self.attributes = [
            Width(value),
            Height(value)
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with the `constant`,
        `multiplier` and `relatedBy` defined by the `Constant` supplied
        - parameter constant: `Constant` struct aggregating `constant`, 
        `multiplier` and `relatedBy` properties
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ constant: Constant) {
        super.init()
        self.attributes = [
            Width(constant),
            Height(constant)
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = size.width`
        and `constant = size.height` respectively, `multiplier = 1.0` 
        and `relatedBy = .Equal`
        - parameter size: `CGSize` that sets the constants for the `Width`
        and `Height` *subattributes*
        - returns: the `CompoundAttribute` instance created
     */
    public init(_ size: CGSize) {
        super.init()
        self.attributes = [
            Width(CGFloat(size.width)),
            Height(CGFloat(size.height))
        ]
    }
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UIView` passed as
        parameter.
        - parameter view: The reference view
        - returns: The current `CompoundAttribute` instance
     */
    public func like(view: UIView) -> Self {
        self.referenceItem = view
        for attr in self.attributes {
            attr.referenceItem = view
        }
        return self
    }
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UILayoutGuide` 
        passed as parameter.
        - parameter layoutGuide: The reference `UILayoutGuide`
        - returns: The current `CompoundAttribute` instance
     */
    @available (iOS 9.0, *)
    public func like(layoutGuide: UILayoutGuide) -> Self {
        self.referenceItem = layoutGuide
        for attr in self.attributes {
            attr.referenceItem = layoutGuide
        }
        return self
    }
    
}
