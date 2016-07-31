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
#else
import AppKit
#endif

/**
    `Nodes` group the `Attributes` classifying them depending
    on the other `Attributes` they can conflict with. Those
    subnodes are four and are defined by this enum
 */
private enum Subnode {
    
    case Left, Right, Center, Dimension
    
}

/**
    This class is in charge of handling those `Attributes` that
    conflict or that may conflict in the feature in a `Condition`
    change and `easy_reload` is triggered
 */
internal class Node {
    
    /// `Attribute` occupying the left `Subnode`
    private(set) var left: Attribute?
    
    /// `Attribute` occupying the right `Subnode`
    private(set) var right: Attribute?
    
    /// `Attribute` occupying the center `Subnode`
    private(set) var center: Attribute?
    
    /// `Attribute` occupying the dimension `Subnode`
    private(set) var dimension: Attribute?
    
    /// Array of inactive `Attributes` not occupying any `Subnode`
    private(set) var inactiveAttributes: [Attribute] = []
   
    /// `Attributes` occupying any `Subnode`
    internal var activeAttributes: [Attribute] {
        return [self.left, self.right, self.center, self.dimension].flatMap { $0 }
    }
    
    /**
        Adds an `Attribute` to the `Node`. If the `Condition` for 
        the `Attribute` is `false` then it's added to the array of
        inactive `Attributes`. If the `Condition` is `true` evaluates
        whether this `Attribute` is in conflict with any of the
        `Subnodes` and if so deactivates those `Subnodes`. As a 
        result, the active `Attribute` is added to its corresponding
        `Node` and its associated `NSLayoutConstraint` returned in 
        order to be activated by the `Item` owning the `Node`.
        - parameter attribute: `Attribute` to be added to the `Node`
        - returns: `NSLayoutConstraints` to be activated by the 
        `Item` owning the current `Node`
     */
    func add(attribute attribute: Attribute) -> [NSLayoutConstraint] {
        guard attribute.shouldInstall() else {
            self.inactiveAttributes.append(attribute)
            return []
        }
        
        // Checks whether the `Attribute` is conflicting with any of
        // the existing `Subnodes`. If so deactivates the conflicting
        // `Subnodes`
        let nodeAttribute = attribute.createAttribute.subnode
        switch nodeAttribute {
        case .Left:
            if self.left === attribute { return [] }
            self.deactivate(attributes: [self.left, self.center].flatMap { $0 })
            self.left = attribute
        case .Right:
            if self.right === attribute { return [] }
            self.deactivate(attributes: [self.right, self.center].flatMap { $0 })
            self.right = attribute
        case .Center:
            if self.center === attribute { return [] }
            self.deactivate(attributes: [self.center, self.left, self.right].flatMap { $0 })
            self.center = attribute
        case .Dimension:
            if self.dimension === attribute { return [] }
            if let previousDimension = self.dimension {
                self.deactivate(attributes: [previousDimension])
            }
            self.dimension = attribute
        }
        
        // Returns the associated `NSLayoutConstraint` to be activated
        // by the `Item` owning the `Node`
        if let layoutConstraint = attribute.layoutConstraint {
            return [layoutConstraint]
        }
        
        return []
    }
    
    /**
        Deactivates the `NSLayoutConstraints` for the `Attributes`
        given. Also nullifies the `Subnodes` for those `Attributes`
        - parameter attributes: `Attributes` to be deactivated
     */
    func deactivate(attributes attributes: [Attribute]) {
        guard attributes.count > 0 else {
            return
        }
        
        var layoutConstraints: [NSLayoutConstraint] = []
        
        for attribute in attributes {
            // Nullify properties refering deactivated attributes
            if self.left === attribute { self.left = nil }
            else if self.right === attribute { self.right = nil }
            else if self.center === attribute { self.center = nil }
            else if self.dimension === attribute { self.dimension = nil }
            
            // Append `Attribute` to the array of `NSLayoutConstraints`
            // to deactivate
            if let layoutConstraint = attribute.layoutConstraint {
                layoutConstraints.append(layoutConstraint)
            }
        }
        
        // Deactivate `NSLayoutContraints`
        NSLayoutConstraint.deactivateConstraints(layoutConstraints)
    }
    
    /**
        Re-evaluates every `Condition` closure within the active and
        inactive `Attributes`, in case an active `Attribute` has 
        become inactive deactivates it and the `NSLayoutConstraints` of
        those that have changed to active are passed to the `Item` owner
        of the `Node` to active them along with other `Nodes` active
        `NSLayoutConstraints`
        - returns the `NSLayoutConstraints` to be activated
     */
    func reload() -> [NSLayoutConstraint] {
        
        // Deactivate `Attributes` which condition changed to false
        let deactivatedAttributes = self.activeAttributes.filter { $0.shouldInstall() == false }
        self.deactivate(attributes: deactivatedAttributes)
        
        // Gather all the existing `Attributes` that need to be added
        // again to the `Node`
        var activeAttributes: [Attribute] = self.activeAttributes
        activeAttributes.appendContentsOf(self.inactiveAttributes)
        
        // Init `inactiveAttributes` with the `Attributes` which 
        // condition changed to false
        self.inactiveAttributes = deactivatedAttributes
    
        // Re-add `Attributes` to the `Node` in order to solve conflicts
        // and re-evaluate `Conditions`
        let layoutAttributes = activeAttributes.flatMap { self.add(attribute: $0) }
        
        return layoutAttributes
    }
    
    /**
        Deactives all the active `Attributes` within the node and
        clears all the persisted ones
     */
    func clear() {
        self.deactivate(attributes: self.activeAttributes)
        self.inactiveAttributes = []
    }
    
}

#if os(iOS) || os(tvOS)
    
/**
     Extends `ReferenceAttribute` to ease the work carried
     out by a `Node`
 */
private extension ReferenceAttribute {
    
    /// This computed variable defines which subnode
    /// every `Attribute` belongs to
    var subnode: Subnode {
        switch self {
        case .Left, .Leading, .LeftMargin, .LeadingMargin, .Top, .FirstBaseline, .TopMargin:
            return .Left
        case .Right, .Trailing, .RightMargin, .TrailingMargin, .Bottom, .LastBaseline, .BottomMargin:
            return .Right
        case .CenterX, .CenterY, .CenterXWithinMargins, .CenterYWithinMargins:
            return .Center
        case .Width, .Height:
            return .Dimension
        }
    }
    
}
    
#else
  
/**
     Extends `ReferenceAttribute` to ease the work carried
     out by a `Node`
 */
private extension ReferenceAttribute {
    
    /// This computed variable defines which subnode
    /// every `Attribute` belongs to
    var subnode: Subnode {
        switch self {
        case .Left, .Leading, .Top, .FirstBaseline:
            return .Left
        case .Right, .Trailing, .Bottom, .LastBaseline:
            return .Right
        case .CenterX, .CenterY:
            return .Center
        case .Width, .Height:
            return .Dimension
        }
    }
    
}

#endif
