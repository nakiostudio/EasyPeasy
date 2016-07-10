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
import AppKit
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(120).to(viewB)
        let attributeB = CenterX(340).to(viewB)
        let attributeC = Leading(450).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeA =~ attributeC)
    }
    
    func testThatRightAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Right(120).to(viewB)
        let attributeB = CenterX(340).to(viewB)
        let attributeC = Trailing(450).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeA =~ attributeC)
    }
    
    func testThatTopAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Top(120).to(viewB)
        let attributeB = CenterY(340).to(viewB)
        let attributeC = FirstBaseline(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeA =~ attributeC)
    }
    
    func testThatBottomAttributeConflictsWithAllAttributesOfItsKind() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Bottom(120).to(viewB)
        let attributeB = CenterY(340).to(viewB)
        let attributeC = LastBaseline(340).to(viewB)
        
        viewA <- attributeA
        viewA <- attributeB
        viewA <- attributeC
        
        
        // then
        XCTAssertTrue(attributeA =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeC)
        XCTAssertTrue(attributeC =~ attributeA)
        XCTAssertTrue(attributeC =~ attributeB)
        XCTAssertTrue(attributeB =~ attributeA)
        XCTAssertTrue(attributeA =~ attributeC)
    }
    
    func testThatWidthDoesNotConflictWithHeight() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
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
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(>=10).to(viewB).with(.CustomPriority(23))
        let attributeB = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23))
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameConstantAreEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = Left(>=11).to(viewB).with(.CustomPriority(23))
        let attributeB = Left(>=11).to(viewB).with(.CustomPriority(23))
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentModifierAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23))
        let attributeB = viewA <- Left(11).to(viewB).with(.CustomPriority(23))
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithDifferentConditionEvaluationAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23)).when { true }
        let attributeB = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameConditionEvaluationAreEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        // when
        let attributeA = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- Left(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButAppliedToDifferentViewsAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = Left(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        let attributeB = Left(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewB <- attributeB
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceViewAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = Left(>=11).to(viewB).with(.CustomPriority(23)).when { false }
        let attributeB = Left(>=11).to(viewC).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceAttributesAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = Left(>=11).to(viewB, .Right).with(.CustomPriority(23)).when { false }
        let attributeB = Left(>=11).to(viewB, .Left).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameCustomReferenceAttributesAreEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- Left(>=11).to(viewB, .Leading).with(.CustomPriority(23)).when { false }
        let attributeB = viewA <- Left(>=11).to(viewB, .Leading).with(.CustomPriority(23)).when { false }
        
        // then
        XCTAssertTrue(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentPrioritiesAreNotEqual() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = Left(>=11).to(viewB, .Leading).with(.LowPriority).when { false }
        let attributeB = Left(>=11).to(viewB, .Leading).with(.CustomPriority(23)).when { false }
        
        viewA <- attributeA
        viewA <- attributeB
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesButWithDifferentReferenceViewsAreNotEqualWhenUsingLikeReferer() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
        superview.addSubview(viewC)
        
        // when
        let attributeA = viewA <- Width().like(viewC)
        let attributeB = viewA <- Width().like(viewB)
        
        // then
        XCTAssertFalse(attributeA == attributeB)
    }
    
    func testThatSameAttributesWithSameReferenceViewsAreEqualWhenUsingLikeReferer() {
        // given
        let superview = NSView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = NSView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = NSView(frame: CGRectZero)
        superview.addSubview(viewB)
        let viewC = NSView(frame: CGRectZero)
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
