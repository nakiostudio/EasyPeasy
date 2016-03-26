// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

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
    @available(iOS 8.0, *)
    case LeftMargin
    @available(iOS 8.0, *)
    case RightMargin
    @available(iOS 8.0, *)
    case TopMargin
    @available(iOS 8.0, *)
    case BottomMargin
    @available(iOS 8.0, *)
    case LeadingMargin
    @available(iOS 8.0, *)
    case TrailingMargin
    @available(iOS 8.0, *)
    case CenterXWithinMargins
    @available(iOS 8.0, *)
    case CenterYWithinMargins
    
    // Default
    case NotAnAttribute
    
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
        case .FirstBaseline: return .FirstBaseline
        case .LastBaseline: return .LastBaseline
        case .LeftMargin: return .RightMargin
        case .RightMargin: return .LeftMargin
        case .TopMargin: return .BottomMargin
        case .BottomMargin: return .TopMargin
        case .LeadingMargin: return .TrailingMargin
        case .TrailingMargin: return .LeadingMargin
        case .CenterXWithinMargins: return .CenterXWithinMargins
        case .CenterYWithinMargins: return .CenterYWithinMargins
        case .NotAnAttribute: return .NotAnAttribute
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
        case .FirstBaseline: return .FirstBaseline
        case .LastBaseline: return .LastBaseline
        case .LeftMargin: return .LeftMargin
        case .RightMargin: return .RightMargin
        case .TopMargin: return .TopMargin
        case .BottomMargin: return .BottomMargin
        case .LeadingMargin: return .LeadingMargin
        case .TrailingMargin: return .TrailingMargin
        case .CenterXWithinMargins: return .CenterXWithinMargins
        case .CenterYWithinMargins: return .CenterYWithinMargins
        case .NotAnAttribute: return .NotAnAttribute
        }
    }
    
    /// Reference attributes that may conflict with the current one
    internal var conflictingAttributes: [ReferenceAttribute] {
        switch self {
        case .Width:
            return [.Width]
        case .Height:
            return [.Height]
        case .Left:
            return [.Left, .CenterX, .Leading, .LeftMargin, .CenterXWithinMargins, .LeadingMargin]
        case .Right:
            return [.Right, .CenterX, .Trailing, .RightMargin, .CenterXWithinMargins, .TrailingMargin]
        case .Top:
            return [.Top, .CenterY, .FirstBaseline, .TopMargin, .CenterYWithinMargins]
        case .Bottom:
            return [.Bottom, .CenterY, LastBaseline, .BottomMargin, .CenterYWithinMargins]
        case .Leading:
            return [.Leading, .Left, .CenterX, .LeftMargin, .CenterXWithinMargins]
        case .Trailing:
            return [.Trailing, .Right, .CenterX, .RightMargin, .CenterXWithinMargins]
        case .CenterX:
            return [.CenterX, .Left, .Right, .Leading, .Trailing, .LeftMargin, .RightMargin, .CenterXWithinMargins, .LeadingMargin, .TrailingMargin]
        case .CenterY:
            return [.CenterY, .Top, .Bottom, .FirstBaseline, .LastBaseline, .TopMargin, .BottomMargin, .CenterYWithinMargins]
        case .FirstBaseline:
            return [.FirstBaseline, .Top, .CenterY, .TopMargin, .CenterYWithinMargins]
        case .LastBaseline:
            return [.LastBaseline, .Bottom, .CenterY, .BottomMargin, .CenterYWithinMargins]
        case .LeftMargin:
            return [.LeftMargin, .CenterXWithinMargins, .Left, .CenterX]
        case .RightMargin:
            return [.RightMargin, .CenterXWithinMargins, .Right, .CenterX]
        case .TopMargin:
            return [.TopMargin, .CenterYWithinMargins, .Top, .CenterY]
        case .BottomMargin:
            return [.BottomMargin, CenterYWithinMargins, .Bottom, .CenterY]
        case .LeadingMargin:
            return [.LeadingMargin, .LeftMargin, .CenterXWithinMargins, .Left, .Leading, .CenterX]
        case .TrailingMargin:
            return [.TrailingMargin, .RightMargin, .CenterXWithinMargins, .Right, .Trailing, .CenterX]
        case .CenterXWithinMargins:
            return [.CenterX, .Left, .Right, .Leading, .Trailing, .LeftMargin, .RightMargin, .CenterXWithinMargins, .LeadingMargin, .TrailingMargin]
        case .CenterYWithinMargins:
            return [.CenterY, .Top, .Bottom, .FirstBaseline, .LastBaseline, .TopMargin, .BottomMargin, .CenterYWithinMargins]
        case .NotAnAttribute:
            return []
        }
    }
    
}
