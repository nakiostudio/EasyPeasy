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
    Enum which offers 3 pre-defined levels of `UILayoutPriority`
    as well as a case wrapping a `Float` value to specify actual
    values
 */
public enum Priority {
    
    case custom(Float)
    case required
    case high
    case medium
    case low
    
    @available(*, deprecated, message: "Use custom case instead")
    case customPriority(Float)
    @available(*, deprecated, message: "Use required case instead")
    case highPriority
    @available(*, deprecated, message: "Use medium case instead")
    case mediumPriority
    @available(*, deprecated, message: "Use low case instead")
    case lowPriority
    
    /**
        `UILayoutPriority` equivalent to the current case
        - returns `UILayoutPriority`
     */
    func layoutPriority() -> Float {
        switch self {
        case .customPriority(let value): return value
        case .highPriority: return 1000.0
        case .mediumPriority: return 500.0
        case .lowPriority: return 1.0
        case .custom(let value): return value
        case .required: return 1000.0
        case .high: return 750.0
        case .medium: return 500.0
        case .low: return 250.0
        }
    }
    
}
