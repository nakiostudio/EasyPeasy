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
    case LastBaseline
    case FirstBaseline
    
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
        case .NotAnAttribute: return .NotAnAttribute
        case .FirstBaseline:
            if #available(OSX 10.11, *) {
                return .FirstBaseline
            }
            else {
                return .LastBaseline
            }
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
        case .NotAnAttribute: return .NotAnAttribute
        case .FirstBaseline:
            if #available(OSX 10.11, *) {
                return .FirstBaseline
            }
            else {
                return .LastBaseline
            }
        }
    }
    
    /// Reference attributes that may conflict with the current one
    internal var conflictingAttributes: [ReferenceAttribute] {
        let left: [ReferenceAttribute] = [.Left, .CenterX, .Leading]
        let right: [ReferenceAttribute] = [.Right, .CenterX, .Trailing]
        let top: [ReferenceAttribute] = [.Top, .CenterY, .FirstBaseline]
        let bottom: [ReferenceAttribute] = [.Bottom, .CenterY, LastBaseline]
        let firstBaseLine: [ReferenceAttribute] = [.Top, .CenterY, .FirstBaseline]
        let lastBaseLine: [ReferenceAttribute] = [.LastBaseline, .Bottom, .CenterY]
        let centerX: [ReferenceAttribute] = [.CenterX, .Left, .Right, .Leading, .Trailing]
        let centerY: [ReferenceAttribute] = [.CenterY, .Top, .Bottom, .LastBaseline, .FirstBaseline]
        
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
        case .NotAnAttribute: return false
        }
    }
    
}
    
#endif
