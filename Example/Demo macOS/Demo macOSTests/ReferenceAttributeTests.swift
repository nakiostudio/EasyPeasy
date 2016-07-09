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
    
    func testThatOppositeAttributesAreCorrectOSX1011AndAbove() {
        XCTAssertTrue(ReferenceAttribute.FirstBaseline.opposite == .FirstBaseline)
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
    
    @available(OSX 10.11, *)
    func testThatAutoLayoutEquivalentIsTheExpectedOSX1011AndAbove() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.FirstBaseline.layoutAttribute == .FirstBaseline)
        XCTAssertTrue(ReferenceAttribute.NotAnAttribute.layoutAttribute == .NotAnAttribute)
    }
    
    func testThatNotAnAttributeDoesNotHaveConflictingAttributes() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.NotAnAttribute.conflictingAttributes.count == 0)
    }
    
}
