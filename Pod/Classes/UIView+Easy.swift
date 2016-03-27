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

infix operator <- {}

/**
    Operator which applies the attribute given to the view located
    in the left hand side of it
    - parameter lhs: `UIView` the attributes will apply to
    - parameter rhs: Attribute applied to the `UIView`
    - returns: The array of attributes applied
 */
public func <- (lhs: UIView, rhs: Attribute) -> [Attribute] {
    return lhs <- [rhs]
}

/**
    Opeator which applies the attributes given to the view located
     in the left hand side of it
     - parameter lhs: UIView the attributes will apply to
     - parameter rhs: Attributes applied to the UIView
     - returns: The array of attributes applied
 */
public func <- (lhs: UIView, rhs: [Attribute]) -> [Attribute] {
    // Disable autoresizing to constraints translation
    lhs.translatesAutoresizingMaskIntoConstraints = false
    
    // Install each one of the params passed to the view given
    for attribute in rhs {
        attribute.installOnView(lhs)
    }
    
    // Gather regular attributes only as we don't want to store
    // `CompoundAttribute` objects
    var regularAttributes: [Attribute] = []
    for attribute in rhs {
        if let compountAttribute = attribute as? CompoundAttribute {
            regularAttributes.appendContentsOf(compountAttribute.attributes)
            continue
        }
        regularAttributes.append(attribute)
    }
    
    // Store the attributes applied in the superview
    lhs.superview?.easy_attributes.appendContentsOf(regularAttributes)
    
    // Return just regular `Attributes`, not `CompoundAttributes`
    return regularAttributes
}

public extension UIView {
    
    /**
        This method will trigger the recreation of the constraints
        created using *EasyPeasy* for the current view. `Condition` 
        closures will be evaluated again
     */
    public func easy_reload() {
        if let attributes = (self.superview?.easy_attributes.filter { $0.createView === self }) {
            self <- attributes
        }
    }
    
}
