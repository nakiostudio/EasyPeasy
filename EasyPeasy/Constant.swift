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
    Modifier used when a relationship is created between the target `UIView`
    and the reference `UIView`. 
 
    Unlike `NSLayoutRelation` this enum also includes a `MultipliedBy` case
    which acts as the `multiplier property of a `NSLayoutConstraint`
 */
public enum Modifier {
    
    case EqualTo
    case GreaterThanOrEqualTo
    case LessThanOrEqualTo
    case MultipliedBy
    
}

/**
    Struct that aggregates `NSLayoutRelation`, constant and multiplier of a 
    layout constraint eventually created
 */
public struct Constant {
    
    /// Value of the constant
    let value: CGFloat
    
    /// Modifier applied to the `value` of the `Constant`
    var modifier: Modifier
    
    /**
        This initializer creates a `Constant` with the value supplied
        and the modifier `.EqualTo`
        - parameter value: Value of the `Constant`
        - returns: the `Constant` struct created
     */
    init(_ value: CGFloat) {
        self.value = value
        self.modifier = .EqualTo
    }
    
    /**
        This initializer creates a `Constant` with the `value` and `modifier` 
        supplied.
        - parameter value: Value of the `Constant`
        - parameter modifier: Modifier applied to the `value`
        - returns: the `Constant` struct created
     */
    init(value: CGFloat, modifier: Modifier) {
        self.value = value
        self.modifier = modifier
    }
    
    /**
        `NSLayoutRelation` equivalent to the `modifier` of the `Constant`
        - returns: `NSLayoutRelation` equivalent
     */
    internal func layoutRelation() -> NSLayoutRelation {
        switch self.modifier {
        case .EqualTo: return .Equal
        case .LessThanOrEqualTo: return .LessThanOrEqual
        case .GreaterThanOrEqualTo: return .GreaterThanOrEqual
        case .MultipliedBy: return .Equal
        }
    }
    
    /**
        Determines the `CGFloat` value of the multiplier for the `modifier`
        property
        - returns: `CGFloat` multiplier
     */
    internal func layoutMultiplier() -> CGFloat {
        switch self.modifier {
        case .EqualTo: return 1.0
        case .LessThanOrEqualTo: return 1.0
        case .GreaterThanOrEqualTo: return 1.0
        case .MultipliedBy: return CGFloat(self.value)
        }
    }
    
    /**
        Value of the `Constant`
        - returns: `CGFloat` value of the `Constant`
     */
    internal func layoutValue() -> CGFloat {
        switch self.modifier {
        case .MultipliedBy: return 0.0
        default: return CGFloat(self.value)
        }
    }
    
}

prefix operator >= {}

/**
    Prefix operator that eases the creation of a `Constant` with a
    `.GreaterThanOrEqualTo` modifier.
    - parameter rhs: Value for the `Constant`
    - returns: The resulting `Constant` struct
 */
public prefix func >= (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, modifier: .GreaterThanOrEqualTo)
}

prefix operator <= {}

/**
    Prefix operator that eases the creation of a `Constant` with a
    `.LessThanOrEqualTo` modifier.
    - parameter rhs: Value for the `Constant`
    - returns: The resulting `Constant` struct
 */
public prefix func <= (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, modifier: .LessThanOrEqualTo)
}

prefix operator * {}

/**
    Prefix operator that eases the creation of a `Constant` with `value = 0.0`
    and `multiplier` the value specifier at the right hand side of the operator.
    - parameter rhs: Value for the `multiplier`
    - returns: The resulting `Constant` struct
 */
public prefix func * (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, modifier: .MultipliedBy)
}
