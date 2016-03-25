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

public enum Modifier {
    
    case EqualTo
    case GreaterThanOrEqualTo
    case LessThanOrEqualTo
    case MultipliedBy
    
}

public struct Constant {
    
    let value: Double
    var modifier: Modifier
    
    init(_ value: Double) {
        self.value = value
        self.modifier = .EqualTo
    }
    
    init(value: Double, modifier: Modifier) {
        self.value = value
        self.modifier = modifier
    }
    
    internal func layoutRelation() -> NSLayoutRelation {
        switch self.modifier {
        case .EqualTo: return .Equal
        case .LessThanOrEqualTo: return .LessThanOrEqual
        case .GreaterThanOrEqualTo: return .GreaterThanOrEqual
        case .MultipliedBy: return .Equal
        }
    }
    
    internal func layoutMultiplier() -> CGFloat {
        switch self.modifier {
        case .EqualTo: return 1.0
        case .LessThanOrEqualTo: return 1.0
        case .GreaterThanOrEqualTo: return 1.0
        case .MultipliedBy: return CGFloat(self.value)
        }
    }
    
    internal func layoutValue() -> CGFloat {
        switch self.modifier {
        case .MultipliedBy: return 0.0
        default: return CGFloat(self.value)
        }
    }
    
}

prefix operator >= {}
public prefix func >= (rhs: Double) -> Constant {
    return Constant(value: rhs, modifier: .GreaterThanOrEqualTo)
}

prefix operator <= {}
public prefix func <= (rhs: Double) -> Constant {
    return Constant(value: rhs, modifier: .LessThanOrEqualTo)
}

prefix operator * {}
public prefix func * (rhs: Double) -> Constant {
    return Constant(value: rhs, modifier: .MultipliedBy)
}
