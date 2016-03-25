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

public typealias Condition = () -> Bool

public class Attribute {
    
    public internal(set) var constant: Constant
    
    public internal(set) var priority: Priority
    
    public internal(set) var condition: Condition?
    
    public internal(set) weak var createView: UIView?
    
    public var createAttribute: ReferenceAttribute {
        return self.referenceAttributeFromClass()
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
