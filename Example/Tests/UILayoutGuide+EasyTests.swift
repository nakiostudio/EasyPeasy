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

    var aFlag: Bool = false
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.aFlag = false
        super.tearDown()
    }

    func testThatPositionAttributeIsAppliedToLayoutGuide() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide.easy.layout(CenterX(10))
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.isActive)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem === superview)
        XCTAssertTrue(constraints.first!.relation == .equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .centerX)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
    }
    
    func testThatDimensionAttributeIsAppliedToLayoutGuide() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        
        // when
        let constraints = layoutGuide.easy.layout(Width(10))
        
        // then
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.isActive)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem == nil)
        XCTAssertTrue(constraints.first!.relation == .equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
    }
    
    func testThatPositionConflictIsResolved() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        let constraints = layoutGuide.easy.layout(Left(10))
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.isActive)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem === superview)
        XCTAssertTrue(constraints.first!.relation == .equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .left)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
        
        // when
        let newConstraints = layoutGuide.easy.layout(CenterX(10))
        
        // then
        XCTAssertTrue(newConstraints.count == 1)
        XCTAssertNotNil(newConstraints.first)
        XCTAssertTrue(newConstraints.first!.isActive)
        XCTAssertTrue(newConstraints.first!.constant == 10)
        XCTAssertTrue(newConstraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(newConstraints.first!.secondItem === superview)
        XCTAssertTrue(newConstraints.first!.relation == .equal)
        XCTAssertTrue(newConstraints.first!.firstAttribute == .centerX)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === newConstraints.first)
    }
    
    func testThatWidthConflictIsResolved() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        let constraints = layoutGuide.easy.layout(Width(10))
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.isActive)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem == nil)
        XCTAssertTrue(constraints.first!.relation == .equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
        
        // when
        let newConstraints = layoutGuide.easy.layout(Width(100))
        
        // then
        XCTAssertTrue(newConstraints.count == 1)
        XCTAssertNotNil(newConstraints.first)
        XCTAssertTrue(newConstraints.first!.isActive)
        XCTAssertTrue(newConstraints.first!.constant == 100)
        XCTAssertTrue(newConstraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(newConstraints.first!.secondItem == nil)
        XCTAssertTrue(newConstraints.first!.relation == .equal)
        XCTAssertTrue(newConstraints.first!.firstAttribute == .width)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === newConstraints.first)
    }
    
    func testThatEasyClearClearsTheAttributesAppliedToTheGuide() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        layoutGuide.easy.layout(
            Top(20),
            Width(<=200),
            Bottom(20),
            Left(10).with(.low),
            Right(10).with(.low)
        )
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue(layoutGuide.test_attributes.count == 5)
        XCTAssertTrue(superview.test_attributes.count == 0)
        
        // when
        layoutGuide.easy.clear()

        // then
        XCTAssertTrue(superview.constraints.count == 0)
        XCTAssertTrue(layoutGuide.test_attributes.count == 0)
        XCTAssertTrue(superview.test_attributes.count == 0)
    }
    
    func testThatEasyReloadTogglesPositionAttributesDependingOnCondition() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        layoutGuide.easy.layout(
            Left(10).with(.low).when { [weak self] in return (self!.aFlag) },
            Left(100).with(.low).when { [weak self] in return !(self!.aFlag) }
        )
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(layoutGuide.test_activeAttributes.count == 1)
        XCTAssertTrue(layoutGuide.test_inactiveAttributes.count == 1)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(superview.constraints[0].constant == 100)
        
        // when
        self.aFlag = true
        layoutGuide.easy.reload()
        
        // then
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(layoutGuide.test_activeAttributes.count == 1)
        XCTAssertTrue(layoutGuide.test_inactiveAttributes.count == 1)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(superview.constraints.first?.constant == 10)
    }
    
    func testThatEasyReloadTogglesDimensionAttributesDependingOnCondition() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        layoutGuide.easy.layout(
            Width(10).when { [weak self] in return (self!.aFlag) },
            Width(100).when { [weak self] in return !(self!.aFlag) }
        )
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(layoutGuide.test_activeAttributes.count == 1)
        XCTAssertTrue(layoutGuide.test_inactiveAttributes.count == 1)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(layoutGuide.constraints[0].constant == 100)
        
        // when
        self.aFlag = true
        layoutGuide.easy.reload()
        
        // then
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(layoutGuide.constraints[0].constant == 10)
    }

    // MARK: - Deprecated
    
    func testThatEasyClearClearsTheAttributesAppliedToTheGuideDeprecated() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        layoutGuide.easy.layout(
            Top(20),
            Width(<=200),
            Bottom(20),
            Left(10).with(.low),
            Right(10).with(.low)
        )
        XCTAssertTrue(superview.constraints.count == 5)
        XCTAssertTrue(layoutGuide.test_attributes.count == 5)
        XCTAssertTrue(superview.test_attributes.count == 0)
        
        // when
        layoutGuide.easy.clear()
        
        // then
        XCTAssertTrue(superview.constraints.count == 0)
        XCTAssertTrue(layoutGuide.test_attributes.count == 0)
        XCTAssertTrue(superview.test_attributes.count == 0)
    }

    func testThatPositionConflictIsResolvedDeprecated() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        let constraints = layoutGuide.easy.layout(Left(10))
        XCTAssertTrue(constraints.count == 1)
        XCTAssertNotNil(constraints.first)
        XCTAssertTrue(constraints.first!.isActive)
        XCTAssertTrue(constraints.first!.constant == 10)
        XCTAssertTrue(constraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(constraints.first!.secondItem === superview)
        XCTAssertTrue(constraints.first!.relation == .equal)
        XCTAssertTrue(constraints.first!.firstAttribute == .left)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === constraints.first)
        
        // when
        let newConstraints = layoutGuide.easy.layout(CenterX(10))
        
        // then
        XCTAssertTrue(newConstraints.count == 1)
        XCTAssertNotNil(newConstraints.first)
        XCTAssertTrue(newConstraints.first!.isActive)
        XCTAssertTrue(newConstraints.first!.constant == 10)
        XCTAssertTrue(newConstraints.first!.firstItem === layoutGuide)
        XCTAssertTrue(newConstraints.first!.secondItem === superview)
        XCTAssertTrue(newConstraints.first!.relation == .equal)
        XCTAssertTrue(newConstraints.first!.firstAttribute == .centerX)
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(superview.constraints.first === newConstraints.first)
    }
    
    func testThatEasyReloadTogglesDimensionAttributesDependingOnConditionDeprecated() {
        // given
        let superview = UIView(frame: CGRect.zero)
        let layoutGuide = UILayoutGuide()
        superview.addLayoutGuide(layoutGuide)
        layoutGuide.easy.layout(
            Width(10).when { [weak self] in return (self!.aFlag) },
            Width(100).when { [weak self] in return !(self!.aFlag) }
        )
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(layoutGuide.test_activeAttributes.count == 1)
        XCTAssertTrue(layoutGuide.test_inactiveAttributes.count == 1)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(layoutGuide.constraints[0].constant == 100)
        
        // when
        self.aFlag = true
        layoutGuide.easy.reload()
        
        // then
        XCTAssertTrue(superview.constraints.count == 1)
        XCTAssertTrue(layoutGuide.constraints.count == 1)
        XCTAssertTrue(layoutGuide.test_attributes.count == 2)
        XCTAssertTrue(superview.test_attributes.count == 0)
        XCTAssertTrue(layoutGuide.constraints[0].constant == 10)
    }
    
}
