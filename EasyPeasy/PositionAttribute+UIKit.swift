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

/**
     PositionAttribute extension adding some convenience methods to operate with
     UIKit elements as `UIViews` or `UILayoutGuides`
 */
extension PositionAttribute {
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UIView` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    public func to(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UILayoutSupport` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `layoutSupport` parameter by supplying `attribute`.
     
        - parameter layoutSupport: The reference `UILayoutSupport`
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    public func to(layoutSupport: UILayoutSupport, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutSupport
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a position relationship between the `UIView` the attribute
        is applied to and the `UILayoutGuide` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter layoutGuide: The reference `UILayoutGuide`
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @available(iOS 9.0, *)
    public func to(layoutGuide: UILayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
}
    
#endif
