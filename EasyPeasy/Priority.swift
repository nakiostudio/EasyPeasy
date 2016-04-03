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
    
    case CustomPriority(Float)
    case HighPriority
    case MediumPriority
    case LowPriority
    
    /**
        `UILayoutPriority` equivalent to the current case
        - returns `UILayoutPriority`
     */
    internal func layoutPriority() -> Float {
        switch self {
        case .CustomPriority(let value): return value
        case .HighPriority: return 1000.0
        case .MediumPriority: return 500.0
        case .LowPriority: return 1.0
        }
    }
    
}
