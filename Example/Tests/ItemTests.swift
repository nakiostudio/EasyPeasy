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
        self.findDebugView()?.removeFromSuperview()
        super.tearDown()
    }

    func testThatOwningViewReturnsViewSuperview() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        let owningView = viewA.owningView
        
        // then
        XCTAssertNotNil(owningView)
        XCTAssertTrue(owningView === superview)
    }

    @available (iOS 9.0, *)
    func testThatOwningViewReturnsLayoutGuideOwningView() {
        // given
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        // when
        let owningView = layoutGuide.owningView
        
        // then
        XCTAssertNotNil(owningView)
        XCTAssertTrue(owningView === view)
    }
    
    func testThatConstraintsArrayReturnsViewConstraints() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        let constraints = viewA <- Size(100)
        
        // then
        XCTAssertTrue(constraints.count > 0)
        XCTAssertTrue(constraints == viewA.constraints)
    }
    
    @available (iOS 9.0, *)
    func testThatConstraintsArrayReturnsLayoutGuideConstraints() {
        // given
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide <- Edges()
        
        // then
        XCTAssertTrue(constraints.count > 0)
        XCTAssertTrue(constraints == layoutGuide.constraints)
    }
    
    @available (iOS 9.0, *)
    func testThatConstraintsArrayReturnsLayoutGuideConstraintsOwnedByGuide() {
        // given
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide <- Size(40)
        
        // then
        XCTAssertTrue(constraints.count > 0)
        XCTAssertTrue(constraints == layoutGuide.constraints)
    }
    
    func testThatItemConformingClassThatIsNotViewOrLayoutGuideDoesNotHaveOwningView() {
        // given
        class TestClass: NSObject, Item {
            var constraints: [NSLayoutConstraint] {
                get {
                    return self.owningView?.constraints.filter { $0.firstItem === self } ?? []
                }
            }
            
            var frame: CGRect {
                return CGRect.zero
            }
            
            fileprivate var owningView: View?
            
        }
        let testClassInstance = TestClass()
        
        // when
        let owningView = testClassInstance.owningView
        
        // then
        XCTAssertNil(owningView)
    }
    
    func testThatFramePropertyIsTheExpectedWhenItemIsAnUIVIew() {
        // given
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        // when
        // then
        let item = view as Item
        XCTAssertTrue(item.frame.equalTo(CGRect(x: 0, y: 0, width: 200, height: 200)))
    }
    
    func testThatDebugViewIsCreatedWithTheCreatedViewAttributes() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let view = UIView(frame: CGRect.zero)
        superview.addSubview(view)
        view <- [
            Left(10.0),
            Right(0.0)
        ]
        
        // when
        view.easy_debug()
        
        // then
        if let debugView = self.findDebugView() {
            XCTAssertTrue(debugView.attributes.count == 2)
            return
        }
        XCTFail()
    }
    
    func testThatDebugViewIsCreatedWithTheSpecifiedAttribute() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let view = UIView(frame: CGRect.zero)
        superview.addSubview(view)
        
        // when
        view <- [
            Left(10.0).debug(),
            Right(0.0)
        ]
        
        // then
        if let debugView = self.findDebugView() {
            XCTAssertTrue(debugView.attributes.count == 1)
            return
        }
        XCTFail()
    }
    
    func testThatDebugViewIsCreatedWithTheSpecifiedArrayOfAttributes() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let view = UIView(frame: CGRect.zero)
        superview.addSubview(view)
        
        // when
        view <- [
            Left(10.0),
            Right(0.0)
        ].debug()
        
        // then
        if let debugView = self.findDebugView() {
            XCTAssertTrue(debugView.attributes.count == 2)
            return
        }
        XCTFail()
    }
    
    // MARK: Aux methods
    
    func findDebugView() -> DebugView? {
        if let keyWindow = UIApplication.shared.keyWindow, let debugView = (keyWindow.subviews.filter { $0 is DebugView }).first as? DebugView {
            return debugView
        }
        
        return nil
    }
    
}
