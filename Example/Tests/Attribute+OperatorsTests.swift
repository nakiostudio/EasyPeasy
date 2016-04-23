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
        let attributeA = Width(120)
        let attributeB = Width(340)
        
        viewA <- attributeA
        viewB <- attributeB
        
        // then
        XCTAssertFalse(attributeA =~ attributeB)
    }
    
    func testThatConflictingOperatorReturnsTrueForConflictingAttributes() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB)
        let attributeB = Left(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
    }
    
    func testThatConflictingOperatorReturnsFalseForAttributesWithDifferentPriority() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB).with(.LowPriority)
        let attributeB = Left(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
            
        // then
        XCTAssertFalse(attributeA =~ attributeB)
    }
    
    func testThatConflictingOperatorReturnsTrueForAttributesWithSamePriority() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB).with(.LowPriority)
        let attributeB = Left(340).to(viewB).with(.LowPriority)
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
    }
    
    func testThatConflictingOperatorReturnsFalseForAttributesWithDifferentResultOfWhenCondition() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB).with(.LowPriority).when { true }
        let attributeB = Left(340).to(viewB).with(.LowPriority).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertFalse(attributeA =~ attributeB)
    }
    
    func testThatConflictingOperatorReturnsTrueForAttributesWithSameResultOfWhenCondition() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB).with(.LowPriority).when { true }
        let attributeB = Left(340).to(viewB).with(.LowPriority).when { true }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
    }
    
    func testThatConditionForTheLhsItemIsNotIgnored() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB).with(.LowPriority).when { false }
        let attributeB = Left(340).to(viewB).with(.LowPriority).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
    }
    
    func testThatLeftAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB)
        let attributeB = LeftMargin(340).to(viewB)
        let attributeC = LeadingMargin(340).to(viewB)
        let attributeD = CenterX(340).to(viewB)
        let attributeE = CenterXWithinMargins(340).to(viewB)
        let attributeF = Leading(450).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        viewA <- attributeD
        viewA <- attributeE
        viewA <- attributeF
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeD)
        XCTAssertTrue(attributeD =~ attributeE)
        XCTAssertTrue(attributeE =~ attributeF)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeD =~ attributeC)
        XCTAssertTrue(attributeE =~ attributeD)
        XCTAssertTrue(attributeF =~ attributeE)
    }
    
    func testThatRightAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Right(120).to(viewB)
        let attributeB = TrailingMargin(340).to(viewB)
        let attributeC = CenterX(340).to(viewB)
        let attributeD = RightMargin(340).to(viewB)
        let attributeE = CenterXWithinMargins(340).to(viewB)
        let attributeF = Trailing(450).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        viewA <- attributeD
        viewA <- attributeE
        viewA <- attributeF
        
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeD)
        XCTAssertTrue(attributeD =~ attributeE)
        XCTAssertTrue(attributeE =~ attributeF)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeD =~ attributeC)
        XCTAssertTrue(attributeE =~ attributeD)
        XCTAssertTrue(attributeF =~ attributeE)
    }
    
    func testThatTopAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Top(120).to(viewB)
        let attributeB = TopMargin(340).to(viewB)
        let attributeC = CenterY(340).to(viewB)
        let attributeD = FirstBaseline(340).to(viewB)
        let attributeE = CenterYWithinMargins(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        viewA <- attributeD
        viewA <- attributeE
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeD)
        XCTAssertTrue(attributeD =~ attributeE)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeD =~ attributeC)
        XCTAssertTrue(attributeE =~ attributeD)
    }
    
    func testThatBottomAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Bottom(120).to(viewB)
        let attributeB = BottomMargin(340).to(viewB)
        let attributeC = CenterY(340).to(viewB)
        let attributeD = LastBaseline(340).to(viewB)
        let attributeE = CenterYWithinMargins(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        viewA <- attributeD
        viewA <- attributeE
        
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeD)
        XCTAssertTrue(attributeD =~ attributeE)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeD =~ attributeC)
        XCTAssertTrue(attributeE =~ attributeD)
    }
    
    func testThatWidthDoesNotConflictWithHeight() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        
        // when
        let attributeA = Width(200)
        let attributeB = Height(100)
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertFalse(attributeA =~ attributeB)
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
        let attributeA = LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        let attributeB = LeftMargin(>=11).to(viewB).with(.CustomPriority(23))
        
        viewA <- attributeA
        viewA <- attributeB
        
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
        let attributeA = LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        let attributeB = LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewB <- attributeB
        
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
        let attributeA = LeftMargin(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        let attributeB = LeftMargin(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
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
        let attributeA = LeftMargin(>=11).to(viewB, .Right).with(.CustomPriority(23)).when { false }
        let attributeB = LeftMargin(>=11).to(viewB, .Left).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
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
        let attributeA = LeftMargin(>=11).to(viewB, .LeftMargin).with(.LowPriority).when { false }
        let attributeB = LeftMargin(>=11).to(viewB, .LeftMargin).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
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
        let attributeA = Width().like(viewC)
        let attributeB = Width().like(viewC)
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
}
