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
    public let isPad: Bool
    
    /// `true` if the current device is an iPhone
    public let isPhone: Bool
    
    /// `true` if both horizontal and vertical size classes are `.Compact`
    public let isHorizontalVerticalCompact: Bool
    
    /// `true` if horizontal size class is `.Compact`
    public let isHorizontalCompact: Bool
    
    /// `true` if vertical size class is `.Compact`
    public let isVerticalCompact: Bool
    
    /// `true` if both horizontal and vertical size classes are `.Regular`
    public let isHorizontalVerticalRegular: Bool
    
    /// `true` if horizontal size class is `.Regular`
    public let isHorizontalRegular: Bool
    
    /// `true` if vertical size class is `.Regular`
    public let isVerticalRegular: Bool
    
    /**
        Given an `UITraitCollection` object populates device and size class
        helper properties
     */
    init(with traitCollection: UITraitCollection) {
        // Device info
        self.isPad = traitCollection.userInterfaceIdiom == .pad
        self.isPhone = UIDevice.current.userInterfaceIdiom == .phone
        
        // Compact size classes
        self.isHorizontalCompact = traitCollection.horizontalSizeClass == .compact
        self.isVerticalCompact = traitCollection.verticalSizeClass == .compact
        self.isHorizontalVerticalCompact = traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact
        
        // Regular size classes
        self.isVerticalRegular = traitCollection.verticalSizeClass == .regular
        self.isHorizontalRegular = traitCollection.horizontalSizeClass == .regular
        self.isHorizontalVerticalRegular = traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular
    }
    
}

#endif
