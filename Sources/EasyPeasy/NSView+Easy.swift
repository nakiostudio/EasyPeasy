// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if !(os(iOS) || os(tvOS))
    
import AppKit

infix operator <-
   
/**
    Apply operator definitions
 */
public extension NSView {

    /**
         Operator which applies the attribute given to the view located
         in the left hand side of it
         - parameter lhs: `NSView` the attributes will apply to
         - parameter rhs: Attribute applied to the `NSView`
         - returns: The array of `NSLayoutConstraints` applied
     */
    @available(iOS, deprecated: 1.5.1, message: "Use easy.layout(_:) instead")
    @discardableResult static public func <- (lhs: NSView, rhs: Attribute) -> [NSLayoutConstraint] {
        return lhs <- [rhs]
    }

    /**
         Opeator which applies the attributes given to the view located
         in the left hand side of it
         - parameter lhs: NSView the attributes will apply to
         - parameter rhs: Attributes applied to the NSView
         - returns: The array of `NSLayoutConstraints` applied
     */
    @available(iOS, deprecated: 1.5.1, message: "Use easy.layout(_:) instead")
    @discardableResult static public func <- (lhs: NSView, rhs: [Attribute]) -> [NSLayoutConstraint] {
        // Disable autoresizing to constraints translation
        lhs.translatesAutoresizingMaskIntoConstraints = false
        
        // Apply attributes and return the installed `NSLayoutConstraints`
        return lhs.apply(attributes: rhs)
    }
    
}
    
#endif
