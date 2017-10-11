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
    Alias of `NSLayoutRelation`
 */
#if os(OSX) && swift(>=4.0)
    public typealias Relation = NSLayoutConstraint.Relation
#else
    public typealias Relation = NSLayoutRelation
#endif

/**
    Struct that aggregates `NSLayoutRelation`, constant and multiplier of a 
    layout constraint eventually created
 */
public struct Constant {
    
    /// Value of the constant
    public let value: CGFloat
    
    /// Relation that applies to the `value` of the `Constant`
    public let relation: Relation
    
    /// Multiplier of the `Constant`
    public let multiplier: CGFloat
    
    /**
        This initializer creates a `Constant` with the `value`, `relations`
        and `multiplier` supplied.
        - parameter value: Value of the `Constant`
        - parameter relation: `Relation that applies to the `value`
        - parameter multiplier: Multiplier of the `Constant`
        - returns: the `Constant` struct created
     */
    public init(value: CGFloat, relation: Relation, multiplier: CGFloat) {
        self.value = value
        self.relation = relation
        self.multiplier = multiplier
    }
    
}

/// Operator that eases the creation of a `Constant` with a `.Equal` relation
prefix operator ==

/// Operator that eases the creation of a `Constant` with a 
/// `.GreaterThanOrEqual` relation
prefix operator >=

/// Operator that eases the creation of a `Constant` with a `.LessThanOrEqual` 
/// relation
prefix operator <=

/// Operator that eases the creation of a `Constant` with `value = 0.0` and 
/// `multiplier` the value specifier at the right hand side of the operator
prefix operator *

/**
    Definistion of custom `CGFloat` operators that ease the creation of `Constant`
    structs
 */
public extension CGFloat {

    /**
        Prefix operator that eases the creation of a `Constant` with a
        `.Equal` relation
        - parameter rhs: Value for the `Constant`
        - returns: The resulting `Constant` struct
     */
    public static prefix func == (rhs: CGFloat) -> Constant {
        return Constant(value: rhs, relation: .equal, multiplier: 1.0)
    }

    /**
        Prefix operator that eases the creation of a `Constant` with a
        `.GreaterThanOrEqual` relation
        - parameter rhs: Value for the `Constant`
        - returns: The resulting `Constant` struct
     */
    public static prefix func >= (rhs: CGFloat) -> Constant {
        return Constant(value: rhs, relation: .greaterThanOrEqual, multiplier: 1.0)
    }

    /**
        Prefix operator that eases the creation of a `Constant` with a
        `.LessThanOrEqual` relation
        - parameter rhs: Value for the `Constant`
        - returns: The resulting `Constant` struct
     */
    public static prefix func <= (rhs: CGFloat) -> Constant {
        return Constant(value: rhs, relation: .lessThanOrEqual, multiplier: 1.0)
    }

    /**
        Prefix operator that eases the creation of a `Constant` with `value = 0.0`
        and `multiplier` the value specifier at the right hand side of the operator.
        - parameter rhs: Value for the `multiplier`
        - returns: The resulting `Constant` struct
     */
    public static prefix func * (rhs: CGFloat) -> Constant {
        return Constant(value: rhs, relation: .equal, multiplier: rhs)
    }

    /**
        Infix operator that applies the `multiplier` at the right hand side to the
        `Constant` at the left hand side. 
        i.e. `Width((>=200.0)*0.5)` creates a `Constant` with `multiplier = 0.5`,
        `relation = .GreaterThanOrEqual` and `value = 200.0`.
        If the left hand side `Constant` already has a `multiplier` defined the 
        resulting `multiplier` will be the multiplication of both, previous and new
        `multipliers`.
        - parameter lhs: a `Constant`
        - parameter rhs: a `CGFloat` multiplier
        - returns: A new `Constant` with the `multiplier` applied
     */
    public static func * (lhs: Constant, rhs: CGFloat) -> Constant {
        return Constant(value: lhs.value, relation: lhs.relation, multiplier: lhs.multiplier * rhs)
    }

}
