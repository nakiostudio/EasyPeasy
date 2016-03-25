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
import ObjectiveC

internal var easy_attributesReference: Int = 0

internal extension UIView {
    
    internal var easy_attributes: [Attribute] {
        get {
            return objc_getAssociatedObject(self, &easy_attributesReference) as? [Attribute] ?? []
        }
        
        set {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &easy_attributesReference, newValue, policy)
        }
    }
    
}

infix operator <- {}

public func <- (lhs: UIView, rhs: [Attribute]) -> [Attribute] {
    lhs.translatesAutoresizingMaskIntoConstraints = false
    for attribute in rhs {
        attribute.installOnView(lhs)
    }
    return rhs
}

public func <- (lhs: UIView, rhs: Attribute) -> [Attribute] {
    return lhs <- [rhs]
}
