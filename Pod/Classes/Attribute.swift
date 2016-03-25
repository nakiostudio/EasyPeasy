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

public typealias Condition = UIView -> Bool

public class Attribute {
    
    public internal(set) var constant: Constant
    
    public internal(set) var priority: Priority
    
    public internal(set) var condition: Condition?
    
    public internal(set) weak var createView: UIView?
    
    public var createAttribute: ReferenceAttribute {
        switch self {
        case is Width: return .Width
        case is Height: return .Height
        case is Left: return .Left
        case is Right: return .Right
        case is Top: return .Top
        case is Bottom: return .Bottom
        case is Leading: return .Leading
        case is Trailing: return .Trailing
        case is CenterX: return .CenterX
        case is CenterY: return .CenterY
        case is FirstBaseline: return .FirstBaseline
        case is LastBaseline: return .LastBaseline
        case is LeftMargin: return .LeftMargin
        case is RightMargin: return .RightMargin
        case is TopMargin: return .TopMargin
        case is BottomMargin: return .BottomMargin
        case is LeadingMargin: return .LeadingMargin
        case is TrailingMargin: return .TrailingMargin
        case is CenterXWithinMargins: return .CenterXWithinMargins
        case is CenterYWithinMargins: return .CenterYWithinMargins
        case is Attribute: return .NotAnAttribute
        case is Attribute: return .NotAnAttribute
        }
    }
    
    public internal(set) weak var referenceView: UIView?
    
    public internal(set) var referenceAttribute: ReferenceAttribute?
    
    public init() {
        self.constant = Constant(0.0)
        self.priority = .HighPriority
    }
    
    public init(_ value: Double) {
        self.constant = Constant(value)
        self.priority = .HighPriority
    }
    
    public init(_ constant: Constant) {
        self.constant = constant
        self.priority = .HighPriority
    }
    
    // MARK: Public methods
    
    public func with(priority: Priority) -> Self {
        self.priority = priority
        return self
    }
    
    public func when(closure: Condition?) -> Self {
        self.condition = closure
        return self
    }
    
}
