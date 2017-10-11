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

class NodeTests: XCTestCase {
    
    // MARK: Left node

    func testThatLeftSubnodeIsSet() {
        // given
        let node = Node()
        let leftAttribute = Left()
        
        // when
        _ = node.add(attribute: leftAttribute)
        
        // then
        XCTAssertNotNil(node.left)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
    }
    
    func testThatLeftSubnodeIsNotSetIfAttributeConditionIsFalse() {
        // given
        let node = Node()
        let leftAttribute = Left().when { false }
        
        // when
        _ = node.add(attribute: leftAttribute)
        
        // then
        XCTAssertNil(node.left)
        XCTAssertTrue(node.activeAttributes.count == 0)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertNil(node.center)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
    }
    
    func testThatLeftSubnodeIsUpdatedWhenReplacedWithAnotherLeft() {
        // given
        let node = Node()
        let leftAttribute = Left()
        let leadingAttribute = Leading()
        _ = node.add(attribute: leftAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.left === leftAttribute)
        
        // when
        _ = node.add(attribute: leadingAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.left === leadingAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
    }
    
    func testThatLeftSubnodeIsUpdatedWhenReplacedWithCenterSubnode() {
        // given
        let node = Node()
        let leftAttribute = Left()
        let centerAttribute = CenterX()
        _ = node.add(attribute: leftAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.left === leftAttribute)
        XCTAssertNil(node.center)
        
        // when
        _ = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerAttribute)
        XCTAssertNil(node.left)
        XCTAssertNil(node.dimension)
        XCTAssertNil(node.right)
    }
    
    func testThatLeftSubnodeIsNotUpdatedWhenOnlyDimensionSubnodeIsApplied() {
        // given
        let node = Node()
        let leftAttribute = Left()
        let dimensionAttribute = Width()
        _ = node.add(attribute: leftAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.left === leftAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.dimension)
        
        // when
        _ = node.add(attribute: dimensionAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === dimensionAttribute)
        XCTAssertNotNil(node.left)
        XCTAssertNotNil(node.dimension)
        XCTAssertNil(node.center)
        XCTAssertNil(node.right)
    }

    func testThatThereIsNotLayoutConstraintToApplyWhenSameLeftAttributeIsAddedTwice() {
        // given
        let node = Node()
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let leftAttribute = Left()
        leftAttribute.createConstraints(for: view)
        let constraints = node.add(attribute: leftAttribute)
        XCTAssertTrue(constraints?.0.count == 1)
        XCTAssertTrue(constraints?.1.count == 0)
        
        // when 
        let newConstraints = node.add(attribute: leftAttribute)
        
        // then
        XCTAssertNil(newConstraints)
    }
    
    // MARK: Right node
    
    func testThatRightSubnodeIsSet() {
        // given
        let node = Node()
        let rightAttribute = Right()
        
        // when
        _ = node.add(attribute: rightAttribute)
        
        // then
        XCTAssertNotNil(node.right)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
    }
    
    func testThatRightSubnodeIsNotSetIfAttributeConditionIsFalse() {
        // given
        let node = Node()
        let rightAttribute = Right().when { false }
        
        // when
        _ = node.add(attribute: rightAttribute)
        
        // then
        XCTAssertNil(node.right)
        XCTAssertTrue(node.activeAttributes.count == 0)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertNil(node.center)
        XCTAssertNil(node.left)
        XCTAssertNil(node.dimension)
    }
    
    func testThatRightSubnodeIsUpdatedWhenReplacedWithAnotherRight() {
        // given
        let node = Node()
        let rightAttribute = Right()
        let trailingAttribute = Trailing()
        _ = node.add(attribute: rightAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.right === rightAttribute)
        
        // when
        _ = node.add(attribute: trailingAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.right === trailingAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.left)
        XCTAssertNil(node.dimension)
    }
    
    func testThatRightSubnodeIsUpdatedWhenReplacedWithCenterSubnode() {
        // given
        let node = Node()
        let rightAttribute = Right()
        let centerAttribute = CenterX()
        _ = node.add(attribute: rightAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertNil(node.center)
        
        // when
        _ = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerAttribute)
        XCTAssertNil(node.left)
        XCTAssertNil(node.dimension)
        XCTAssertNil(node.right)
    }
    
    func testThatRightSubnodeIsNotUpdatedWhenOnlyDimensionSubnodeIsApplied() {
        // given
        let node = Node()
        let rightAttribute = Right()
        let dimensionAttribute = Width()
        _ = node.add(attribute: rightAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.dimension)
        
        // when
        _ = node.add(attribute: dimensionAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === dimensionAttribute)
        XCTAssertNotNil(node.right)
        XCTAssertNotNil(node.dimension)
        XCTAssertNil(node.center)
        XCTAssertNil(node.left)
    }
    
