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
    Struct that based on an Attribute object creates
    the signature that will be used to access a `Node`
    stored in an `Item`
 */
internal struct Signature {
    
    /// String value of the `Signature` which hash is
    /// going to be used in order to access the persisted
    /// `Attributes`
    let stringValue: String
    
    /**
        Creates the `Signature` for the Attribute passed
        as parameter
        - parameter attribute: `Attribute` which properties
        will be used in order to create the `stringValue`
     */
    init(attribute: Attribute) {
        // Signature of the create `ReferenceAttribute` of
        // the passed `Attribute`
        var stringValue = attribute.createAttribute.signatureString
        
        // Signature of the `Modifier` of the passed 
        // `Attribute`
        switch attribute.constant.modifier {
        case .EqualTo, .MultipliedBy:
            stringValue += "eq_"
        case .GreaterThanOrEqualTo:
            stringValue += "gt_"
        case .LessThanOrEqualTo:
            stringValue += "lt_"
        }
        
        // Signature of the `Priority` of the passed
        // `Attribute`
        stringValue += String(attribute.priority.layoutPriority())
        
        // Set stringValue
        self.stringValue = stringValue
    }
    
}

#if os(iOS) || os(tvOS)

/**
     Extends `ReferenceAttribute` to ease the creation of
     a `Signature` strung
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
     a `Signature` strung
 */
private extension ReferenceAttribute {
    
    /// Signature of a `ReferenceAttribute`. Two possible values
    /// depending on the Axis the `ReferenceAttribute` applies
    var signatureString: String {
        switch attribute.createAttribute {
        case .Left, .Leading, .Right, .Trailing, .CenterX, .Width:
            return "h_"
        case .Top, .FirstBaseline, .Bottom, .LastBaseline, .CenterY, .Height:
            return "v_"
        }
    }
    
}
    
#endif
