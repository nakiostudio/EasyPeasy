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

@available (iOS 9.0, *)
class UILayoutGuide_EasyTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testThatPositionAttributeIsAppliedToLayoutGuide() {
        // given
        let superview = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide <- CenterX(10)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.active)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem === superview)
        XCTAssertTrue(constraints.first!.relation == .Equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .CenterX)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
    }
    
    func testThatDimensionAttributeIsAppliedToLayoutGuide() {
        // given
        let superview = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide <- Width(10)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.active)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem == nil)
        XCTAssertTrue(constraints.first!.relation == .Equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .Width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
    }
    
    func testThatPositionConflictIsResolved() {
        // given
        let superview = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        let constraints = layoutGuide <- Left(10)
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.active)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem === superview)
        XCTAssertTrue(constraints.first!.relation == .Equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .Left)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
        
        // when
        let newConstraints = layoutGuide <- CenterX(10)
        
        // then
        XCTAssertTrue(newConstraints.count == 1)
        XCTAssertNotNil(newConstraints.first)
        XCTAssertTrue(newConstraints.first!.active)
        XCTAssertTrue(newConstraints.first!.constant == 10)
        XCTAssertTrue(newConstraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(newConstraints.first!.secondItem === superview)
        XCTAssertTrue(newConstraints.first!.relation == .Equal)
        XCTAssertTrue(newConstraints.first!.firstAttribute == .CenterX)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === newConstraints.first)
    }
    
    func testThatWidthConflictIsResolved() {
        // given
        let superview = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        let constraints = layoutGuide <- Width(10)
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.active)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem == nil)
        XCTAssertTrue(constraints.first!.relation == .Equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .Width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
        
        // when
        let newConstraints = layoutGuide <- Width(100)
        
        // then
        XCTAssertTrue(newConstraints.count == 1)
        XCTAssertNotNil(newConstraints.first)
        XCTAssertTrue(newConstraints.first!.active)
        XCTAssertTrue(newConstraints.first!.constant == 100)
        XCTAssertTrue(newConstraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(newConstraints.first!.secondItem == nil)
        XCTAssertTrue(newConstraints.first!.relation == .Equal)
        XCTAssertTrue(newConstraints.first!.firstAttribute == .Width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === newConstraints.first)
    }

}
