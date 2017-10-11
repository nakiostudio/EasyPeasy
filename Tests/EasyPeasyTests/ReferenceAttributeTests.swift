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
        XCTAssertTrue(ReferenceAttribute.width.opposite == .width)
        XCTAssertTrue(ReferenceAttribute.height.opposite == .height)
        XCTAssertTrue(ReferenceAttribute.left.opposite == .right)
        XCTAssertTrue(ReferenceAttribute.right.opposite == .left)
        XCTAssertTrue(ReferenceAttribute.top.opposite == .bottom)
        XCTAssertTrue(ReferenceAttribute.bottom.opposite == .top)
        XCTAssertTrue(ReferenceAttribute.leading.opposite == .trailing)
        XCTAssertTrue(ReferenceAttribute.trailing.opposite == .leading)
        XCTAssertTrue(ReferenceAttribute.centerX.opposite == .centerX)
        XCTAssertTrue(ReferenceAttribute.centerY.opposite == .centerY)
        XCTAssertTrue(ReferenceAttribute.lastBaseline.opposite == .lastBaseline)
        
    }
    
    func testThatOppositeAttributesAreCorrectiOS8AndAbove() {
        XCTAssertTrue(ReferenceAttribute.firstBaseline.opposite == .firstBaseline)
        XCTAssertTrue(ReferenceAttribute.leftMargin.opposite == .rightMargin)
        XCTAssertTrue(ReferenceAttribute.rightMargin.opposite == .leftMargin)
        XCTAssertTrue(ReferenceAttribute.topMargin.opposite == .bottomMargin)
        XCTAssertTrue(ReferenceAttribute.bottomMargin.opposite == .topMargin)
        XCTAssertTrue(ReferenceAttribute.leadingMargin.opposite == .trailingMargin)
        XCTAssertTrue(ReferenceAttribute.trailingMargin.opposite == .leadingMargin)
        XCTAssertTrue(ReferenceAttribute.centerXWithinMargins.opposite == .centerXWithinMargins)
        XCTAssertTrue(ReferenceAttribute.centerYWithinMargins.opposite == .centerYWithinMargins)
    }
    
    func testThatAutoLayoutEquivalentIsTheExpected() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.width.layoutAttribute == .width)
        XCTAssertTrue(ReferenceAttribute.height.layoutAttribute == .height)
        XCTAssertTrue(ReferenceAttribute.left.layoutAttribute == .left)
        XCTAssertTrue(ReferenceAttribute.right.layoutAttribute == .right)
        XCTAssertTrue(ReferenceAttribute.top.layoutAttribute == .top)
        XCTAssertTrue(ReferenceAttribute.bottom.layoutAttribute == .bottom)
        XCTAssertTrue(ReferenceAttribute.leading.layoutAttribute == .leading)
        XCTAssertTrue(ReferenceAttribute.trailing.layoutAttribute == .trailing)
        XCTAssertTrue(ReferenceAttribute.centerX.layoutAttribute == .centerX)
        XCTAssertTrue(ReferenceAttribute.centerY.layoutAttribute == .centerY)
        XCTAssertTrue(ReferenceAttribute.lastBaseline.layoutAttribute == .lastBaseline)
        XCTAssertTrue(ReferenceAttribute.width.layoutAttribute == .width)
    }
    
    func testThatAutoLayoutEquivalentIsTheExpectediOS8AndAbove() {
        // given
        // when
        // then
        XCTAssertTrue(ReferenceAttribute.firstBaseline.layoutAttribute == .firstBaseline)
        XCTAssertTrue(ReferenceAttribute.leftMargin.layoutAttribute == .leftMargin)
        XCTAssertTrue(ReferenceAttribute.rightMargin.layoutAttribute == .rightMargin)
        XCTAssertTrue(ReferenceAttribute.topMargin.layoutAttribute == .topMargin)
        XCTAssertTrue(ReferenceAttribute.bottomMargin.layoutAttribute == .bottomMargin)
        XCTAssertTrue(ReferenceAttribute.leadingMargin.layoutAttribute == .leadingMargin)
        XCTAssertTrue(ReferenceAttribute.trailingMargin.layoutAttribute == .trailingMargin)
        XCTAssertTrue(ReferenceAttribute.centerXWithinMargins.layoutAttribute == .centerXWithinMargins)
        XCTAssertTrue(ReferenceAttribute.centerYWithinMargins.layoutAttribute == .centerYWithinMargins)
    }
    
}
