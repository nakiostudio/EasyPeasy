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

//
typealias Relation = NSLayoutRelation

/**
    Struct that aggregates `NSLayoutRelation`, constant and multiplier of a 
    layout constraint eventually created
 */
public struct Constant {
    
    /// Value of the constant
    let value: CGFloat
    
    /// Modifier applied to the `value` of the `Constant`
    let relation: Relation
    
    //
    let multiplier: CGFloat
    
    /**
        This initializer creates a `Constant` with the `value` and `modifier` 
        supplied.
        - parameter value: Value of the `Constant`
        - parameter modifier: Modifier applied to the `value`
        - returns: the `Constant` struct created
     */
    init(value: CGFloat, relation: Relation, multiplier: CGFloat) {
        self.value = value
        self.relation = relation
        self.multiplier = multiplier
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
    return Constant(value: rhs, relation: .GreaterThanOrEqual, multiplier: 1.0)
}

prefix operator <= {}

/**
    Prefix operator that eases the creation of a `Constant` with a
    `.LessThanOrEqualTo` modifier.
    - parameter rhs: Value for the `Constant`
    - returns: The resulting `Constant` struct
 */
public prefix func <= (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, relation: .LessThanOrEqual, multiplier: 1.0)
}

prefix operator * {}

/**
    Prefix operator that eases the creation of a `Constant` with `value = 0.0`
    and `multiplier` the value specifier at the right hand side of the operator.
    - parameter rhs: Value for the `multiplier`
    - returns: The resulting `Constant` struct
 */
public prefix func * (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, relation: .Equal, multiplier: rhs)
}

/**
 
 */
public func * (lhs: Constant, rhs: CGFloat) -> Constant {
    return Constant(value: lhs.value, relation: lhs.relation, multiplier: lhs.multiplier * rhs)
}
