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
    
    case left, right, center, dimension
    
}

/**
    This class is in charge of handling those `Attributes` that
    conflict or that may conflict in the feature in a `Condition`
    change and `easy.reload` is triggered
 */
class Node {
    
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
    var activeAttributes: [Attribute] {
        return [self.left, self.right, self.center, self.dimension].easy_flatMap { $0 }
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
        - returns an `ActivationGroup` gathering `NSLayoutConstraints` 
        to be activated/deactivated by the `Item` owning the current 
        `Node`
     */
    func add(attribute: Attribute) -> ActivationGroup? {
        guard attribute.shouldInstall() else {
            self.inactiveAttributes.append(attribute)
            return nil
        }
        
        var deactivate: [NSLayoutConstraint]?
        
        // Checks whether the `Attribute` is conflicting with any of
        // the existing `Subnodes`. If so deactivates the conflicting
        // `Subnodes`
        let nodeAttribute = attribute.createAttribute.subnode
        switch nodeAttribute {
        case .left:
            if self.left === attribute { return nil }
            deactivate = self.deactivate(attributes: [self.left, self.center].easy_flatMap { $0 })
            self.left = attribute
        case .right:
            if self.right === attribute { return nil }
            deactivate = self.deactivate(attributes: [self.right, self.center].easy_flatMap { $0 })
            self.right = attribute
        case .center:
            if self.center === attribute { return nil }
            deactivate = self.deactivate(attributes: [self.center, self.left, self.right].easy_flatMap { $0 })
            self.center = attribute
        case .dimension:
            if self.dimension === attribute { return nil }
            if let previousDimension = self.dimension {
                deactivate = self.deactivate(attributes: [previousDimension])
            }
            self.dimension = attribute
        }
        
        // Returns the associated `NSLayoutConstraint` to be activated
        // by the `Item` owning the `Node`
        if let layoutConstraint = attribute.layoutConstraint {
            return ([layoutConstraint], deactivate ?? [])
        }
        
        // Return constraints to deactivate
        if let deactivateConstraints = deactivate {
            return ([], deactivateConstraints)
        }
        
        return nil
    }
    
    /**
        Returns the `NSLayoutConstraints` to deactivate for the `Attributes`
        given. Also nullifies the `Subnodes` holding those `Attributes`
        - parameter attributes: `Attributes` to be deactivated
        - returns an array of `NSLayoutConstraints` to be deactivated
     */
    func deactivate(attributes: [Attribute]) -> [NSLayoutConstraint] {
        guard attributes.count > 0 else {
            return []
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
        
        // Return `NSLayoutContraints` to deactivate
        return layoutConstraints
    }
    
    /**
        Re-evaluates every `Condition` closure within the active and inactive
        `Attributes`, in case an active `Attribute` has become inactive 
        returns its associated `NSLayoutConstraints` along with those that
        have changed to active in order to be activated or deactivated by the
        `Item` owning the `Node`
        - returns an `ActivationGroup` gathering the `NSLayoutConstraints` 
        to be activated and deactivated
     */
    func reload() -> ActivationGroup {
        var activateConstraints: [NSLayoutConstraint] = []
        var deactivateConstraints: [NSLayoutConstraint] = []
        
        // Get the `Attributes` its condition changed to false in order to
        // deactivate the associated `NSLayoutConstraint`
        let deactivatedAttributes = self.activeAttributes.filter { $0.shouldInstall() == false }
        deactivateConstraints.append(contentsOf: self.deactivate(attributes: deactivatedAttributes))
        
        // Gather all the existing `Attributes` that need to be added
        // again to the `Node`
        var activeAttributes: [Attribute] = self.activeAttributes
        activeAttributes.append(contentsOf: self.inactiveAttributes)
        
        // Init `inactiveAttributes` with the `Attributes` which 
        // condition changed to false
        self.inactiveAttributes = deactivatedAttributes
    
        // Re-add `Attributes` to the `Node` in order to solve conflicts
        // and re-evaluate `Conditions`
        activeAttributes.forEach { attribute in
            if let activationGroup = self.add(attribute: attribute) {
                activateConstraints.append(contentsOf: activationGroup.0)
                deactivateConstraints.append(contentsOf: activationGroup.1)
            }
        }
        
        return (activateConstraints, deactivateConstraints)
    }
    
    /**
        Returns all the active `NSLayoutConstraints` within the node and
        clears all the persisted `Attributes`
        - returns an array of `NSLayoutConstraints` to deactivate
     */
    func clear() -> [NSLayoutConstraint] {
        let deactivateConstraints = self.deactivate(attributes: self.activeAttributes)
        self.inactiveAttributes = []
        
        return deactivateConstraints
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
        case .left, .leading, .leftMargin, .leadingMargin, .top, .firstBaseline, .topMargin:
            return .left
        case .right, .trailing, .rightMargin, .trailingMargin, .bottom, .lastBaseline, .bottomMargin:
            return .right
        case .centerX, .centerY, .centerXWithinMargins, .centerYWithinMargins:
            return .center
        case .width, .height:
            return .dimension
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
        case .left, .leading, .top, .firstBaseline:
            return .left
        case .right, .trailing, .bottom, .lastBaseline:
            return .right
        case .centerX, .centerY:
            return .center
        case .width, .height:
            return .dimension
        }
    }
    
}

#endif
