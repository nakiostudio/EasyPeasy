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
        guard self.shouldInstallOnView(view) else {
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
    
    // MARK: Private methods
    
    private func shouldInstallOnView(view: UIView) -> Bool {
        self.createView = view
        guard let _ = view.superview else {
            return false
        }
        guard self.condition?(view) ?? true else {
            return false
        }
        return true
    }
    
    private func resolveConflictsOnView(view: UIView) {
        // Find conflicting constraints already installed
        let superview = view.superview!
        let conflictingConstraints = superview.constraints.filter { constraint in
            if let attribute = constraint.easy_attribute where attribute =~ self {
                return true
            }
            return false
        }
        let conflictAttributes = conflictingConstraints.map { $0.easy_attribute }
        
        // Disable conflicting installed constraints
        superview.removeConstraints(conflictingConstraints)
    }
    
}

/**
    Infix operator which determines whether two Attributes conflict
    between them or not
 */
infix operator =~ {}
internal func =~ (lhs: Attribute, rhs: Attribute) -> Bool {
    
    // Create views conflict
    if (lhs.createView === rhs.createView) == false {
        return false
    }
    
    // Create attributes conflict
    if lhs.createAttribute.conflictingAttributes.contains(rhs.createAttribute) == false {
        return false
    }
    
    // Priorities conflict
    if lhs.priority.layoutPriority() != rhs.priority.layoutPriority() {
        return false
    }
    
    // Conditions conflict
    var lhsCondition = true
    if let createView = lhs.createView {
        lhsCondition = lhs.shouldInstallOnView(createView)
    }
    
    var rhsCondition = true
    if let createView = rhs.createView {
        rhsCondition = rhs.shouldInstallOnView(createView)
    }
    
    if lhsCondition != rhsCondition {
        return false
    }
    
    return true
}