    func testThatThereIsNotLayoutConstraintToApplyWhenSameRightAttributeIsAddedTwice() {
        // given
        let node = Node()
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let rightAttribute = Right()
        rightAttribute.createConstraints(for: view)
        let constraints = node.add(attribute: rightAttribute)
        XCTAssertTrue(constraints?.0.count == 1)
        XCTAssertTrue(constraints?.1.count == 0)
        
        // when
        let newConstraints = node.add(attribute: rightAttribute)
        
        // then
        XCTAssertNil(newConstraints)
    }

    // MARK: Center node
    
    func testThatCenterSubnodeIsSet() {
        // given
        let node = Node()
        let centerAttribute = CenterX()
        
        // when
        _ = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertNotNil(node.center)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
    }
    
    func testThatCenterSubnodeIsNotSetIfAttributeConditionIsFalse() {
        // given
        let node = Node()
        let centerAttribute = CenterX().when { false }
        
        // when
        _ = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertNil(node.center)
        XCTAssertTrue(node.activeAttributes.count == 0)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
    }
    
    func testThatCenterSubnodeIsUpdatedWhenReplacedWithAnotherCenter() {
        // given
        let node = Node()
        let centerAttribute = CenterX()
        let centerXWithinMarginsAttribute = CenterXWithinMargins()
        _ = node.add(attribute: centerAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerAttribute)
        
        // when
        _ = node.add(attribute: centerXWithinMarginsAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerXWithinMarginsAttribute)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
    }
    
    func testThatCenterSubnodeIsUpdatedWhenReplacedWithLeftSubnode() {
        // given
        let node = Node()
        let leftAttribute = FirstBaseline()
        let centerAttribute = CenterY()
        _ = node.add(attribute: centerAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerAttribute)
        XCTAssertNil(node.left)
        
        // when
        _ = node.add(attribute: leftAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.left === leftAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.dimension)
        XCTAssertNil(node.right)
    }
    
    func testThatCenterSubnodeIsNotUpdatedWhenDimensionSubnodeIsApplied() {
        // given
        let node = Node()
        let centerAttribute = CenterX()
        let dimensionAttribute = Width()
        _ = node.add(attribute: centerAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.center === centerAttribute)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
        
        // when
        _ = node.add(attribute: dimensionAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === dimensionAttribute)
        XCTAssertNotNil(node.center)
        XCTAssertNotNil(node.dimension)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
    }
    
    func testThatThereIsNotLayoutConstraintToApplyWhenSameCenterAttributeIsAddedTwice() {
        // given
        let node = Node()
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let centerAttribute = CenterX()
        centerAttribute.createConstraints(for: view)
        let constraints = node.add(attribute: centerAttribute)
        XCTAssertTrue(constraints?.0.count == 1)
        XCTAssertTrue(constraints?.1.count == 0)
        
        // when
        let newConstraints = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertNil(newConstraints)
    }
    
    // MARK: Dimension node
    
    func testThatDimensionSubnodeIsSet() {
        // given
        let node = Node()
        let dimensionAttribute = Width()
        
        // when
        _ = node.add(attribute: dimensionAttribute)
        
        // then
        XCTAssertNotNil(node.dimension)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
    }
    
    func testThatDimensionSubnodeIsNotSetIfAttributeConditionIsFalse() {
        // given
        let node = Node()
        let dimensionAttribute = Width().when { false }
        
        // when
        _ = node.add(attribute: dimensionAttribute)
        
        // then
        XCTAssertNil(node.dimension)
        XCTAssertTrue(node.activeAttributes.count == 0)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertNil(node.center)
        XCTAssertNil(node.right)
        XCTAssertNil(node.left)
    }
    
    func testThatDimensionSubnodeIsUpdatedWhenReplacedWithAnotherDimension() {
        // given
        let node = Node()
        let widthAttributeA = Width()
        let widthAttributeB = Width()
        _ = node.add(attribute: widthAttributeA)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === widthAttributeA)
        
