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
        let sizeAttribute = Size(CGSize(width: 100, height: 100)).with(.LowPriority)
        
        // then
        for subAttribute in sizeAttribute.attributes {
            XCTAssertTrue(subAttribute.priority.layoutPriority() == Priority.LowPriority.layoutPriority())
        }
    }
    
    func testThatConditionAffectsEverySubAttributeOfCompoundAttribute() {
        // given
        // when
        let sizeAttribute = Size(CGSize(width: 100, height: 100)).when { false }
        
        // then
        for subAttribute in sizeAttribute.attributes {
            XCTAssertFalse(subAttribute.condition!())
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
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(50)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(>=50)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .GreaterThanOrEqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatSizeAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(*2)
        
        // then
        for attribute in sizeAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.modifier == .MultipliedBy)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 2.0)
        }
    }
    
    func testThatSizeAttributeInitWithSizeParamSetsTheExpectedConstants() {
        // given
        // when
        let sizeAttribute = Size(CGSize(width: 120, height: 200))
        
        // then
        XCTAssertTrue(sizeAttribute.attributes[0].constant.value == 120.0)
        XCTAssertTrue(sizeAttribute.attributes[0].constant.modifier == .EqualTo)
        XCTAssertTrue(sizeAttribute.attributes[0].constant.layoutMultiplier() == 1.0)
        
        XCTAssertTrue(sizeAttribute.attributes[1].constant.value == 200.0)
        XCTAssertTrue(sizeAttribute.attributes[1].constant.modifier == .EqualTo)
        XCTAssertTrue(sizeAttribute.attributes[1].constant.layoutMultiplier() == 1.0)
    }
    
    func testThatLikeMethodSetsTheReferenceViewToEachOneOfTheSubAttributes() {
        // given
        let referenceView = NSView(frame: CGRectZero)
        
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
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(50)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(>=50)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .GreaterThanOrEqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatEdgesAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(*2)
        
        // then
        for attribute in edgesAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.modifier == .MultipliedBy)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 2.0)
        }
    }
    
    func testThatEdgesAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let edgesAttribute = Edges(NSEdgeInsets(top: 100, left: 20, bottom: 50, right: 10))
        
        // then
        XCTAssertTrue(edgesAttribute.attributes[0].constant.value == 100.0)
        XCTAssertTrue(edgesAttribute.attributes[0].constant.modifier == .EqualTo)
        XCTAssertTrue(edgesAttribute.attributes[0].constant.layoutMultiplier() == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[1].constant.value == 20.0)
        XCTAssertTrue(edgesAttribute.attributes[1].constant.modifier == .EqualTo)
        XCTAssertTrue(edgesAttribute.attributes[1].constant.layoutMultiplier() == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[2].constant.value == 10.0)
        XCTAssertTrue(edgesAttribute.attributes[2].constant.modifier == .EqualTo)
        XCTAssertTrue(edgesAttribute.attributes[2].constant.layoutMultiplier() == 1.0)
        
        XCTAssertTrue(edgesAttribute.attributes[3].constant.value == 50.0)
        XCTAssertTrue(edgesAttribute.attributes[3].constant.modifier == .EqualTo)
        XCTAssertTrue(edgesAttribute.attributes[3].constant.layoutMultiplier() == 1.0)
    }
    
    func testThatCenterAttributeInitWithNoParamsSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center()
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 0.0)
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithSingleDoubleParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(50)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .EqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithSingleConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(>=50)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 50)
            XCTAssertTrue(attribute.constant.modifier == .GreaterThanOrEqualTo)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 1.0)
        }
    }
    
    func testThatCenterAttributeInitWithMultiplierConstantParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(*2)
        
        // then
        for attribute in centerAttribute.attributes {
            XCTAssertTrue(attribute.constant.value == 2.0)
            XCTAssertTrue(attribute.constant.modifier == .MultipliedBy)
            XCTAssertTrue(attribute.constant.layoutMultiplier() == 2.0)
        }
    }
    
    func testThatCenterAttributeInitWithUIEdgeInsertsParamSetsTheExpectedConstants() {
        // given
        // when
        let centerAttribute = Center(CGPoint(x: 210, y: 430))
        
        // then
        XCTAssertTrue(centerAttribute.attributes[0].constant.value == 210.0)
        XCTAssertTrue(centerAttribute.attributes[0].constant.modifier == .EqualTo)
        XCTAssertTrue(centerAttribute.attributes[0].constant.layoutMultiplier() == 1.0)
        
        XCTAssertTrue(centerAttribute.attributes[1].constant.value == 430.0)
        XCTAssertTrue(centerAttribute.attributes[1].constant.modifier == .EqualTo)
        XCTAssertTrue(centerAttribute.attributes[1].constant.layoutMultiplier() == 1.0)
    }
    
}
