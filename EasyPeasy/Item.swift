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
    
    /// Owning `UIView` for the current `Item`. The concept varies
    /// depending on the class conforming the protocol
    var owningView: View? { get }
    
}

/**
 
 */
public extension Item {
    
    /**
        This method will trigger the recreation of the constraints
        created using *EasyPeasy* for the current view. `Condition`
        closures will be evaluated again
     */
    public func easy_reload() { //TODO:
        
    }
    
    /**
        Clears all the constraints applied with EasyPeasy to the
        current `UIView`
     */
    public func easy_clear() { //TODO:
        
    }
    
}

/**
    Item protocol extension implementing some convenience properties
 */
internal extension Item {
    
    internal var nodes: [String:[Node]]? {
        get {
            if let nodes = objc_getAssociatedObject(self, &easy_attributesReference) as? [String:[Node]] {
                return nodes
            }
            return nil
        }
        
        set {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &easy_attributesReference, newValue, policy)
        }
    }

}
