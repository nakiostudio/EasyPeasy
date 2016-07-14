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
 
 */
private enum NodeAttribute {
    
    case Left, Right, Center, Dimension
    
}

/**
 
 */
internal class Node {
    
    ///
    private(set) var left: Attribute?
    
    ///
    private(set) var right: Attribute?
    
    ///
    private(set) var center: Attribute?
    
    ///
    private(set) var dimension: Attribute?
    
    ///
    private(set) var inactiveAttributes: [Attribute] = []
   
    ///
    internal var activeAttributes: [Attribute] {
        return [self.left, self.right, self.center, self.dimension].flatMap { $0 }
    }
    
    /**
 
     */
    func add(attribute attribute: Attribute) -> [NSLayoutConstraint] {
        guard attribute.shouldInstall() else {
            self.inactiveAttributes.append(attribute)
            return []
        }
        
        //
        let nodeAttribute = attribute.createAttribute.nodeAttribute
        switch nodeAttribute {
        case .Left:
            if self.left === attribute { return [] }
            self.deactivate(attributes: self.left, self.center)
            self.left = attribute
        case .Right:
            if self.right === attribute { return [] }
            self.deactivate(attributes: self.right, self.center)
            self.right = attribute
        case .Center:
            if self.center === attribute { return [] }
            self.deactivate(attributes: self.center, self.left, self.right)
            self.center = attribute
        case .Dimension:
            if self.dimension === attribute { return [] }
            var deactivateAttributes = [self.dimension].flatMap { $0 }
            if let left = self.left, right = self.right {
                deactivateAttributes.appendContentsOf([left, right])
            }
            self.deactivate(attributes: deactivateAttributes)
            self.dimension = attribute
        }
        
        //
        if let layoutConstraint = attribute.layoutConstraint {
            return [layoutConstraint]
        }
        
        return []
    }
    
    /**
     
     */
    func deactivate(attributes attributes: Attribute?...) {
        self.deactivate(attributes: attributes.flatMap { $0 })
    }
    
    /**
     
     */
    func deactivate(attributes attributes: [Attribute]) {
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
     
     */
    func reload() -> [NSLayoutConstraint] {
        
        // Deactivate `Attributes` which condition changed to false
        let deactivatedAttributes = self.activeAttributes.filter { $0.shouldInstall() == false }
        self.deactivate(attributes: deactivatedAttributes)
        
        // Gather all the existing `Attributes` that need to be readed
        // to the `Node`
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
 
     */
    func clear() {
        self.deactivate(attributes: self.activeAttributes)
        self.inactiveAttributes = []
    }
    
}

#if os(iOS) || os(tvOS)
    
/**
 
 */
private extension ReferenceAttribute {
    
    ///
    var nodeAttribute: NodeAttribute {
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
 
 */
private extension ReferenceAttribute {
    
    ///
    var nodeAttribute: NodeAttribute {
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
