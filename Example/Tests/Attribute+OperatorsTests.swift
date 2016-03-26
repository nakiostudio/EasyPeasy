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
import UIKit
@testable import EasyPeasy

class Attribute_OperatorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests for conflicting operator
    
    func testThatConflictingOperatorReturnsFalseForAttributeAffectingDifferentViews() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Width(120)
        let attributeB = viewB <- Width(340)
        
        // then
        XCTAssertFalse(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConflictingOperatorReturnsTrueForConflictingAttributes() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB)
        let attributeB = viewA <- Left(340).to(viewB)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConflictingOperatorReturnsFalseForAttributesWithDifferentPriority() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB).with(.LowPriority)
        let attributeB = viewA <- Left(340).to(viewB)
        
        // then
        XCTAssertFalse(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConflictingOperatorReturnsTrueForAttributesWithSamePriority() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB).with(.LowPriority)
        let attributeB = viewA <- Left(340).to(viewB).with(.LowPriority)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConflictingOperatorReturnsFalseForAttributesWithDifferentResultOfWhenCondition() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB).with(.LowPriority).when { true }
        let attributeB = viewA <- Left(340).to(viewB).with(.LowPriority).when { false }
        
        // then
        XCTAssertFalse(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConflictingOperatorReturnsTrueForAttributesWithSameResultOfWhenCondition() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB).with(.LowPriority).when { true }
        let attributeB = viewA <- Left(340).to(viewB).with(.LowPriority).when { true }
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatConditionForTheLhsItemIsIgnored() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB).with(.LowPriority).when { false }
        let attributeB = viewA <- Left(340).to(viewB).with(.LowPriority).when { false }
        
        // then
        XCTAssertFalse(attributeA.first! =~ attributeB.first!)
    }
    
    func testThatLeftAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(120).to(viewB)
        let attributeB = viewA <- LeftMargin(340).to(viewB)
        let attributeC = viewA <- LeadingMargin(340).to(viewB)
        let attributeD = viewA <- CenterX(340).to(viewB)
        let attributeE = viewA <- CenterXWithinMargins(340).to(viewB)
        let attributeF = viewA <- Leading(450).to(viewB)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
        XCTAssertTrue(attributeB.first! =~ attributeC.first!)
        XCTAssertTrue(attributeC.first! =~ attributeD.first!)
        XCTAssertTrue(attributeD.first! =~ attributeE.first!)
        XCTAssertTrue(attributeE.first! =~ attributeF.first!)
        XCTAssertTrue(attributeB.first! =~ attributeA.first!)
        XCTAssertTrue(attributeC.first! =~ attributeB.first!)
        XCTAssertTrue(attributeD.first! =~ attributeC.first!)
        XCTAssertTrue(attributeE.first! =~ attributeD.first!)
        XCTAssertTrue(attributeF.first! =~ attributeE.first!)
    }
    
    func testThatRightAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Right(120).to(viewB)
        let attributeB = viewA <- TrailingMargin(340).to(viewB)
        let attributeC = viewA <- CenterX(340).to(viewB)
        let attributeD = viewA <- RightMargin(340).to(viewB)
        let attributeE = viewA <- CenterXWithinMargins(340).to(viewB)
        let attributeF = viewA <- Trailing(450).to(viewB)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
        XCTAssertTrue(attributeB.first! =~ attributeC.first!)
        XCTAssertTrue(attributeC.first! =~ attributeD.first!)
        XCTAssertTrue(attributeD.first! =~ attributeE.first!)
        XCTAssertTrue(attributeE.first! =~ attributeF.first!)
        XCTAssertTrue(attributeB.first! =~ attributeA.first!)
        XCTAssertTrue(attributeC.first! =~ attributeB.first!)
        XCTAssertTrue(attributeD.first! =~ attributeC.first!)
        XCTAssertTrue(attributeE.first! =~ attributeD.first!)
        XCTAssertTrue(attributeF.first! =~ attributeE.first!)
    }
    
    func testThatTopAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Top(120).to(viewB)
        let attributeB = viewA <- TopMargin(340).to(viewB)
        let attributeC = viewA <- CenterY(340).to(viewB)
        let attributeD = viewA <- FirstBaseline(340).to(viewB)
        let attributeE = viewA <- CenterYWithinMargins(340).to(viewB)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
        XCTAssertTrue(attributeB.first! =~ attributeC.first!)
        XCTAssertTrue(attributeC.first! =~ attributeD.first!)
        XCTAssertTrue(attributeD.first! =~ attributeE.first!)
        XCTAssertTrue(attributeB.first! =~ attributeA.first!)
        XCTAssertTrue(attributeC.first! =~ attributeB.first!)
        XCTAssertTrue(attributeD.first! =~ attributeC.first!)
        XCTAssertTrue(attributeE.first! =~ attributeD.first!)
    }
    
    func testThatBottomAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Bottom(120).to(viewB)
        let attributeB = viewA <- BottomMargin(340).to(viewB)
        let attributeC = viewA <- CenterY(340).to(viewB)
        let attributeD = viewA <- LastBaseline(340).to(viewB)
        let attributeE = viewA <- CenterYWithinMargins(340).to(viewB)
        
        // then
        XCTAssertTrue(attributeA.first! =~ attributeB.first!)
        XCTAssertTrue(attributeB.first! =~ attributeC.first!)
        XCTAssertTrue(attributeC.first! =~ attributeD.first!)
        XCTAssertTrue(attributeD.first! =~ attributeE.first!)
        XCTAssertTrue(attributeB.first! =~ attributeA.first!)
        XCTAssertTrue(attributeC.first! =~ attributeB.first!)
        XCTAssertTrue(attributeD.first! =~ attributeC.first!)
        XCTAssertTrue(attributeE.first! =~ attributeD.first!)
    }
    
    func testThatWidthDoesNotConflictWithHeight() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        
        // when
        let attributeA = viewA <- Width(200)
        let attributeB = viewA <- Height(100)
        
        // then
        XCTAssertFalse(attributeA.first! =~ attributeB.first!)
    }

    // MARK: Tests for equal operator
    
    func testThatSameAttributesButWithDifferentConstantAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- LeftMargin(>=10).to(viewB).with(.CustomPriority(23))
        let attributeB = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        
        // then 
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameConstantAreEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        let attributeB = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentModifierAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        let attributeB = viewA <- LeftMargin(11).to(viewB).with(.CustomPriority(23))
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithDifferentConditionEvaluationAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { true }
        let attributeB = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameConditionEvaluationAreEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButAppliedToDifferentViewsAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        let attributeB = viewB <- LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceViewAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceAttributesAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB, .Right).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- LeftMargin(>=11).to(viewB, .Left).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameCustomReferenceAttributesAreEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB, .LeftMargin).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- LeftMargin(>=11).to(viewB, .LeftMargin).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentPrioritiesAreNotEqual() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- LeftMargin(>=11).to(viewB, .LeftMargin).with(.LowPriority).when { false }
        let attributeB = viewA <- LeftMargin(>=11).to(viewB, .LeftMargin).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceViewsAreNotEqualWhenUsingLikeReferer() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- Width().like(viewC)
        let attributeB = viewA <- Width().like(viewB)
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameReferenceViewsAreEqualWhenUsingLikeReferer() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = UIView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- Width().like(viewC)
        let attributeB = viewA <- Width().like(viewC)
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
}
