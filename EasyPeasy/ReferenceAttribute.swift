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
    case LeftMargin
    case RightMargin
    case TopMargin
    case BottomMargin
    case LeadingMargin
    case TrailingMargin
    case CenterXWithinMargins
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
        case .LastBaseline: return .LastBaseline
        case .FirstBaseline: return .FirstBaseline
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
        case .LastBaseline: return .LastBaseline
        case .FirstBaseline: return .FirstBaseline
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
        let left: [ReferenceAttribute] = [.Left, .CenterX, .Leading, .LeftMargin, .CenterXWithinMargins, .LeadingMargin]
        let right: [ReferenceAttribute] = [.Right, .CenterX, .Trailing, .RightMargin, .CenterXWithinMargins, .TrailingMargin]
        let top: [ReferenceAttribute] = [.Top, .CenterY, .FirstBaseline, .TopMargin, .CenterYWithinMargins]
        let bottom: [ReferenceAttribute] = [.Bottom, .CenterY, LastBaseline, .BottomMargin, .CenterYWithinMargins]
        let firstBaseLine: [ReferenceAttribute] = [.Top, .CenterY, .FirstBaseline, .TopMargin, .CenterYWithinMargins]
        let lastBaseLine: [ReferenceAttribute] = [.LastBaseline, .Bottom, .CenterY, .BottomMargin, .CenterYWithinMargins]
        let centerX: [ReferenceAttribute] = [.CenterX, .Left, .Right, .Leading, .Trailing, .LeftMargin, .RightMargin, .CenterXWithinMargins, .LeadingMargin, .TrailingMargin]
        let centerY: [ReferenceAttribute] = [.CenterY, .Top, .Bottom, .LastBaseline, .FirstBaseline, .TopMargin, .BottomMargin, .CenterYWithinMargins]
        
        switch self {
        case .Width: return [.Width]
        case .Height: return [.Height]
        case .Left: return left
        case .Right: return right
        case .Top: return top
        case .Bottom: return bottom
        case .Leading: return left
        case .Trailing: return right
        case .CenterX: return centerX
        case .CenterY: return centerY
        case .FirstBaseline: return firstBaseLine
        case .LastBaseline: return lastBaseLine
        case .LeftMargin: return left
        case .RightMargin: return right
        case .TopMargin: return top
        case .BottomMargin: return bottom
        case .LeadingMargin: return left
        case .TrailingMargin: return right
        case .CenterXWithinMargins: return centerX
        case .CenterYWithinMargins: return centerY
        case .NotAnAttribute: return []
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
        case .LeftMargin: return false
        case .RightMargin: return true
        case .TopMargin: return false
        case .BottomMargin: return true
        case .LeadingMargin: return false
        case .TrailingMargin: return true
        case .CenterXWithinMargins: return false
        case .CenterYWithinMargins: return false
        case .NotAnAttribute: return false
        }
    }
    
}
