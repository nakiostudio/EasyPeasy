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
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        var shouldApply = false
        viewA <- Width(120).when { shouldApply }
        viewA <- Height(120)
        XCTAssertTrue((viewA.constraints.filter{$0.easy_attribute != nil}).count == 1)
        
        // when
        shouldApply = true
        viewA.easy_reload()
        
        // then
        XCTAssertTrue((viewA.constraints.filter{$0.easy_attribute != nil}).count == 2)
    }
    
    func testThatReloadMethodReinstallsTheAttributesAppliedAndThisIsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        var shouldApply = false
        viewA <- Left(120).when { shouldApply }
        viewA <- Right(120)
        XCTAssertTrue((superview.constraints.filter{$0.easy_attribute != nil}).count == 1)
        
        // when
        shouldApply = true
        viewA.easy_reload()
        
        // then
        XCTAssertTrue((superview.constraints.filter{$0.easy_attribute != nil}).count == 2)
    }
    
    func testThatCompoundAttributesAreNotReturnedAndOnlyRegularAttributesStoredInView() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)

        // when
        let attributes = (viewA <- Edges(10)).flatMap { $0.easy_attribute }
        
        // then
        XCTAssertTrue(attributes.count == 4)
        for attribute in attributes {
            XCTAssertFalse(attribute is CompoundAttribute)
        }
        XCTAssertTrue(superview.attributes.count == 4)
        for attribute in superview.attributes {
            XCTAssertFalse(attribute is CompoundAttribute)
        }
    }
    
    func testThatAttributesAreCorrectlyCleared() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        viewA <- [
            Top(10),
            Left(10),
            Width(120),
            Height(300)
        ]
        viewB <- Edges(10)
        XCTAssertTrue(superview.constraints.count == 6)
        XCTAssertTrue(superview.attributes.count == 6)
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.attributes.count == 2)
        
        // when
        viewA.easy_clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 4)
        XCTAssertTrue(superview.attributes.count == 4)
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.attributes.count == 0)
    }
    
    func testThatClearWhenViewDoesntHaveSuperviewDoesnotThrowAssertion() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        viewA <- [
            Top(10),
            Left(10),
            Width(120),
            Height(300)
        ]
        viewB <- Edges(10)
        XCTAssertTrue(superview.constraints.count == 6)
        XCTAssertTrue(superview.attributes.count == 6)
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.attributes.count == 2)
        
        // when
        viewA.easy_clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 4)
        XCTAssertTrue(superview.attributes.count == 4)
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.attributes.count == 0)
    }
    
    func testThatLayoutConstraintIsCreatedWithTheExpectedAttributes() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attribute = Width().like(viewB)
        let constraints = viewA <- attribute
        
        // then
        XCTAssertTrue(constraints[0].firstAttribute == .Width)
        XCTAssertTrue(constraints[0].firstItem === viewA)
        XCTAssertTrue(constraints[0].secondItem === viewB)
        XCTAssertTrue(constraints[0].easy_attribute === attribute)
        XCTAssertTrue(constraints[0].easy_attribute == attribute)
        XCTAssertTrue(constraints[0].easy_attribute! =~ attribute)
    }
    
    func testThatNoConstraintIsCreatedWhenViewDoesNotHaveSuperview() {
        // given
        let viewA = UIView(frame: CGRectZero)
        
        // when
        let constraints = viewA <- Top(100)
        
        // then
        XCTAssertTrue(constraints.count == 0)
    }
    
}
