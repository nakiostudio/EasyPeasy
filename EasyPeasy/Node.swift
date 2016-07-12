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
 
 */
internal enum NodeAttribute {
    
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
    private var activeAttributes: [Attribute] {
        return [self.left, self.right, self.center, self.dimension].flatMap { $0 }
    }
    
    /**
 
     */
    func add(attribute attribute: Attribute) -> NSLayoutConstraint? {
        //
        guard attribute.shouldInstall() else {
            self.inactiveAttributes.append(attribute)
            return nil
        }
        
        //
        let nodeAttribute = attribute.createAttribute.nodeAttribute
        switch nodeAttribute {
        case .Left:
            if self.left === attribute { return nil }
            self.deactivate(attributes: [self.left, self.center])
            self.left = attribute
            self.center = nil
        case .Right:
            if self.right === attribute { return nil }
            self.deactivate(attributes: [self.right, self.center])
            self.right = attribute
            self.center = nil
        case .Center:
            if self.center === attribute { return nil }
            self.deactivate(attributes: [self.center, self.left, self.right])
            self.center = attribute
            self.left = nil
            self.right = nil
        case .Dimension:
            if self.dimension === attribute { return nil }
            self.deactivate(attributes: [self.dimension, self.left, self.right])
            self.dimension = attribute
            self.left = nil
            self.right = nil
        }
        
        return attribute.layoutConstraint
    }
    
    /**
     
     */
    func deactivate(attributes attributes: [Attribute?]) {
        let layoutConstraints = attributes.flatMap { $0?.layoutConstraint }
        NSLayoutConstraint.deactivateConstraints(layoutConstraints)
    }
    
    /**
     
     */
    func reload() -> [NSLayoutConstraint] {
        var activeAttributes = self.activeAttributes
        activeAttributes.appendContentsOf(self.inactiveAttributes)
        
        self.inactiveAttributes = []
        
        let layoutAttributes = activeAttributes.flatMap { self.add(attribute: $0) }
        return layoutAttributes
    }
    
    /**
 
     */
    func clear() {
        self.deactivate(attributes: self.activeAttributes)
        self.left = nil
        self.right = nil
        self.center = nil
        self.dimension = nil
        self.inactiveAttributes = []
    }
    
}

#if os(iOS) || os(tvOS)
    
internal extension ReferenceAttribute {
    
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
    
internal extension ReferenceAttribute {
    
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
