// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

internal extension Attribute {
    
    internal func shouldInstallOnView(view: UIView) -> Bool {
        guard let _ = view.superview else {
            return false
        }
        guard self.condition?() ?? true else {
            return false
        }
        return true
    }
    
    internal func resolveConflictsOnView(view: UIView) {
        // Find conflicting constraints and attributes already installed
        let superview = view.superview!
        var conflictingAttributes: [Attribute] = []
        let conflictingConstraints = superview.constraints.filter { constraint in
            if let attribute = constraint.easy_attribute where attribute =~ self {
                conflictingAttributes.append(attribute)
                return true
            }
            return false
        }
        
        // Remove conflicting attributes stored in the superview
        superview.easy_attributes = superview.easy_attributes.filter {
            conflictingAttributes.contains($0) == false || $0 == self
        }
        
        // Disable conflicting installed constraints
        superview.removeConstraints(conflictingConstraints)
    }
    
    internal func referenceAttributeHelper() -> ReferenceAttribute {
        // If already set return
        if let attribute = self.referenceAttribute {
            return attribute
        }
        
        // If reference view is the superview then return same attribute
        // as `createAttribute`
        if let referenceView = self.referenceView where referenceView === self.createView?.superview {
            return self.createAttribute
        }
        
        // Otherwise return the opposite of `createAttribute`
        return self.createAttribute.opposite
    }
    
}

internal extension Attribute {
    
    /**
        Helper that creates the equivalent `ReferenceAttribute` for an
        `Attribute` subclass
        - returns: the equivalent `ReferenceAttribute`
     */
    internal func referenceAttributeFromClass() -> ReferenceAttribute {
        if #available(iOS 8.0, *) {
            switch self {
            case is Width: return .Width
            case is Height: return .Height
            case is Left: return .Left
            case is Right: return .Right
            case is Top: return .Top
            case is Bottom: return .Bottom
            case is Leading: return .Leading
            case is Trailing: return .Trailing
            case is CenterX: return .CenterX
            case is CenterY: return .CenterY
            case is FirstBaseline: return .FirstBaseline
            case is LastBaseline: return .LastBaseline
            case is LeftMargin: return .LeftMargin
            case is RightMargin: return .RightMargin
            case is TopMargin: return .TopMargin
            case is BottomMargin: return .BottomMargin
            case is LeadingMargin: return .LeadingMargin
            case is TrailingMargin: return .TrailingMargin
            case is CenterXWithinMargins: return .CenterXWithinMargins
            case is CenterYWithinMargins: return .CenterYWithinMargins
            default: return .NotAnAttribute
            }
        }
        
        switch self {
        case is Width: return .Width
        case is Height: return .Height
        case is Left: return .Left
        case is Right: return .Right
        case is Top: return .Top
        case is Bottom: return .Bottom
        case is Leading: return .Leading
        case is Trailing: return .Trailing
        case is CenterX: return .CenterX
        case is CenterY: return .CenterY
        case is LastBaseline: return .LastBaseline
        default: return .NotAnAttribute
        }
    }
    
}
