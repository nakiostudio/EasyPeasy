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

/**
    Operator which applies the attribute given to the `UILayoutGuide`
    located in the left hand side of it
    - parameter lhs: `UILayoutGuide` the attributes will apply to
    - parameter rhs: Attribute applied to the `UILayoutGuide`
    - returns: The array of `NSLayoutConstraints` applied
 */
@available (iOS 9.0, *)
public func <- (lhs: UILayoutGuide, rhs: Attribute) -> [NSLayoutConstraint] {
    return lhs <- [rhs]
}

/**
    Opeator which applies the attributes given to the `UILayoutGuide`
    located in the left hand side of it
    - parameter lhs: `UILayoutGuide` the attributes will apply to
    - parameter rhs: Attributes applied to the `UILayoutGuide`
    - returns: The array of `NSLayoutConstraints` applied
 */
@available (iOS 9.0, *)
public func <- (lhs: UILayoutGuide, rhs: [Attribute]) -> [NSLayoutConstraint] {
    // Create constraints to install
    var constraintsToInstall: [NSLayoutConstraint] = []
    
    for attribute in rhs {
        // Create the constraint
        let newConstraints = attribute.createConstraintsForItem(lhs)
        constraintsToInstall.appendContentsOf(newConstraints)
    }
    
    // Install these constraints
    NSLayoutConstraint.activateConstraints(constraintsToInstall)
    
    // Return the installed `NSLayoutConstraints`
    return constraintsToInstall
}

/**
    Convenience methods applicable to `UIView` and subclasses
 */
@available (iOS 9.0, *)
public extension UILayoutGuide {
    
    /**
        This method will trigger the recreation of the constraints
        created using *EasyPeasy* for the current `UILayoutGuide`.
        `Condition` closures will be evaluated again
     */
    public func easy_reload() {
        var storedAttributes: [Attribute] = []
        
        // Reload attributes owned by the superview
        if let attributes = (self.owningView?.attributes.filter { $0.createItem === self }) {
            storedAttributes.appendContentsOf(attributes)
        }
        
        // Reload attributes owned by the current view
        let attributes = self.attributes.filter { $0.createItem === self }
        storedAttributes.appendContentsOf(attributes)
        
        // Apply
        self <- storedAttributes
    }
    
    /**
        Clears all the constraints applied with EasyPeasy to the
        current `UILayoutGuide`
     */
    public func easy_clear() {
        // Remove from the stored Attribute objects of the superview
        // those which createItem is the current UIView
        if let owningView = self.owningView {
            owningView.attributes = owningView.attributes.filter { $0.createItem !== self }
        }
        
        // Remove from the stored Attribute objects of the current view
        // those which createItem is the current UIView
        self.attributes = self.attributes.filter { $0.createItem !== self }
        
        // Now uninstall those constraints
        var constraintsToUninstall: [NSLayoutConstraint] = []
        
        // Gather NSLayoutConstraints with self as createItem
        for constraint in self.constraints {
            if let attribute = constraint.easy_attribute where attribute.createItem === self {
                constraintsToUninstall.append(constraint)
            }
        }
        
        // Deactive the constraints
        NSLayoutConstraint.deactivateConstraints(constraintsToUninstall)
    }
    
}
