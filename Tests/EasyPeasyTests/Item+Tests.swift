// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@testable import EasyPeasy

extension Item {
    
    var test_attributes: [Attribute] {
        var attributes: [Attribute] = []
        for node in self.nodes.values {
            attributes.append(contentsOf: node.inactiveAttributes)
            attributes.append(contentsOf: node.activeAttributes.flatMap { $0 })
        }
        return attributes
    }
    
    var test_activeAttributes: [Attribute] {
        var attributes: [Attribute] = []
        for node in self.nodes.values {
            attributes.append(contentsOf: node.activeAttributes.flatMap { $0 })
        }
        return attributes
    }
    
    var test_inactiveAttributes: [Attribute] {
        var attributes: [Attribute] = []
        for node in self.nodes.values {
            attributes.append(contentsOf: node.inactiveAttributes)
        }
        return attributes
    }
    
}
