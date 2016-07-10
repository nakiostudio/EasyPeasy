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
    
}
