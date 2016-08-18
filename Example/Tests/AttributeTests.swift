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
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        let attribute = Width(120)
        
        viewA <- attribute
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === attribute)
        XCTAssertTrue(viewA.constraints.count - numberOfPreviousConstraints == 1)
    }
    
    func testThatAttributeIsInstalledWhenItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        let attribute = Top(120)
        viewA <- attribute
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === attribute)
        XCTAssertTrue(superview.constraints.count - numberOfPreviousConstraints == 1)
    }
    
    func testThatAttributeWithFalseConditionIsNotInstalledButAttributeStored() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        viewA <- Width(120).when { false }
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatAttributeWithFalseConditionIsNotInstalledButAttributeStoredAndItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        viewA <- Top(120).when { false }
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttribute() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        let attribute = Width(120)
        viewA <- attribute
        
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === attribute)
    
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        let newAttribute = Width(500)
        viewA <- newAttribute
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === newAttribute)
        XCTAssertTrue(numberOfPreviousConstraints > 0)
        XCTAssertTrue(viewA.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttributeAndItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        let attribute = Top(120)
        viewA <- attribute
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === attribute)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        let newAttribute = Top(500)
        viewA <- newAttribute
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 1)
        XCTAssertTrue(viewA.test_attributes.first! === newAttribute)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatInstallationOfAttributesDoesntAffectToAttributesAlreadyInstalledForADifferentView() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRect.zero)
        superview.addSubview(viewB)
        viewB <- [
            Top(20).to(superview),
            Left(0).to(superview),
            Width(120),
            Height(120)
        ]
        XCTAssertTrue(viewB.test_attributes.count == 4)
        
        // when
        viewA <- [
            Top(20).to(superview),
            Left(0).to(superview),
            Width(120),
            Height(120)
        ]
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 4)
        
        // And also test that recreating those attributes doesn't break anything
        
        // when
        viewA <- [
            Top(200).to(viewB, .top),
            Left(20).to(superview),
            Width(220),
            Height(220)
        ]
        
        // then
        XCTAssertTrue(viewA.test_attributes.count == 4)
    }
    
    func testThatAttributesAppliedToViewWithNoSuperviewDoesNotAssert() {
        // given
        let viewA = UIView(frame: CGRect.zero)
        
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
        attributes.with(.customPriority(233.0))
        
        // then
        for attribute in attributes {
            switch attribute.priority {
            case let .customPriority(value):
                XCTAssertTrue(value == 233.0)
            default:
                break
            }
        }
    }
    
    @available (iOS 9.0, *)
    func testThatPositionRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Left(10).to(layoutGuide, .left)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .left)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].secondAttribute == .left)
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    @available (iOS 9.0, *)
    func testThatSizeRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Width(0).like(layoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .width)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].constant == 0)
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    @available (iOS 9.0, *)
    func testThatCompoundSizeRelationshipWithLayoutGuideIsEstablished() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let view = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addSubview(view)
        superview.addLayoutGuide(layoutGuide)
        layoutGuide <- Edges(0)
        
        // when
        let constraints = view <- Size(0).like(layoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .width)
        XCTAssertTrue(constraints[0].secondItem === layoutGuide)
        XCTAssertTrue(constraints[0].constant == 0)
        XCTAssertTrue(constraints[1].firstItem === view)
        XCTAssertTrue(constraints[1].firstAttribute == .height)
        XCTAssertTrue(constraints[1].secondItem === layoutGuide)
        XCTAssertTrue(constraints[1].constant == 0)
        XCTAssertTrue(superview.constraints.count == 6)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[0] }).count == 1)
        XCTAssertTrue((superview.constraints.filter { $0 === constraints[1] }).count == 1)
    }
    
    func testThatPositionRelationshipWithControllersTopLayoutGuideIsEstablished() {
        // given
        let controller = UIViewController()
        let view = UIView(frame: CGRect.zero)
        controller.view.addSubview(view)
        
        // when
        let constraints = view <- Top(10).to(controller.topLayoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .top)
        XCTAssertTrue(constraints[0].secondItem === controller.topLayoutGuide)
        XCTAssertTrue(constraints[0].secondAttribute == .bottom)
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(controller.view.constraints.count == 3)
        XCTAssertTrue((controller.view.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    func testThatPositionRelationshipWithControllersBottomLayoutGuideIsEstablished() {
        // given
        let controller = UIViewController()
        let view = UIView(frame: CGRect.zero)
        controller.view.addSubview(view)
        
        // when
        let constraints = view <- Bottom(20).to(controller.bottomLayoutGuide)
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertTrue(constraints[0].firstItem === view)
        XCTAssertTrue(constraints[0].firstAttribute == .bottom)
        XCTAssertTrue(constraints[0].secondItem === controller.bottomLayoutGuide)
        XCTAssertTrue(constraints[0].secondAttribute == .top)
        XCTAssertTrue(constraints[0].constant == -20)
        XCTAssertTrue(controller.view.constraints.count == 3)
        XCTAssertTrue((controller.view.constraints.filter { $0 === constraints[0] }).count == 1)
    }
    
    func testThatAGoodBunchOfAttributesHaveTheExpectedSignature() {
        // given
        let a: Attribute = Width(>=10).with(.customPriority(300))
        let b: Attribute = Height(100)
        let c: Attribute = Left(<=40).with(.lowPriority)
        let d: Attribute = CenterXWithinMargins().with(.mediumPriority)
        let e: Attribute = LastBaseline(>=30)
        let f: Attribute = BottomMargin()
        let g: Attribute = CenterYWithinMargins(<=40)
        let h: Attribute = CenterX(>=0).with(.customPriority(244))
        
        // when
        // then
        XCTAssertTrue(a.signature == "h_gt_300.0")
        XCTAssertTrue(b.signature == "v_eq_1000.0")
        XCTAssertTrue(c.signature == "h_lt_1.0")
        XCTAssertTrue(d.signature == "h_eq_500.0")
        XCTAssertTrue(e.signature == "v_gt_1000.0")
        XCTAssertTrue(f.signature == "v_eq_1000.0")
        XCTAssertTrue(g.signature == "v_lt_1000.0")
        XCTAssertTrue(h.signature == "h_gt_244.0")
    }
    
}
