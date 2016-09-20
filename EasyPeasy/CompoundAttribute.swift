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

/**
    `Attribute` that leads on the application of multiple
    `Attribute` objects
 */
open class CompoundAttribute: Attribute {
    
    /// Array of attributes that shape the `CompoundAttribute`
    open internal(set) var attributes: [Attribute] = []
    
    // MARK: Public methods
    
    /**
         Sets the `priority` of the constraint and subconstraints
         - parameter priority: `Priority` enum specifying the
         priority of the constraint
         - returns: the `Attribute` instance
     */
    @discardableResult open override func with(_ priority: Priority) -> Self {
        super.with(priority)
        for attribute in self.attributes {
            attribute.with(priority)
        }
        return self
    }
    
    /**
        Sets the `when` closure of the `Attribute` and each one
        of the `Attribute` objects shaping the `CompoundAttribute`
         - parameter closure: `Closure` to be called before
         installing a constraint
         - returns: the `Attribute` instance
     */
    @discardableResult open override func when(_ closure: Condition?) -> Self {
        super.when(closure)
        for attribute in self.attributes {
            attribute.when(closure)
        }
        return self
    }
    
    #if os(iOS)
    /**
        Sets the `when` closure of the `Attribute` and each one
        of the `Attribute` objects shaping the `CompoundAttribute`
        - parameter closure: `Closure` to be called before installing a
        constraint
        - returns: the `Attribute` instance
     */
    @discardableResult open override func when(_ closure: ContextualCondition?) -> Self {
        super.when(closure)
        for attribute in self.attributes {
            attribute.when(closure)
        }
        return self
    }
    #endif
    
}
