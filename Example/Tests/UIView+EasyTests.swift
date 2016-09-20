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

class UIView_EasyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatReloadMethodReinstallsTheAttributesApplied() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        var shouldApply = false
        viewA <- Width(120).when { shouldApply }
        viewA <- Height(120)
        XCTAssertTrue(viewA.test_activeAttributes.count == 1)
        
        // when
        shouldApply = true
        viewA.easy_reload()
        
        // then
        XCTAssertTrue(viewA.test_activeAttributes.count == 2)
    }
    
    func testThatReloadBehaveAsExpectedAfterASecondPass() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        var shouldApply = false
        viewA <- Width(120).when { shouldApply }
        viewA <- Height(120)
        XCTAssertTrue(viewA.test_activeAttributes.count == 1)
        
        // when
        shouldApply = true
        viewA.easy_reload()
        
        // then
        XCTAssertTrue(viewA.test_activeAttributes.count == 2)
        
    }
    
    func testThatReloadMethodReinstallsTheAttributesAppliedAndThisIsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        var shouldApply = false
        viewA <- [
            FirstBaseline(>=0.0).when { shouldApply },
            CenterY().when { !shouldApply },
            LastBaseline(>=0.0).when { shouldApply },
            Size(20)
        ]
        XCTAssertTrue(viewA.test_activeAttributes.count == 3)
        XCTAssertTrue(viewA.test_inactiveAttributes.count == 2)
        
        // when
        shouldApply = true
        viewA.easy_reload()
        
        // then
        XCTAssertTrue(viewA.test_activeAttributes.count == 4)
        XCTAssertTrue(viewA.test_inactiveAttributes.count == 1)
        
        // And again
        
        // when
        shouldApply = false
        viewA.easy_reload()
        
        // then
        XCTAssertTrue(viewA.test_activeAttributes.count == 3)
        XCTAssertTrue(viewA.test_inactiveAttributes.count == 2)
    }
    
    func testThatCompoundAttributesAreNotReturnedAndOnlyRegularAttributesStoredInView() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)

        // when
        let constraints = viewA <- Edges(10)
        
        // then
        XCTAssertTrue(constraints.count == 4)
        XCTAssertTrue(viewA.test_attributes.count == 4)
        for attribute in viewA.test_attributes {
            XCTAssertFalse(attribute is CompoundAttribute)
        }
    }
    
    func testThatAttributesAreCorrectlyCleared() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        viewA <- [
            BottomMargin(10),
            TrailingMargin(10),
            Width(120),
            Height(300)
        ]
        XCTAssertTrue(superview.constraints.count == 2)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.test_attributes.count == 4)
        
        // when
        viewA.easy_clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 0)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.test_attributes.count == 0)
    }
    
    func testThatClearWhenViewDoesntHaveSuperviewDoesnotThrowAssertion() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        viewA <- [
            TopMargin(10),
            LeadingMargin(10),
            Width(120),
            Height(300)
        ]
        viewB <- Edges(10)
        XCTAssertTrue(superview.constraints.count == 6)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.test_attributes.count == 4)
        XCTAssertTrue(viewB.constraints.count == 0)
        XCTAssertTrue(viewB.test_attributes.count == 4)
        
        // when
        viewA.easy_clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 4)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.test_attributes.count == 0)
        XCTAssertTrue(viewB.constraints.count == 0)
        XCTAssertTrue(viewB.test_attributes.count == 4)
    }
    
    func testThatLayoutConstraintIsCreatedWithTheExpectedAttributes() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        
        // when
        let attribute = Width().like(viewB)
        let constraints = viewA <- attribute
        
        // then
        XCTAssertTrue(constraints[0].firstAttribute == .width)
        XCTAssertTrue(constraints[0].firstItem === viewA)
        XCTAssertTrue(constraints[0].secondItem === viewB)
        XCTAssertTrue(constraints[0] === attribute.layoutConstraint!)
    }
    
    func testThatNoConstraintIsCreatedWhenViewDoesNotHaveSuperview() {
        // given
        let viewA = UIView(frame: CGRect.zero)
        
        // when
        let constraints = viewA <- Top(100)
        
        // then
        XCTAssertTrue(constraints.count == 0)
    }
    
    func testThatConstraintsAreTheExpectedUponEasyClear() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        viewA <- [ Left(), Size(20), Top() ]
        XCTAssertTrue(superview.constraints.count == 2)
        XCTAssertTrue(viewA.constraints.count == 2)
            
        // when
        viewA.easy_clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 0)
        XCTAssertTrue(viewA.constraints.count == 0)
    }
    
    func testThatConstraintsAreTheExpectedUponEasyReload() {
        // given
        var condition = true
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        viewA <- [
            Left().when { condition },
            Right().when { condition },
            CenterX().when { !condition },
            Size(20),
            Top()
        ]
        XCTAssertTrue(superview.constraints.count == 3)
        XCTAssertTrue(viewA.constraints.count == 2)
        
        // when
        condition = false
        viewA.easy_reload()
        
        // then
        XCTAssertTrue(superview.constraints.count == 2)
        XCTAssertTrue(viewA.constraints.count == 2)
    }
    
}
