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

class ReferenceAttributeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatOppositeAttributesAreCorrect() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.Width.opposite == .Width)
        XCTAssertTrue(ReferenceAttribute.Height.opposite == .Height)
        XCTAssertTrue(ReferenceAttribute.Left.opposite == .Right)
        XCTAssertTrue(ReferenceAttribute.Right.opposite == .Left)
        XCTAssertTrue(ReferenceAttribute.Top.opposite == .Bottom)
        XCTAssertTrue(ReferenceAttribute.Bottom.opposite == .Top)
        XCTAssertTrue(ReferenceAttribute.Leading.opposite == .Trailing)
        XCTAssertTrue(ReferenceAttribute.Trailing.opposite == .Leading)
        XCTAssertTrue(ReferenceAttribute.CenterX.opposite == .CenterX)
        XCTAssertTrue(ReferenceAttribute.CenterY.opposite == .CenterY)
        XCTAssertTrue(ReferenceAttribute.LastBaseline.opposite == .LastBaseline)
        
    }
    
    func testThatOppositeAttributesAreCorrectiOS8AndAbove() {
        XCTAssertTrue(ReferenceAttribute.FirstBaseline.opposite == .FirstBaseline)
        XCTAssertTrue(ReferenceAttribute.LeftMargin.opposite == .RightMargin)
        XCTAssertTrue(ReferenceAttribute.RightMargin.opposite == .LeftMargin)
        XCTAssertTrue(ReferenceAttribute.TopMargin.opposite == .BottomMargin)
        XCTAssertTrue(ReferenceAttribute.BottomMargin.opposite == .TopMargin)
        XCTAssertTrue(ReferenceAttribute.LeadingMargin.opposite == .TrailingMargin)
        XCTAssertTrue(ReferenceAttribute.TrailingMargin.opposite == .LeadingMargin)
        XCTAssertTrue(ReferenceAttribute.CenterXWithinMargins.opposite == .CenterXWithinMargins)
        XCTAssertTrue(ReferenceAttribute.CenterYWithinMargins.opposite == .CenterYWithinMargins)
        XCTAssertTrue(ReferenceAttribute.NotAnAttribute.opposite == .NotAnAttribute)
    }
    
    func testThatAutoLayoutEquivalentIsTheExpected() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.Width.layoutAttribute == .Width)
        XCTAssertTrue(ReferenceAttribute.Height.layoutAttribute == .Height)
        XCTAssertTrue(ReferenceAttribute.Left.layoutAttribute == .Left)
        XCTAssertTrue(ReferenceAttribute.Right.layoutAttribute == .Right)
        XCTAssertTrue(ReferenceAttribute.Top.layoutAttribute == .Top)
        XCTAssertTrue(ReferenceAttribute.Bottom.layoutAttribute == .Bottom)
        XCTAssertTrue(ReferenceAttribute.Leading.layoutAttribute == .Leading)
        XCTAssertTrue(ReferenceAttribute.Trailing.layoutAttribute == .Trailing)
        XCTAssertTrue(ReferenceAttribute.CenterX.layoutAttribute == .CenterX)
        XCTAssertTrue(ReferenceAttribute.CenterY.layoutAttribute == .CenterY)
        XCTAssertTrue(ReferenceAttribute.LastBaseline.layoutAttribute == .LastBaseline)
        XCTAssertTrue(ReferenceAttribute.Width.layoutAttribute == .Width)
    }
    
    func testThatAutoLayoutEquivalentIsTheExpectediOS8AndAbove() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.FirstBaseline.layoutAttribute == .FirstBaseline)
        XCTAssertTrue(ReferenceAttribute.LeftMargin.layoutAttribute == .LeftMargin)
        XCTAssertTrue(ReferenceAttribute.RightMargin.layoutAttribute == .RightMargin)
        XCTAssertTrue(ReferenceAttribute.TopMargin.layoutAttribute == .TopMargin)
        XCTAssertTrue(ReferenceAttribute.BottomMargin.layoutAttribute == .BottomMargin)
        XCTAssertTrue(ReferenceAttribute.LeadingMargin.layoutAttribute == .LeadingMargin)
        XCTAssertTrue(ReferenceAttribute.TrailingMargin.layoutAttribute == .TrailingMargin)
        XCTAssertTrue(ReferenceAttribute.CenterXWithinMargins.layoutAttribute == .CenterXWithinMargins)
        XCTAssertTrue(ReferenceAttribute.CenterYWithinMargins.layoutAttribute == .CenterYWithinMargins)
        XCTAssertTrue(ReferenceAttribute.NotAnAttribute.layoutAttribute == .NotAnAttribute)
    }
    
    func testThatNotAnAttributeDoesNotHaveConflictingAttributes() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.NotAnAttribute.conflictingAttributes.count == 0)
    }
    
}
