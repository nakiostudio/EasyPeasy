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
    An enum representation of the different attribute
    classes available
 */
public enum ReferenceAttribute {
    
    // Dimesion attributes
    case Width
    case Height
    
    // Position attributes
    case Left
    case Right
    case Top
    case Bottom
    case Leading
    case Trailing
    case CenterX
    case CenterY
    case FirstBaseline
    case LastBaseline
#if os(iOS) || os(tvOS)
    case LeftMargin
    case RightMargin
    case TopMargin
    case BottomMargin
    case LeadingMargin
    case TrailingMargin
    case CenterXWithinMargins
    case CenterYWithinMargins
#endif
    
    /// Reference attribute opposite to the current one
    internal var opposite: ReferenceAttribute {
        switch self {
        case .Width: return .Width
        case .Height: return .Height
        case .Left: return .Right
        case .Right: return .Left
        case .Top: return .Bottom
        case .Bottom:return .Top
        case .Leading: return .Trailing
        case .Trailing: return .Leading
        case .CenterX: return .CenterX
        case .CenterY: return .CenterY
        case .LastBaseline: return .LastBaseline
        case .FirstBaseline: return .FirstBaseline
        default:
            #if os(iOS) || os(tvOS)
            switch self {
            case .LeftMargin: return .RightMargin
            case .RightMargin: return .LeftMargin
            case .TopMargin: return .BottomMargin
            case .BottomMargin: return .TopMargin
            case .LeadingMargin: return .TrailingMargin
            case .TrailingMargin: return .LeadingMargin
            case .CenterXWithinMargins: return .CenterXWithinMargins
            case .CenterYWithinMargins: return .CenterYWithinMargins
            default: return .Width // This point should never be reached
            }
            #else
            return .Width // This point should never be reached
            #endif
        }
    }
    
    /// AutoLayout attribute equivalent of the current reference
    /// attribute
    internal var layoutAttribute: NSLayoutAttribute {
        switch self {
        case .Width: return .Width
        case .Height: return .Height
        case .Left: return .Left
        case .Right: return .Right
        case .Top: return .Top
        case .Bottom:return .Bottom
        case .Leading: return .Leading
        case .Trailing: return .Trailing
        case .CenterX: return .CenterX
        case .CenterY: return .CenterY
        case .LastBaseline: return .LastBaseline
        case .FirstBaseline:
            #if os(iOS) || os(tvOS)
            return .FirstBaseline
            #else
            if #available(OSX 10.11, *) {
                return .FirstBaseline
            }
            else {
                return .LastBaseline
            }
            #endif
        default:
            #if os(iOS) || os(tvOS)
            switch self {
            case .LeftMargin: return .LeftMargin
            case .RightMargin: return .RightMargin
            case .TopMargin: return .TopMargin
            case .BottomMargin: return .BottomMargin
            case .LeadingMargin: return .LeadingMargin
            case .TrailingMargin: return .TrailingMargin
            case .CenterXWithinMargins: return .CenterXWithinMargins
            case .CenterYWithinMargins: return .CenterYWithinMargins
            default: return .Width // This point should never be reached
            }
            #else
            return .Width // This point should never be reached
            #endif
        }
    }
    
    /// Property that determines whether the constant of 
    /// the `Attribute` should be multiplied by `-1`. This
    /// is usually done for right hand `PositionAttribute`
    /// objects
    internal var shouldInvertConstant: Bool {
        switch self {
        case .Width: return false
        case .Height: return false
        case .Left: return false
        case .Right: return true
        case .Top: return false
        case .Bottom:return true
        case .Leading: return false
        case .Trailing: return true
        case .CenterX: return false
        case .CenterY: return false
        case .FirstBaseline: return false
        case .LastBaseline: return true
        default:
            #if os(iOS) || os(tvOS)
            switch self {
            case .LeftMargin: return false
            case .RightMargin: return true
            case .TopMargin: return false
            case .BottomMargin: return true
            case .LeadingMargin: return false
            case .TrailingMargin: return true
            case .CenterXWithinMargins: return false
            case .CenterYWithinMargins: return false
            default: return false // This point should never be reached
            }
            #else
            return false // This point should never be reached
            #endif
        }
    }
    
}

#if os(iOS) || os(tvOS)
    
/**
    Extends `ReferenceAttribute` to ease the creation of
    an `Attribute` signature
 */
internal extension ReferenceAttribute {
    
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
internal extension ReferenceAttribute {
    
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
