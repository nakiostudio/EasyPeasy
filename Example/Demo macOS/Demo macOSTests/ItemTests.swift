// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
@testable import EasyPeasy

class ItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatOwningViewReturnsViewSuperview() {
        // given
        let superview = NSView(frame: CGRectZero)
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        
        // when
        let owningView = viewA.owningView
        
        // then
        XCTAssertNotNil(owningView)
        XCTAssertTrue(owningView === superview)
    }
    
    func testThatConstraintsArrayReturnsViewConstraints() {
        // given
        let superview = NSView(frame: CGRectZero)
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        
        // when
        let constraints = viewA <- Size(100)
        
        // then
        XCTAssertTrue(constraints.count > 0)
        XCTAssertTrue(constraints == viewA.constraints)
    }
    
    func testThatItemConformingClassThatIsNotViewOrLayoutGuideDoesNotHaveOwningView() {
        // given
        class TestClass: NSObject, Item {
            var constraints: [NSLayoutConstraint] {
                get {
                    return self.owningView?.constraints.filter { $0.firstItem === self } ?? []
                }
            }
        }
        let testClassInstance = TestClass()
        
        // when
        let owningView = testClassInstance.owningView
        
        // then
        XCTAssertNil(owningView)
    }
    
}
