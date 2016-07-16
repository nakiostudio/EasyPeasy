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
    Extension of `String` with a convenience method that
    eases the creation of an `Attribute` signature
 */
internal extension String {
    
    /**
        Creates the string value which hash will be used 
        to access a `Node` persisting a group of `Attributes`
        - parameter attribute: `Attribute` which properties
        will be used in order to create the `stringValue`
     */
    static func easy_signature(for attribute: Attribute) -> String {
        // Signature of the create `ReferenceAttribute` of
        // the passed `Attribute`
        var signature = attribute.createAttribute.signatureString
        
        // Signature of the `Modifier` of the passed 
        // `Attribute`
        switch attribute.constant.modifier {
        case .EqualTo, .MultipliedBy:
            signature += "eq_"
        case .GreaterThanOrEqualTo:
            signature += "gt_"
        case .LessThanOrEqualTo:
            signature += "lt_"
        }
        
        // Signature of the `Priority` of the passed
        // `Attribute`
        signature += String(attribute.priority.layoutPriority())
        
        return signature
    }
    
}

#if os(iOS) || os(tvOS)

/**
     Extends `ReferenceAttribute` to ease the creation of
     an `Attribute` signature
 */
private extension ReferenceAttribute {
    
    /// Signature of a `ReferenceAttribute`. Two possible values
    /// depending on the Axis the `ReferenceAttribute` applies
    var signatureString: String {
        switch self {
        case .Left, .Leading, .LeftMargin, .LeadingMargin, .Right, .Trailing, .RightMargin, .TrailingMargin, .CenterX, .CenterXWithinMargins, .Width:
            return "h_"
        case .Top, .FirstBaseline, .TopMargin, .Bottom, .LastBaseline, .BottomMargin, .CenterY, .CenterYWithinMargins, .Height:
            return "v_"
        }
    }
    
}
    
#else
    
/**
     Extends `ReferenceAttribute` to ease the creation of
     an `Attribute` signature
 */
private extension ReferenceAttribute {
    
    /// Signature of a `ReferenceAttribute`. Two possible values
    /// depending on the Axis the `ReferenceAttribute` applies
    var signatureString: String {
        switch self {
        case .Left, .Leading, .Right, .Trailing, .CenterX, .Width:
            return "h_"
        case .Top, .FirstBaseline, .Bottom, .LastBaseline, .CenterY, .Height:
            return "v_"
        }
    }
    
}
    
#endif
