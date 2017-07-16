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

var easy_attributesReference: Int = 0

/**
    Typealias of a tuple grouping an array of `NSLayoutConstraints`
    to activate and another array of `NSLayoutConstraints` to
    deactivate
 */
typealias ActivationGroup = ([NSLayoutConstraint], [NSLayoutConstraint])

/**
    Protocol enclosing the objects a constraint will apply to
 */
public protocol Item: NSObjectProtocol {

    /// Array of constraints installed in the current `Item`
    var constraints: [NSLayoutConstraint] { get }
    
    /// Bounding `CGRect` of the current `Item`
    var frame: CGRect { get }
    
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
        var activateConstraints: [NSLayoutConstraint] = []
        var deactivateConstraints: [NSLayoutConstraint] = []
        for node in self.nodes.values {
            let activationGroup = node.reload()
            activateConstraints.append(contentsOf: activationGroup.0)
            deactivateConstraints.append(contentsOf: activationGroup.1)
        }
        
        // Activate/deactivate the resulting `NSLayoutConstraints`
        NSLayoutConstraint.deactivate(deactivateConstraints)
        NSLayoutConstraint.activate(activateConstraints)
    }
    
    /**
        Clears all the constraints applied with EasyPeasy to the
        current `UIView`
     */
    public func easy_clear() {
        var deactivateConstraints: [NSLayoutConstraint] = []
        for node in self.nodes.values {
            deactivateConstraints.append(contentsOf: node.clear())
        }
        self.nodes = [:]
        
        // Deactivate the resulting `NSLayoutConstraints`
        NSLayoutConstraint.deactivate(deactivateConstraints)
    }
    
}

#if os(iOS) || os(tvOS)
    
public extension Item {
    
    /**
        Draws in the screen the active `Attributes` applied to
        the current `Item`
     */
    public func easy_debug() {
        self.nodes.values.forEach { $0.activeAttributes.forEach { DebugView.show(attribute: $0) } }
    }
    
}

#endif

/**
    Internal extension that handles the storage and application 
    of `Attributes` in an `Item`
 */
extension Item {
    
    /// Dictionary persisting the `Nodes` related with this `Item`
    var nodes: [String:Node] {
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
    func apply(attributes: [Attribute]) -> [NSLayoutConstraint] {
        var layoutConstraints: [NSLayoutConstraint] = []
        var activateConstraints: [NSLayoutConstraint] = []
        var deactivateConstraints: [NSLayoutConstraint] = []
        
        for attribute in attributes {
            if let compoundAttribute = attribute as? CompoundAttribute {
                layoutConstraints.append(contentsOf: self.apply(attributes: compoundAttribute.attributes))
                continue
            }
            
            if let activationGroup = self.apply(attribute: attribute) {
                layoutConstraints.append(contentsOf: activationGroup.0)
                activateConstraints.append(contentsOf: activationGroup.0)
                deactivateConstraints.append(contentsOf: activationGroup.1)
            }
        }
        
        // Activate/deactivate the `NSLayoutConstraints` returned by the different `Nodes`
        NSLayoutConstraint.deactivate(deactivateConstraints)
        NSLayoutConstraint.activate(activateConstraints)
        
        return layoutConstraints
    }
    
    func apply(attribute: Attribute) -> ActivationGroup? {
        // Creates the `NSLayoutConstraint` of the `Attribute` holding
        // a reference to it from the `Attribute` objects
        attribute.createConstraints(for: self)
        
        // Checks the node correspoding to the `Attribute` and creates it
        // in case it doesn't exist
        let node = self.nodes[attribute.signature] ?? Node()
        
        // Set node
        self.nodes[attribute.signature] = node
        
        // Add the `Attribute` to the node and return the `NSLayoutConstraints`
        // to be activated/deactivated
        return node.add(attribute: attribute)
    }
    
}
