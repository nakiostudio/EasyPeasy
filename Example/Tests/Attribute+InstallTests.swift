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

class Attribute_InstallTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatAttributeIsInstalled() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        let attribute = Width(120)
        
        viewA <- attribute
        
        // then
        XCTAssertTrue(viewA.attributes.count == 1)
        XCTAssertTrue(viewA.attributes.first! === attribute)
        XCTAssertTrue(viewA.constraints.count - numberOfPreviousConstraints == 1)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attribute)
        for constraint in viewA.constraints {
            XCTAssertNotNil(constraint.easy_attribute)
        }
    }
    
    func testThatAttributeIsInstalledWhenItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        let attribute = Top(120)
        viewA <- attribute
        
        // then
        XCTAssertTrue(superview.attributes.count == 1)
        XCTAssertTrue(superview.attributes.first! === attribute)
        XCTAssertTrue(superview.constraints.count - numberOfPreviousConstraints == 1)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attribute)
    }
    
    func testThatAttributeWithFalseConditionIsNotInstalledButAttributeStored() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        viewA <- Width(120).when { false }
        
        // then
        XCTAssertTrue(viewA.attributes.count == 1)
        XCTAssertTrue(viewA.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatAttributeWithFalseConditionIsNotInstalledButAttributeStoredAndItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        viewA <- Top(120).when { false }
        
        // then
        XCTAssertTrue(superview.attributes.count == 1)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttribute() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let attribute = Width(120)
        viewA <- attribute
        
        XCTAssertTrue(viewA.attributes.count == 1)
        XCTAssertTrue(viewA.attributes.first! === attribute)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attribute)
    
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        let newAttribute = Width(500)
        viewA <- newAttribute
        
        // then
        XCTAssertTrue(viewA.attributes.count == 1)
        XCTAssertTrue(viewA.attributes.first! === newAttribute)
        XCTAssertTrue(numberOfPreviousConstraints > 0)
        XCTAssertTrue(viewA.constraints.count == numberOfPreviousConstraints)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === newAttribute)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttributeAndItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let attribute = Top(120)
        viewA <- attribute
        XCTAssertTrue(superview.attributes.count == 1)
        XCTAssertTrue(superview.attributes.first! === attribute)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attribute)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        let newAttribute = Top(500)
        viewA <- newAttribute
        
        // then
        XCTAssertTrue(superview.attributes.count == 1)
        XCTAssertTrue(superview.attributes.first! === newAttribute)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === newAttribute)
    }
    
    func testThatInstallationOfAttributesDoesntAffectToAttributesAlreadyInstalledForADifferentView() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        viewB <- [
            Top(20).to(superview),
            Left(0).to(superview),
            Width(120),
            Height(120)
        ]
        XCTAssertTrue(superview.attributes.count == 2)
        XCTAssertTrue(viewB.attributes.count == 2)
        
        // when
        viewA <- [
            Top(20).to(superview),
            Left(0).to(superview),
            Width(120),
            Height(120)
        ]
        
        // then
        XCTAssertTrue(superview.attributes.count == 4)
        XCTAssertTrue(viewA.attributes.count == 2)
        
        // And also test that recreating those attributes doesn't break anything
        
        // when
        viewA <- [
            Top(200).to(viewB, .Top),
            Left(20).to(superview),
            Width(220),
            Height(220)
        ]
        
        // then
        XCTAssertTrue(superview.attributes.count == 4)
        XCTAssertTrue(viewA.attributes.count == 2)
    }
    
    func testThatAttributesAppliedToViewWithNoSuperviewDoesNotAssert() {
        // given
        let viewA = UIView(frame: CGRectZero)
        
        // when
        viewA <- Width(120)
        
        // then
        XCTAssertTrue(true)
    }
    
    func testThatConditionsAreSetToAnArrayOfAttributes() {
        // given
        let attributes = [Width(200), Height(500), Center(0)]
        
        // when
        attributes.when { false }
        
        // then
        for attribute in attributes {
            XCTAssertFalse(attribute.condition!())
        }
    }
    
    func testThatPrioritiesAreSetToAnArrayOfAttributes() {
        // given
        let attributes = [Width(200), Height(500), Center(0)]
        
        // when
        attributes.with(.CustomPriority(233.0))
        
        // then
        for attribute in attributes {
            switch attribute.priority {
            case let .CustomPriority(value):
                XCTAssertTrue(value == 233.0)
            default:
                break
            }
        }
    }
    
    @available (iOS 9.0, *)
    func testThatPositionRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let view = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Left(10).to(layoutGuide, .Left)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .Left)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].secondAttribute == .Left)
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    @available (iOS 9.0, *)
    func testThatSizeRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let view = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Width(0).like(layoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .Width)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].constant == 0)
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    @available (iOS 9.0, *)
    func testThatCompoundSizeRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let view = UIView(frame: CGRectZero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Size(0).like(layoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .Width)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].constant == 0)
        XCTAssertTrue(constraints[1].firstItem === view)
        XCTAssertTrue(constraints[1].firstAttribute == .Height)
        XCTAssertTrue(constraints[1].secondItem === layoutGuide)
        XCTAssertTrue(constraints[1].constant == 0)
        XCTAssertTrue(superview.constraints.count == 6)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[1] }).count == 1)
    }
    
}
