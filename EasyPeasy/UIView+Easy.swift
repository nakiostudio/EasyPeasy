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

infix operator <- 
    
/**
     Apply operator definitions
 */
public extension UIView {

    /**
        Operator which applies the attribute given to the view located
        in the left hand side of it
        - parameter lhs: `UIView` the attributes will apply to
        - parameter rhs: Attribute applied to the `UIView`
        - returns: The array of `NSLayoutConstraints` applied
     */
    @available(iOS, deprecated: 1.5.1, message: "Use easy.layout(_:) instead")
    @discardableResult public static func <- (lhs: UIView, rhs: Attribute) -> [NSLayoutConstraint] {
        return lhs <- [rhs]
    }

    /**
        Opeator which applies the attributes given to the view located
         in the left hand side of it
         - parameter lhs: UIView the attributes will apply to
         - parameter rhs: Attributes applied to the UIView
         - returns: The array of `NSLayoutConstraints` applied
     */
    @available(iOS, deprecated: 1.5.1, message: "Use easy.layout(_:) instead")
    @discardableResult public static func <- (lhs: UIView, rhs: [Attribute]) -> [NSLayoutConstraint] {
        // Disable autoresizing to constraints translation
        lhs.translatesAutoresizingMaskIntoConstraints = false
        
        // Apply attributes and return the installed `NSLayoutConstraints`
        return lhs.apply(attributes: rhs)
    }
    
}
    
#endif

#if os(iOS) && EASY_RELOAD

/**
     Method that sets up the swizzling of `traitCollectionDidChange` if the
     compiler flag `EASY_RELOAD` has been defined
 */
private let traitCollectionDidChangeSwizzling: (UIView.Type) -> () = { view in
    let originalSelector = #selector(view.traitCollectionDidChange(_:))
    let swizzledSelector = #selector(view.easy_traitCollectionDidChange(_:))
    let originalMethod = class_getInstanceMethod(view, originalSelector)
    let swizzledMethod = class_getInstanceMethod(view, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

/**
    `UIView` extension that swizzles `traitCollectionDidChange` if the
     compiler flag `EASY_RELOAD` has been defined
 */
extension UIView {
    
    /**
        `traitCollectionDidChange` swizzling
     */
    open override class func initialize() {
        guard self === UIView.self else {
            return
        }
        
        traitCollectionDidChangeSwizzling(self)
    }
    
    /**
        Performs `easy_reload` when the `UITraitCollection` has changed for
        the current `UIView`, triggering the re-evaluation of the `Attributes`
        applied
     */
    func easy_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.easy_traitCollectionDidChange(previousTraitCollection)
        
        // If at least one `Attribute has been applied to the current
        // `UIView` then perform `easy_reload`
        if self.traitCollection.containsTraits(in: previousTraitCollection) == false && self.nodes.values.count > 0 {
            self.easy.reload()
        }
    }
    
}
    
#endif
