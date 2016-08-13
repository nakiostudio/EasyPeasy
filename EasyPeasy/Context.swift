// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS)
    
import UIKit

/**
     Struct that from an `UITraitCollection` object populates some helper 
     properties easing access to device and size class information
 */
public struct Context {
    
    /// `true` if the current device is an iPad
    public let isiPad: Bool
    
    /// `true` if the current device is an iPhone
    public let isiPhone: Bool
    
    /// `true` if both horizontal and vertical size classes are `.Compact`
    public let isCompact: Bool
    
    /// `true` if horizontal size class is `.Compact`
    public let isHorizontalCompact: Bool
    
    /// `true` if vertical size class is `.Compact`
    public let isVerticalCompact: Bool
    
    /// `true` if both horizontal and vertical size classes are `.Regular`
    public let isRegular: Bool
    
    /// `true` if horizontal size class is `.Regular`
    public let isHorizontalRegular: Bool
    
    /// `true` if vertical size class is `.Regular`
    public let isVerticalRegular: Bool
    
    /**
        Given an `UITraitCollection` object populates device and size class
        helper properties
     */
    internal init(with traitCollection: UITraitCollection) {
        // Device info
        self.isiPad = traitCollection.userInterfaceIdiom == .Pad
        self.isiPhone = UIDevice.currentDevice().userInterfaceIdiom == .Phone
        
        // Compact size classes
        self.isHorizontalCompact = traitCollection.horizontalSizeClass == .Compact
        self.isVerticalCompact = traitCollection.verticalSizeClass == .Compact
        self.isCompact = traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Compact
        
        // Regular size classes
        self.isVerticalRegular = traitCollection.verticalSizeClass == .Regular
        self.isHorizontalRegular = traitCollection.horizontalSizeClass == .Regular
        self.isRegular = traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular
    }
    
}

/**
    Typealias of a closure with a `Context` struct as parameter and `Bool`
    as returning type.

    This type of closure is used to evaluate whether an `Attribute` should
    be applied or not.
 */
public typealias ContextualCondition = (Context) -> Bool

/**
     `Attribute` extension for `ContextualCondition` related methods
 */
public extension Attribute {
    
    /**
        Sets the `when` closure of the `Attribute`
        - parameter closure: `Closure` to be called before installing a 
        constraint
        - returns: the `Attribute` instance
     */
    public func when(closure: ContextualCondition?) -> Self {
        self.condition = closure
        return self
    }
    
}

/**
     `Array` extension for `ContextualCondition` related methods
 */
public extension Array where Element: Attribute {
    
    /**
        Sets the `when` closure of each one of `Attributes` within the current 
        `Array`. If the condition was already set this method overrides it
        - parameter closure: `Closure` to be called before installing each 
        constraint
        - returns: the `Array` of `Attributes`
     */
    public func when(closure: ContextualCondition?) -> [Attribute] {
        for attribute in self {
            attribute.condition = closure
        }
        return self
    }
    
}

#endif
