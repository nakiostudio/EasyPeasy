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

public class PositionAttribute: Attribute {
    
    public func to(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceView = view
        self.referenceAttribute = attribute
        return self
    }
    
}

/**
 
 */
public class Left: PositionAttribute { }

/**
 
 */
public class Right: PositionAttribute { }

/**
 
 */
public class Top: PositionAttribute { }

/**
 
 */
public class Bottom: PositionAttribute { }

/**
 
 */
public class Leading: PositionAttribute { }

/**
 
 */
public class Trailing: PositionAttribute { }

/**
 
 */
public class CenterX: PositionAttribute { }

/**
 
 */
public class CenterY: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class FirstBaseline: PositionAttribute { }

/**
 
 */
public class LastBaseline: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class LeftMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class RightMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class TopMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class BottomMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class LeadingMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class TrailingMargin: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class CenterXWithinMargins: PositionAttribute { }

/**
 
 */
@available(iOS 8.0, *)
public class CenterYWithinMargins: PositionAttribute { }
