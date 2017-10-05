// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/**
     Struct holding the main **EasyPeasy** operations: `layout`, `reload` and
     `clear`
 */
public struct EasyPeasy {
    
    /// Weak reference to the `Item` that owns this wrapper
    weak var item: Item?
    
    /**
         Applies the attributes given to the current item
         - parameter attributes: `Attributes` applied to the `Item`
         - returns: The array of `NSLayoutConstraints` created and applied
     */
    @discardableResult public func layout(_ attributes: Attribute...) -> [NSLayoutConstraint] {
        return self.item?.apply(attributes: attributes) ?? []
    }
    
    /**
         Applies the attributes given to the current item
         - parameter attributes: `Attributes` applied to the `Item`
         - returns: The array of `NSLayoutConstraints` created and applied
     */
    @discardableResult public func layout(_ attributes: [Attribute]) -> [NSLayoutConstraint] {
        return self.item?.apply(attributes: attributes) ?? []
    }
    
    /**
         This method will trigger the recreation of the  created using
         *EasyPeasy* for the current view. `Condition` closures will
         be evaluated again
     */
    public func reload() {
        self.item?.reload()
    }
    
    /**
         Clears all the constraints applied with EasyPeasy to current
         `Item`
     */
    public func clear() {
        self.item?.clear()
    }
    
}

