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

internal var easy_attributesReference: Int = 0

/**
    Protocol enclosing the objects a constraint will apply to
 */
public protocol Item: NSObjectProtocol {

    /// Array of constraints installed in the current `Item`
    var constraints: [NSLayoutConstraint] { get }
    
}

/**
    Item protocol extension implementing some convenience properties
 */
internal extension Item {
    
    /// Association with an array containing all the *EasyPeasy*
    /// attributes applied to the current `Item`
    internal var attributes: [Attribute] {
        get {
            if let attributes = objc_getAssociatedObject(self, &easy_attributesReference) as?
                [Attribute] {
                return attributes
            }
            return []
        }
        
        set {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &easy_attributesReference, newValue, policy)
        }
    }
    
    /// Owning `UIView` for the current `Item`. The concept varies
    /// depending on the class conforming the protocol
    internal var owningView: UIView? {
        get {
            // Owning view for `UIView` is the `superview`
            if let view = self as? UIView {
                return view.superview
            }
            
            // Owning view for `UILayoutGuide` is the `owningView`
            // iOS 9 and above only
            if #available(iOS 9.0, *) {
                if let layoutGuide = self as? UILayoutGuide {
                    return layoutGuide.owningView
                }
            }
            
            return nil
        }
    }
    
}

/**
    Extension making `UIView` conform the `Item` protocol and
    therefore inherit the extended methods and properties
 */
extension UIView: Item { }

/**
    Extension making `UILayoutGuide` conform the `Item` protocol 
    therefore and inherit the extended methods and properties
 */
@available(iOS 9.0, *)
extension UILayoutGuide: Item {
    
    /// Constraints in `owningView` with the current `UILayoutGuide`
    /// as `firstItem`
    public var constraints: [NSLayoutConstraint] {
        get {
            return self.owningView?.constraints.filter { $0.firstItem === self } ?? []
        }
    }
    
}
