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
    
/**
    Apply operator definitions
 */
@available (OSX 10.11, *)
extension NSLayoutGuide {

    /**
         Operator which applies the attribute given to the `NSLayoutGuide`
         located in the left hand side of it
         - parameter lhs: `NSLayoutGuide` the attributes will apply to
         - parameter rhs: Attribute applied to the `NSLayoutGuide`
         - returns: The array of `NSLayoutConstraints` applied
     */
    @discardableResult public static func <- (lhs: NSLayoutGuide, rhs: Attribute) -> [NSLayoutConstraint] {
        return lhs <- [rhs]
    }

    /**
         Opeator which applies the attributes given to the `NSLayoutGuide`
         located in the left hand side of it
         - parameter lhs: `NSLayoutGuide` the attributes will apply to
         - parameter rhs: Attributes applied to the `NSLayoutGuide`
         - returns: The array of `NSLayoutConstraints` applied
     */
    @discardableResult public static func <- (lhs: NSLayoutGuide, rhs: [Attribute]) -> [NSLayoutConstraint] {
        // Apply attributes and return the installed `NSLayoutConstraints`
        return lhs.apply(attributes: rhs)
    }

}
    
#endif
