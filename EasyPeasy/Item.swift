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

public extension Item {
    
    /**
        This method will trigger the recreation of the constraints
        created using *EasyPeasy* for the current view. `Condition`
        closures will be evaluated again
     */
    public func easy_reload() {
        var layoutConstraints: [NSLayoutConstraint] = []
        for node in self.nodes.values {
            layoutConstraints.appendContentsOf(node.reload())
        }
        // Activate the resulting `NSLayoutConstraints`
        NSLayoutConstraint.activateConstraints(layoutConstraints)
    }
    
    /**
        Clears all the constraints applied with EasyPeasy to the
        current `UIView`
     */
    public func easy_clear() {
        for node in self.nodes.values {
            node.clear()
        }
        self.nodes = [:]
    }
    
}

/**
    Internal extension that handles the storage and application 
    of `Attributes` in an `Item`
 */
internal extension Item {
    
    /// Dictionary persisting the `Nodes` related with this `Item`
    internal var nodes: [String:Node] {
        get {
            if let nodes = objc_getAssociatedObject(self, &easy_attributesReference) as? [String:Node] {
                return nodes
            }
            
            let nodes: [String:Node] = [:]
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &easy_attributesReference, nodes, policy)
            return nodes
        }
        
        set {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &easy_attributesReference, newValue, policy)
        }
    }
    
    /**
        Applies the `Attributes` within the passed array to the current `Item`
        - parameter attributes: Array of `Attributes` to apply into the `Item`
        - returns the resulting `NSLayoutConstraints`
     */
    internal func apply(attributes attributes: [Attribute]) -> [NSLayoutConstraint] {
        var layoutConstraints: [NSLayoutConstraint] = []
        
        for attribute in attributes {
            //
            if let compoundAttribute = attribute as? CompoundAttribute {
                layoutConstraints.appendContentsOf(self.apply(attributes: compoundAttribute.attributes))
                continue
            }
            
            //
            let createdConstraints = self.apply(attribute: attribute)
            layoutConstraints.appendContentsOf(createdConstraints)
        }
        
        // Activate the `NSLayoutConstraints` returned by the different `Nodes`
        NSLayoutConstraint.activateConstraints(layoutConstraints)
        
        return layoutConstraints
    }
    
    internal func apply(attribute attribute: Attribute) -> [NSLayoutConstraint] {
        // Creates the `NSLayoutConstraint` of the `Attribute` holding
        // a reference to it from the `Attribute` objects
        attribute.createConstraints(for: self)
        
        // Checks the node correspoding to the `Attribute` and creates it
        // in case it doesn't exist
        let node = self.nodes[attribute.signature] ?? Node()
        
        // Add the `Attribute` to the node and appends the `NSLayoutConstraints`
        // that have to be activated
        let createdConstraints = node.add(attribute: attribute)
        
        // Set node
        self.nodes[attribute.signature] = node
        
        return createdConstraints
    }
    
}