        // when
        _ = node.add(attribute: widthAttributeB)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === widthAttributeB)
        XCTAssertNotNil(node.dimension)
        XCTAssertNil(node.center)
        XCTAssertNil(node.right)
        XCTAssertNil(node.left)
    }
    
    func testThatDimensionSubnodeIsNotUpdatedWhenCenterSubnodeIsApplied() {
        // given
        let node = Node()
        let centerAttribute = CenterXWithinMargins()
        let dimensionAttribute = Width()
        _ = node.add(attribute: dimensionAttribute)
        XCTAssertTrue(node.activeAttributes.count == 1)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === dimensionAttribute)
        XCTAssertNil(node.center)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
        
        // when
        _ = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(node.dimension === dimensionAttribute)
        XCTAssertTrue(node.center === centerAttribute)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
    }
    
    func testThatThereIsNotLayoutConstraintToApplyWhenSameDimensionAttributeIsAddedTwice() {
        // given
        let node = Node()
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let widthAttribute = Width()
        widthAttribute.createConstraints(for: view)
        let constraints = node.add(attribute: widthAttribute)
        XCTAssertTrue(constraints?.0.count == 1)
        XCTAssertTrue(constraints?.1.count == 0)
        
        // when
        let newConstraints = node.add(attribute: widthAttribute)
        
        // then
        XCTAssertNil(newConstraints)
    }
    
    func testThatReloadHandlesCorrectlyEachSubnode() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        var value = true
        let node = Node()
        let leftAttributeA = LeftMargin().when { value }
        leftAttributeA.createConstraints(for: view)
        let leftAttributeB = Left().when { value == false }
        leftAttributeB.createConstraints(for: view)
        let rightAttribute = RightMargin()
        rightAttribute.createConstraints(for: view)
        let activationGroupA = node.add(attribute: leftAttributeA)
        let activationGroupB = node.add(attribute: leftAttributeB)
        let activationGroupC = node.add(attribute: rightAttribute)
        
        let activeAttributes = node.activeAttributes
        let inactiveAttributes = node.inactiveAttributes
        
        XCTAssertTrue(activeAttributes.count == 2)
        XCTAssertTrue(inactiveAttributes.count == 1)
        XCTAssertTrue(node.left === leftAttributeA)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertTrue(inactiveAttributes.first === leftAttributeB)
        XCTAssertNil(node.center)
        XCTAssertTrue(activationGroupA?.0.count == 1)
        XCTAssertTrue(activationGroupA?.1.count == 0)
        XCTAssertNil(activationGroupB)
        XCTAssertTrue(activationGroupC?.0.count == 1)
        XCTAssertTrue(activationGroupC?.1.count == 0)
        
        // when
        value = false
        let reloadActivationGroup = node.reload()
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertTrue(node.left === leftAttributeB)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertTrue(inactiveAttributes.first === leftAttributeB)
        XCTAssertNil(node.center)
        XCTAssertTrue(reloadActivationGroup.0.count == 1)
        XCTAssertTrue(reloadActivationGroup.1.count == 1)
        
        // And again
        
        // when
        value = true
        let reloadActivationGroupB = node.reload()
        
        // then
        XCTAssertTrue(node.activeAttributes.count == 2)
        XCTAssertTrue(node.inactiveAttributes.count == 1)
        XCTAssertTrue(node.left === leftAttributeA)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertTrue(inactiveAttributes.first === leftAttributeB)
        XCTAssertNil(node.center)
        XCTAssertTrue(reloadActivationGroupB.0.count == 1)
        XCTAssertTrue(reloadActivationGroupB.1.count == 1)
    }
    
    func testThatClearMethodRemovesEverySubnodeAndReturnsTheExpectedConstraints() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        let leftAttributeA = TopMargin().when { true }
        leftAttributeA.createConstraints(for: view)
        let leftAttributeB = Top().when { false }
        leftAttributeB.createConstraints(for: view)
        let rightAttribute = LastBaseline()
        rightAttribute.createConstraints(for: view)
        let dimension = Width()
        dimension.createConstraints(for: view)
        let center = CenterXWithinMargins().when { false }
        center.createConstraints(for: view)
        _ = node.add(attribute: leftAttributeA)
        _ = node.add(attribute: leftAttributeB)
        _ = node.add(attribute: rightAttribute)
        _ = node.add(attribute: dimension)
        _ = node.add(attribute: center)
        
        XCTAssertTrue(node.left === leftAttributeA)
        XCTAssertTrue(node.right === rightAttribute)
        XCTAssertTrue(node.dimension === dimension)
        XCTAssertTrue(node.activeAttributes.count == 3)
        XCTAssertTrue(node.inactiveAttributes.count == 2)
        XCTAssertNil(node.center)
        
        // when
        let constraints = node.clear()
        
        // then
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
        XCTAssertNil(node.dimension)
        XCTAssertNil(node.center)
        XCTAssertTrue(node.activeAttributes.count == 0)
        XCTAssertTrue(node.inactiveAttributes.count == 0)
        XCTAssertTrue(constraints.count == 3)
    }
    
    func testThatActivationGroupIsTheExpectedAddingAttributes() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        
        let leftAttributeA = Left(100)
        leftAttributeA.createConstraints(for: view)
        let rightAttributeA = Right(100)
        rightAttributeA.createConstraints(for: view)
        
        let activationGroupLeftA = node.add(attribute: leftAttributeA)
        XCTAssertTrue(activationGroupLeftA!.0.count == 1)
        XCTAssertTrue(activationGroupLeftA!.0.first === leftAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupLeftA!.1.count == 0)
        
        let activationGroupRightA = node.add(attribute: rightAttributeA)
        XCTAssertTrue(activationGroupRightA!.0.count == 1)
        XCTAssertTrue(activationGroupRightA!.0.first === rightAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupRightA!.1.count == 0)
        
        // when
        let centerAttribute = CenterX(0.0)
        centerAttribute.createConstraints(for: view)
        let activationGroupCenter = node.add(attribute: centerAttribute)
        
        // then
        XCTAssertTrue(activationGroupCenter!.0.count == 1)
        XCTAssertTrue(activationGroupCenter!.0.first === centerAttribute.layoutConstraint)
        XCTAssertTrue(activationGroupCenter!.1.count == 2)
        XCTAssertTrue(activationGroupCenter!.1[0] === leftAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupCenter!.1[1] === rightAttributeA.layoutConstraint)
    }
    
    func testThatActivationGroupIsTheExpectedWhenSameAttributeIsAppliedTwice() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        
        let leftAttributeA = Left(100)
        leftAttributeA.createConstraints(for: view)
        
        let activationGroupLeftA = node.add(attribute: leftAttributeA)
        XCTAssertTrue(activationGroupLeftA!.0.count == 1)
        XCTAssertTrue(activationGroupLeftA!.0.first === leftAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupLeftA!.1.count == 0)
        
        // when
        let activationGroupLeftB = node.add(attribute: leftAttributeA)
        
        // then
        XCTAssertNil(activationGroupLeftB)
    }
    
    func testThatActivationGroupIsTheExpectedWhenShouldInstallIsFalse() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        
        let leftAttributeA = Left(100).when { false }
        leftAttributeA.createConstraints(for: view)
        
        // when
        let activationGroupLeftA = node.add(attribute: leftAttributeA)
        
        // then
        XCTAssertNil(activationGroupLeftA)
    }
    
    func testThatActivationGroupIsTheExpectedUponReloadWithNoChanges() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        
        let leftAttributeA = Left(100)
        leftAttributeA.createConstraints(for: view)
        let rightAttributeA = Right(100)
        rightAttributeA.createConstraints(for: view)
        
        let activationGroupLeftA = node.add(attribute: leftAttributeA)
        XCTAssertTrue(activationGroupLeftA!.0.count == 1)
        XCTAssertTrue(activationGroupLeftA!.0.first === leftAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupLeftA!.1.count == 0)
        
        let activationGroupRightA = node.add(attribute: rightAttributeA)
        XCTAssertTrue(activationGroupRightA!.0.count == 1)
        XCTAssertTrue(activationGroupRightA!.0.first === rightAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupRightA!.1.count == 0)
        
        // when
        let activationGroupReload = node.reload()
        
        // then
        XCTAssertTrue(activationGroupReload.0.count == 0)
        XCTAssertTrue(activationGroupReload.1.count == 0)
    }
    
    func testThatActivationGroupIsTheExpectedUponReloadWithChanges() {
        // given
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        let node = Node()
        var condition = true
        
        let leftAttributeA = Left(100).when { condition }
        leftAttributeA.createConstraints(for: view)
        let leftAttributeB = Left(100).when { !condition }
        leftAttributeB.createConstraints(for: view)
        let rightAttributeA = Right(100)
        rightAttributeA.createConstraints(for: view)
        
        let activationGroupLeftA = node.add(attribute: leftAttributeA)
        XCTAssertTrue(activationGroupLeftA!.0.count == 1)
        XCTAssertTrue(activationGroupLeftA!.0.first === leftAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupLeftA!.1.count == 0)
        
        let activationGroupLeftB = node.add(attribute: leftAttributeB)
        XCTAssertNil(activationGroupLeftB)
        
        let activationGroupRightA = node.add(attribute: rightAttributeA)
        XCTAssertTrue(activationGroupRightA!.0.count == 1)
        XCTAssertTrue(activationGroupRightA!.0.first === rightAttributeA.layoutConstraint)
        XCTAssertTrue(activationGroupRightA!.1.count == 0)
        
        // when
        condition = false
        let activationGroupReload = node.reload()
        
        // then
        XCTAssertTrue(activationGroupReload.0.count == 1)
        XCTAssertTrue(activationGroupReload.0.first === leftAttributeB.layoutConstraint)
        XCTAssertTrue(activationGroupReload.1.count == 1)
        XCTAssertTrue(activationGroupReload.1.first === leftAttributeA.layoutConstraint)
    }
    
}
