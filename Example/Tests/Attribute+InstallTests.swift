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
        let attributes = viewA <- Width(120)
        
        // then
        XCTAssertTrue(viewA.easy_attributes.count == 1)
        XCTAssertTrue(viewA.easy_attributes.first! === attributes.first!)
        XCTAssertTrue(viewA.constraints.count - numberOfPreviousConstraints == 1)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attributes.first!)
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
        let attributes = viewA <- Top(120)
        
        // then
        XCTAssertTrue(superview.easy_attributes.count == 1)
        XCTAssertTrue(superview.easy_attributes.first! === attributes.first!)
        XCTAssertTrue(superview.constraints.count - numberOfPreviousConstraints == 1)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attributes.first!)
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
        XCTAssertTrue(viewA.easy_attributes.count == 1)
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
        XCTAssertTrue(superview.easy_attributes.count == 1)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttribute() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let attributes = viewA <- Width(120)
        XCTAssertTrue(viewA.easy_attributes.count == 1)
        XCTAssertTrue(viewA.easy_attributes.first! === attributes.first!)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attributes.first!)
    
        let numberOfPreviousConstraints = viewA.constraints.count
        
        // when
        let newAttributes = viewA <- Width(500)
        
        // then
        XCTAssertTrue(viewA.easy_attributes.count == 1)
        XCTAssertTrue(viewA.easy_attributes.first! === newAttributes.first!)
        XCTAssertTrue(numberOfPreviousConstraints > 0)
        XCTAssertTrue(viewA.constraints.count == numberOfPreviousConstraints)
        XCTAssertTrue(viewA.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === newAttributes.first!)
    }
    
    func testThatInstallationOfAConflictingAttributeReplacesTheInitialAttributeAndItsOwnedByTheSuperview() {
        // given
        let superview = UIView(frame: CGRectMake(0, 0, 400, 1000))
        let viewA = UIView(frame: CGRectZero)
        superview.addSubview(viewA)
        let viewB = UIView(frame: CGRectZero)
        superview.addSubview(viewB)
        let attributes = viewA <- Top(120)
        XCTAssertTrue(superview.easy_attributes.count == 1)
        XCTAssertTrue(superview.easy_attributes.first! === attributes.first!)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === attributes.first!)
        
        let numberOfPreviousConstraints = superview.constraints.count
        
        // when
        let newAttributes = viewA <- Top(500)
        
        // then
        XCTAssertTrue(superview.easy_attributes.count == 1)
        XCTAssertTrue(superview.easy_attributes.first! === newAttributes.first!)
        XCTAssertTrue(superview.constraints.count == numberOfPreviousConstraints)
        XCTAssertTrue(superview.constraints.filter { $0.easy_attribute != nil }.first!.easy_attribute! === newAttributes.first!)
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
        XCTAssertTrue(superview.easy_attributes.count == 2)
        XCTAssertTrue(viewB.easy_attributes.count == 2)
        
        // when
        viewA <- [
            Top(20).to(superview),
            Left(0).to(superview),
            Width(120),
            Height(120)
        ]
        
        // then
        XCTAssertTrue(superview.easy_attributes.count == 4)
        XCTAssertTrue(viewA.easy_attributes.count == 2)
        
        // And also test that recreating those attributes doesn't break anything
        
        // when
        viewA <- [
            Top(200).to(viewB, .Top),
            Left(20).to(superview),
            Width(220),
            Height(220)
        ]
        
        // then
        XCTAssertTrue(superview.easy_attributes.count == 4)
        XCTAssertTrue(viewA.easy_attributes.count == 2)
    }
    
    func testThatAttributesAppliedToViewWithNoSuperviewDoesNotAssert() {
        // given
        let viewA = UIView(frame: CGRectZero)
        
        // when
        viewA <- Width(120)
        
        // then
        XCTAssertTrue(true)
    }
    
}
