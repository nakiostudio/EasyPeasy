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
    
    /**
 
     */
    public func to(view: UIView, _ attribute: ReferenceAttribute? = nil) -> Self {
        self.referenceView = view
        self.referenceAttribute = attribute
        return self
    }
    
}

/**
    The left side of the object’s alignment rectangle
 */
public class Left: PositionAttribute { }

/**
    The right side of the object’s alignment rectangle
 */
public class Right: PositionAttribute { }

/**
    The top of the object’s alignment rectangle
 */
public class Top: PositionAttribute { }

/**
    The bottom of the object’s alignment rectangle
 */
public class Bottom: PositionAttribute { }

/**
    The leading edge of the object’s alignment rectangle
 */
public class Leading: PositionAttribute { }

/**
    The trailing edge of the object’s alignment rectangle
 */
public class Trailing: PositionAttribute { }

/**
    The center along the x-axis of the object’s alignment rectangle
 */
public class CenterX: PositionAttribute { }

/**
    The center along the y-axis of the object’s alignment rectangle
 */
public class CenterY: PositionAttribute { }

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the topmost line of text
 */
@available(iOS 8.0, *)
public class FirstBaseline: PositionAttribute { }

/**
    The object’s baseline. For objects with more than one line of text, 
    this is the baseline for the bottommost line of text
 */
public class LastBaseline: PositionAttribute { }

/**
    The object’s left margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class LeftMargin: PositionAttribute { }

/**
    The object’s right margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class RightMargin: PositionAttribute { }

/**
    The object’s top margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class TopMargin: PositionAttribute { }

/**
    The object’s bottom margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class BottomMargin: PositionAttribute { }

/**
    The object’s leading margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class LeadingMargin: PositionAttribute { }

/**
    The object’s trailing margin. For UIView objects, the margins are defined 
    by their layoutMargins property
 */
@available(iOS 8.0, *)
public class TrailingMargin: PositionAttribute { }

/**
    The center along the x-axis between the object’s left and right margin. 
    For UIView objects, the margins are defined by their layoutMargins property
 */
@available(iOS 8.0, *)
public class CenterXWithinMargins: PositionAttribute { }

/**
    The center along the y-axis between the object’s top and bottom margin. 
    For UIView objects, the margins are defined by their layoutMargins property
 */
@available(iOS 8.0, *)
public class CenterYWithinMargins: PositionAttribute { }
