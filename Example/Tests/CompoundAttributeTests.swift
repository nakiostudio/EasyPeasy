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

class CompoundAttributeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testThatPriorityAffectsEverySubAttributeOfCompoundAttribute() {
        // given
        // when
        let sizeAttribute = Size(CGSize(width: 100, height: 100)).with(.low)
        
        // then
        for subAttribute in sizeAttribute.attributes {
            XCTAssertTrue(subAttribute.priority.layoutPriority() == Priority.low.layoutPriority())
        }
    }
    
    func testThatConditionAffectsEverySubAttributeOfCompoundAttribute() {
        // given
        // when
        let sizeAttribute = Size(CGSize(width: 100, height: 100)).when { false }
        
        // then
        for subAttribute in sizeAttribute.attributes {
            XCTAssertFalse((subAttribute.condition! as! Condition)())
        }
    }
    
    // MARK: Dimension CompoundAttributes
    
    func testThatSizeAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size()
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(50)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(>=50)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .greaterThanOrEqual)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(*2)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 2.0)
        }
    }
    
    func testThatSizeAttributeInitWithSizeParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(CGSize(width: 120, height: 200))
        
        // then
        XCTAssertTrue(sizeAttribute.attributes[0].constant.value == 120.0)
        XCTAssertTrue(sizeAttribute.attributes[0].constant.relation == .equal)
        XCTAssertTrue(sizeAttribute.attributes[0].constant.multiplier == 1.0)
        
        XCTAssertTrue(sizeAttribute.attributes[1].constant.value == 200.0)
        XCTAssertTrue(sizeAttribute.attributes[1].constant.relation == .equal)
        XCTAssertTrue(sizeAttribute.attributes[1].constant.multiplier == 1.0)
    }
    
    func testThatLikeMethodSetsTheReferenceViewToEachOneOfTheSubAttributes() {
        // given
        let referenceView = UIView(frame: CGRect.zero)
        
        // when
        let sizeAttribute = Size(100).like(referenceView)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.referenceItem === referenceView)
        }
    }
    
    // MARK: Position CompoundAttributes
    
    func testThatEdgesAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges()
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(50)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(>=50)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .greaterThanOrEqual)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(*2)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 2.0)
        }
    }
    
    func testThatEdgesAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(UIEdgeInsets(top: 100, left: 20, bottom: 50, right: 10))
        
        // then
        XCTAssertTrue(edgesAttribute.attributes[0].constant.value == 100.0)
        XCTAssertTrue(edgesAttribute.attributes[0].constant.relation == .equal)
        XCTAssertTrue(edgesAttribute.attributes[0].constant.multiplier == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[1].constant.value == 20.0)
        XCTAssertTrue(edgesAttribute.attributes[1].constant.relation == .equal)
        XCTAssertTrue(edgesAttribute.attributes[1].constant.multiplier == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[2].constant.value == 10.0)
        XCTAssertTrue(edgesAttribute.attributes[2].constant.relation == .equal)
        XCTAssertTrue(edgesAttribute.attributes[2].constant.multiplier == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[3].constant.value == 50.0)
        XCTAssertTrue(edgesAttribute.attributes[3].constant.relation == .equal)
        XCTAssertTrue(edgesAttribute.attributes[3].constant.multiplier == 1.0)
    }
    
    func testThatCenterAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center()
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(50)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(>=50)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .greaterThanOrEqual)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(*2)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 2.0)
        }
    }
    
    func testThatCenterAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(CGPoint(x: 210, y: 430))
        
        // then
        XCTAssertTrue(centerAttribute.attributes[0].constant.value == 210.0)
        XCTAssertTrue(centerAttribute.attributes[0].constant.relation == .equal)
        XCTAssertTrue(centerAttribute.attributes[0].constant.multiplier == 1.0)
        
        XCTAssertTrue(centerAttribute.attributes[1].constant.value == 430.0)
        XCTAssertTrue(centerAttribute.attributes[1].constant.relation == .equal)
        XCTAssertTrue(centerAttribute.attributes[1].constant.multiplier == 1.0)
    }
    
    func testThatCenterWithinMarginsAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let centerWithinMarginsAttribute = CenterWithinMargins()
        
        // then
        for attribute in centerWithinMarginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterWithinMarginsAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let centerWithinMarginsAttribute = CenterWithinMargins(50)
        
        // then
        for attribute in centerWithinMarginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterWithinMarginsAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerWithinMarginsAttribute = CenterWithinMargins(>=50)
        
        // then
        for attribute in centerWithinMarginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .greaterThanOrEqual)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatCenterWithinMarginsAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerWithinMarginsAttribute = CenterWithinMargins(*2)
        
        // then
        for attribute in centerWithinMarginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 2.0)
        }
    }
    
    func testThatCenterWithinMarginsAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let centerWithinMarginsAttribute = CenterWithinMargins(CGPoint(x: 210, y: 430))
        
        // then
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[0].constant.value == 210.0)
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[0].constant.relation == .equal)
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[0].constant.multiplier == 1.0)
        
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[1].constant.value == 430.0)
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[1].constant.relation == .equal)
        XCTAssertTrue(centerWithinMarginsAttribute.attributes[1].constant.multiplier == 1.0)
    }
    
    func testThatMaringsAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let marginsAttribute = Margins()
        
        // then
        for attribute in marginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatMarginsAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let marginsAttribute = Margins(50)
        
        // then
        for attribute in marginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatMarginsAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let marginsAttribute = Margins(>=50)
        
        // then
        for attribute in marginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.relation == .greaterThanOrEqual)
            XCTAssertTrue(attribute.constant.multiplier == 1.0)
        }
    }
    
    func testThatMarginsAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let marginsAttribute = Margins(*2)
        
        // then
        for attribute in marginsAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.relation == .equal)
            XCTAssertTrue(attribute.constant.multiplier == 2.0)
        }
    }
    
    func testThatMarginsAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let marginsAttribute = Margins(UIEdgeInsets(top: 100, left: 20, bottom: 50, right: 10))
        
        // then
        XCTAssertTrue(marginsAttribute.attributes[0].constant.value == 100.0)
        XCTAssertTrue(marginsAttribute.attributes[0].constant.relation == .equal)
        XCTAssertTrue(marginsAttribute.attributes[0].constant.multiplier == 1.0)
        
        XCTAssertTrue(marginsAttribute.attributes[1].constant.value == 20.0)
        XCTAssertTrue(marginsAttribute.attributes[1].constant.relation == .equal)
        XCTAssertTrue(marginsAttribute.attributes[1].constant.multiplier == 1.0)
        
        XCTAssertTrue(marginsAttribute.attributes[2].constant.value == 10.0)
        XCTAssertTrue(marginsAttribute.attributes[2].constant.relation == .equal)
        XCTAssertTrue(marginsAttribute.attributes[2].constant.multiplier == 1.0)
        
        XCTAssertTrue(marginsAttribute.attributes[3].constant.value == 50.0)
        XCTAssertTrue(marginsAttribute.attributes[3].constant.relation == .equal)
        XCTAssertTrue(marginsAttribute.attributes[3].constant.multiplier == 1.0)
    }
    
    func testThatCreateAtrributeIsWidthByDefault() {
        // given
        let attribute = Size()
        
        // when
        // then
        XCTAssertTrue(attribute.createAttribute == .width)
    }
    
    // MARK: Contextual conditions
    
    func testThatAttributesWithFalseContextualConditionIsNotInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- Size(120).when { $0.isPhone }
        }
        else {
            viewA <- Size(120).when { false }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 0)
        XCTAssertTrue(viewA.test_attributes.count == 2)
    }
    
    func testThatAttributesWithTrueContextualConditionIsInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- Size(120).when { $0.isPad }
        }
        else {
            viewA <- Size(120).when { $0.isPhone }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.test_attributes.count == 2)
    }
    
    func testThatArrayOfAttributesWithFalseContextualConditionIsNotInstalled() {
        // given
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        let viewA = UIView(frame: CGRect.zero)
        superview.addSubview(viewA)
        
        // when
        if UI_USER_INTERFACE_IDIOM() == .pad {
            viewA <- [
                Size(120)
            ].when { $0.isPhone }
        }
        else {
            viewA <- [
                Size(120)
            ].when { false }
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
                Size(120)
            ].when { $0.isPad }
        }
        else {
            viewA <- [
                Size(120)
            ].when { $0.isPhone }
        }
        
        // then
        XCTAssertTrue(viewA.constraints.count == 2)
        XCTAssertTrue(viewA.test_attributes.count == 2)
    }

}
