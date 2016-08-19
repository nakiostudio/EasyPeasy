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
     DimensionAttribute extension adding some convenience methods to operate with
     `NSViews`
 */
extension PositionAttribute {
    
    /**
        Establishes a position relationship between the `NSView` the attribute
        is applied to and the `NSView` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter view: The reference view
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @discardableResult public func to(_ view: NSView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = view
        self.referenceAttribute = attribute
        return self
    }
    
    /**
        Establishes a position relationship between the `NSView` the attribute
        is applied to and the `NSLayoutGuide` passed as parameter.
     
        It's also possible to link this relationship to a particular attribute
        of the `view` parameter by supplying `attribute`.
     
        - parameter layoutGuide: The reference `NSLayoutGuide`
        - parameter attribute: The attribute of `view` we are establishing the
        relationship to
        - returns: The current `Attribute` instance
     */
    @available(OSX 10.11, *)
    @discardableResult public func to(_ layoutGuide: NSLayoutGuide, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceItem = layoutGuide
        self.referenceAttribute = attribute
        return self
    }
    
}
    
#endif
