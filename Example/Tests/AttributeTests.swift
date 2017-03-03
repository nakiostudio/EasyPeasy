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
            XCTAssertFalse((attribute.condition! as! Condition)())
        }
    }
    
    func testThatPrioritiesAreSetToAnArrayOfAttributes() {
        // given
        let attributes = [Width(200), Height(500), Center(0)]
        
        // when
        attributes.with(.custom(233.0))
        
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
        let a: Attribute = Width(>=10).with(.custom(300))
        let b: Attribute = Height(100)
        let c: Attribute = Left(<=40).with(.low)
        let d: Attribute = CenterXWithinMargins().with(.medium)
        let e: Attribute = LastBaseline(>=30)
        let f: Attribute = BottomMargin()
        let g: Attribute = CenterYWithinMargins(<=40)
        let h: Attribute = CenterX(>=0).with(.custom(244))
        
        // when
        // then
        XCTAssertTrue(a.signature == "h_gt_300.0")
        XCTAssertTrue(b.signature == "v_eq_1000.0")
        XCTAssertTrue(c.signature == "h_lt_250.0")
        XCTAssertTrue(d.signature == "h_eq_500.0")
        XCTAssertTrue(e.signature == "v_gt_1000.0")
        XCTAssertTrue(f.signature == "v_eq_1000.0")
        XCTAssertTrue(g.signature == "v_lt_1000.0")
        XCTAssertTrue(h.signature == "h_gt_244.0")
    }

    func testThatAttributeWithFalseContextualConditionIsNotInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- Width(120).when { $0.isPhone }
        }
        else {
            viewA <- Width(120).when { $0.isPad }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.test_attributes.count == 1)
    }
    
    func testThatAttributeWithTrueContextualConditionIsInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- Width(120).when { $0.isPad }
        }
        else {
            viewA <- Width(120).when { $0.isPhone }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 1)
        XCTAssertTrue(viewA.test_attributes.count == 1)
    }
    
    func testThatArrayOfAttributesWithFalseContextualConditionIsNotInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- [
                Width(120), Height(120)
            ].when { $0.isPhone }
        }
        else {
            viewA <- [
                Width(120), Height(120)
            ].when { $0.isPad }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.test_attributes.count == 2)
    }
    
    func testThatArrayOfAttributesWithTrueContextualConditionIsInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- [
                Width(120), Height(120)
            ].when { $0.isPad }
        }
        else {
            viewA <- [
                Width(120), Height(120)
            ].when { $0.isPhone }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.test_attributes.count == 2)
    }
    
    func testThatConstraintIsCreatedForWidthAttributeNotInTheViewHierarchy() {
        // given
        let attribute = Width(20)
        let view = UIView()
        
        // when
        let constraints = attribute.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraints.count == 1)
    }
    
    func testThatConstraintIsCreatedForWidthAttributeInTheViewHierarchy() {
        // given
        let attribute = Width(20)
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let constraints = attribute.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraints.count == 1)
    }
    
    func testThatConstraintIsCreatedForHeightAttributeNotInTheViewHierarchy() {
        // given
        let attribute = Height(20)
        let view = UIView()
        
        // when
        let constraints = attribute.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraints.count == 1)
    }
    
    func testThatConstraintIsCreatedForHeightAttributeInTheViewHierarchy() {
        // given
        let attribute = Height(20)
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let constraints = attribute.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraints.count == 1)
    }
    
    func testThatConstraintAreNotCreatedForSomePositionAttributesNotInTheViewHierarchy() {
        // given
        let attributeA = Top(20)
        let attributeB = Left(20)
        let attributeC = Right(20)
        let attributeD = Bottom(20)
        let attributeE = CenterX(20)
        let attributeF = CenterY(20)
        let attributeG = Leading(20)
        let attributeH = Trailing(20)
        let attributeI = CenterXWithinMargins(20)
        let attributeJ = CenterYWithinMargins(20)
        let attributeK = LeftMargin(20)
        let attributeL = RightMargin(20)
        let attributeM = TopMargin(20)
        let attributeN = BottomMargin(20)
        let view = UIView()
        
        // when
        let constraintsA = attributeA.createConstraints(for: view)
        let constraintsB = attributeB.createConstraints(for: view)
        let constraintsC = attributeC.createConstraints(for: view)
        let constraintsD = attributeD.createConstraints(for: view)
        let constraintsE = attributeE.createConstraints(for: view)
        let constraintsF = attributeF.createConstraints(for: view)
        let constraintsG = attributeG.createConstraints(for: view)
        let constraintsH = attributeH.createConstraints(for: view)
        let constraintsI = attributeI.createConstraints(for: view)
        let constraintsJ = attributeJ.createConstraints(for: view)
        let constraintsK = attributeK.createConstraints(for: view)
        let constraintsL = attributeL.createConstraints(for: view)
        let constraintsM = attributeM.createConstraints(for: view)
        let constraintsN = attributeN.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraintsA.count == 0)
        XCTAssertTrue(constraintsB.count == 0)
        XCTAssertTrue(constraintsC.count == 0)
        XCTAssertTrue(constraintsD.count == 0)
        XCTAssertTrue(constraintsE.count == 0)
        XCTAssertTrue(constraintsF.count == 0)
        XCTAssertTrue(constraintsG.count == 0)
        XCTAssertTrue(constraintsH.count == 0)
        XCTAssertTrue(constraintsI.count == 0)
        XCTAssertTrue(constraintsJ.count == 0)
        XCTAssertTrue(constraintsK.count == 0)
        XCTAssertTrue(constraintsL.count == 0)
        XCTAssertTrue(constraintsM.count == 0)
        XCTAssertTrue(constraintsN.count == 0)
    }
    
    func testThatConstrainAreCreatedForSomePositionAttributesNotInTheViewHierarchy() {
        // given
        let attributeA = Top(20)
        let attributeB = Left(20)
        let attributeC = Right(20)
        let attributeD = Bottom(20)
        let attributeE = CenterX(20)
        let attributeF = CenterY(20)
        let attributeG = Leading(20)
        let attributeH = Trailing(20)
        let attributeI = CenterXWithinMargins(20)
        let attributeJ = CenterYWithinMargins(20)
        let attributeK = LeftMargin(20)
        let attributeL = RightMargin(20)
        let attributeM = TopMargin(20)
        let attributeN = BottomMargin(20)
        let view = UIView()
        let superview = UIView()
        superview.addSubview(view)
        
        // when
        let constraintsA = attributeA.createConstraints(for: view)
        let constraintsB = attributeB.createConstraints(for: view)
        let constraintsC = attributeC.createConstraints(for: view)
        let constraintsD = attributeD.createConstraints(for: view)
        let constraintsE = attributeE.createConstraints(for: view)
        let constraintsF = attributeF.createConstraints(for: view)
        let constraintsG = attributeG.createConstraints(for: view)
        let constraintsH = attributeH.createConstraints(for: view)
        let constraintsI = attributeI.createConstraints(for: view)
        let constraintsJ = attributeJ.createConstraints(for: view)
        let constraintsK = attributeK.createConstraints(for: view)
        let constraintsL = attributeL.createConstraints(for: view)
        let constraintsM = attributeM.createConstraints(for: view)
        let constraintsN = attributeN.createConstraints(for: view)
        
        // then
        XCTAssertTrue(constraintsA.count == 1)
        XCTAssertTrue(constraintsB.count == 1)
        XCTAssertTrue(constraintsC.count == 1)
        XCTAssertTrue(constraintsD.count == 1)
        XCTAssertTrue(constraintsE.count == 1)
        XCTAssertTrue(constraintsF.count == 1)
        XCTAssertTrue(constraintsG.count == 1)
        XCTAssertTrue(constraintsH.count == 1)
        XCTAssertTrue(constraintsI.count == 1)
        XCTAssertTrue(constraintsJ.count == 1)
        XCTAssertTrue(constraintsK.count == 1)
        XCTAssertTrue(constraintsL.count == 1)
        XCTAssertTrue(constraintsM.count == 1)
        XCTAssertTrue(constraintsN.count == 1)
    }
    
}
