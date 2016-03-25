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
    
    internal func installOnView(view: UIView) {
        // Reference to the target view
        self.createView = view
        
        // If condition is `false` return
        if self.shouldInstallOnView(view) == false {
            return
        }
        
        // Resolve constraint conflicts
        self.resolveConflictsOnView(view)
        
        // Build layout constraint
        let referenceAttribute = self.referenceAttribute ?? self.createAttribute.opposite
        let layoutConstraint = NSLayoutConstraint(
            item: view,
            attribute: self.createAttribute.layoutAttribute,
            relatedBy: self.constant.layoutRelation(),
            toItem: self.referenceView,
            attribute: referenceAttribute.layoutAttribute,
            multiplier: self.constant.layoutMultiplier(),
            constant: self.constant.layoutValue()
        )
        
        // Set priority
        layoutConstraint.priority = self.priority.layoutPriority()
        
        // Set associated Attribute
        layoutConstraint.easy_attribute = self
        
        // Add it to the view
        view.superview?.addConstraint(layoutConstraint)
    }
    
    internal func shouldInstallOnView(view: UIView) -> Bool {
        guard let _ = view.superview else {
            return false
        }
        guard self.condition?() ?? true else {
            return false
        }
        return true
    }
    
    // MARK: Private methods
    
    private func resolveConflictsOnView(view: UIView) {
        guard let _ = view.superview else {
            return
        }
        
        // Find conflicting constraints and attributes already installed
        let superview = view.superview!
        let conflictingConstraints = superview.constraints.filter { constraint in
            if let attribute = constraint.easy_attribute where attribute =~ self {
                return true
            }
            return false
        }
        let conflictingAttributes = conflictingConstraints.map { $0.easy_attribute }.flatMap { $0 }
        
        // Remove conflicting attributes stored in the superview
        superview.easy_attributes = superview.easy_attributes.filter {
            conflictingAttributes.contains($0) == false || $0 == self
        }
        
        // Disable conflicting installed constraints
        superview.removeConstraints(conflictingConstraints)
    }
    
}

internal extension Attribute {
    
    internal func referenceAttributeFromClass() -> ReferenceAttribute {
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
        case is Attribute: return .NotAnAttribute
        }
    }
    
}
