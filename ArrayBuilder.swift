// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if swift(>=5.4)
import Foundation

@resultBuilder
public enum EasyPeasyArrayBuilder<T> {
    public typealias Component = [T]

    public static func buildExpression(_ expression: T) -> Component {
        [expression]
    }

    public static func buildExpression(_ expression: Component) -> Component {
        expression
    }

    public static func buildExpression(_ expression: Void) -> Component {
        []
    }

    public static func buildBlock(_ components: Component...) -> Component {
        buildArray(components)
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }

    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    public static func buildArray(_ components: [Self.Component]) -> Self.Component {
        components.flatMap{ $0 }
    }
}
#endif
