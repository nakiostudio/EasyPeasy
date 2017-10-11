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
     DimensionAttribute extension adding some convenience methods to operate with 
     UIKit elements as `UIViews` or `UILayoutGuides`
 */
public extension DimensionAttribute {
 
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UIView` passed as
        parameter.
     
        It's also possible to link this relationship to a particular
        attribute of the `view` parameter by supplying `attribute`.
     
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @discardableResult public func like(_ view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UILayoutGuide`
        passed as parameter.
     
        It's also possible to link this relationship to a particular
        attribute of the `layoutGuide` parameter by supplying `attribute`.
     
        - parameter layoutGuide: The reference `UILayoutGuide`
        - parameter attribute: The attribute of `layoutGuide` we are  establishing
        the relationship to
        - returns: The current `Attribute` instance
     */
    @available (iOS 9.0, *)
    @discardableResult public func like(_ layoutGuide: UILayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
}

/**
     Size extension adding some convenience methods to let this  CompoundAttribute 
     operate with UIKit elements like `UIViews` or `UILayoutGuides`
 */
public extension Size {
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UIView` passed as
        parameter.
        - parameter view: The reference view
        - returns: The current `CompoundAttribute` instance
     */
    @discardableResult public func like(_ view: UIView) -> Self {
        self.referenceItem = view
        for attr in self.attributes {
            attr.referenceItem = view
        }
        return self
    }
    
    /**
        Establishes a relationship between the dimension attribute
        applied to the `UIView` and the reference `UILayoutGuide`
        passed as parameter.
        - parameter layoutGuide: The reference `UILayoutGuide`
        - returns: The current `CompoundAttribute` instance
     */
    @available (iOS 9.0, *)
    @discardableResult public func like(_ layoutGuide: UILayoutGuide) -> Self {
        self.referenceItem = layoutGuide
        for attr in self.attributes {
            attr.referenceItem = layoutGuide
        }
        return self
    }
    
}
    
#endif
