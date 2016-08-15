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

class ContextTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testThatContextIsInitializedWithTheExpectedValues() {
        // given
        let view = UIView()
        let isPad = UI_USER_INTERFACE_IDIOM() == .Pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .Phone
        let isCompact = view.traitCollection.verticalSizeClass == .Compact && view.traitCollection.horizontalSizeClass == .Compact
        let isHorizontalCompact = view.traitCollection.horizontalSizeClass == .Compact
        let isVerticalCompact = view.traitCollection.verticalSizeClass == .Compact
        let isRegular = view.traitCollection.verticalSizeClass == .Regular && view.traitCollection.horizontalSizeClass == .Regular
        let isHorizontalRegular = view.traitCollection.horizontalSizeClass == .Regular
        let isVerticalRegular = view.traitCollection.verticalSizeClass == .Regular
        
        // when
        let context = Context(with: view.traitCollection)
        
        // then
        XCTAssertTrue(context.isPad == isPad)
        XCTAssertTrue(context.isPhone == isPhone)
        XCTAssertTrue(context.isHorizontalVerticalCompact == isCompact)
        XCTAssertTrue(context.isHorizontalCompact == isHorizontalCompact)
        XCTAssertTrue(context.isVerticalCompact == isVerticalCompact)
        XCTAssertTrue(context.isHorizontalVerticalRegular == isRegular)
        XCTAssertTrue(context.isHorizontalRegular == isHorizontalRegular)
        XCTAssertTrue(context.isVerticalRegular == isVerticalRegular)
    }
    
    func testThatContextIsInitializedWithTheExpectedValuesUsingCustomRegularHorizontalTraits() {
        // given
        let traitCollection = UITraitCollection(horizontalSizeClass: .Regular)
        let isPad = UI_USER_INTERFACE_IDIOM() == .Pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .Phone
        let isCompact = traitCollection.verticalSizeClass == .Compact && traitCollection.horizontalSizeClass == .Compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .Compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .Compact
        let isRegular = traitCollection.verticalSizeClass == .Regular && traitCollection.horizontalSizeClass == .Regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .Regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .Regular
        
        // when
        let context = Context(with: traitCollection)
        
        // then
        XCTAssertTrue(context.isPad == isPad)
        XCTAssertTrue(context.isPhone == isPhone)
        XCTAssertTrue(context.isHorizontalVerticalCompact == isCompact)
        XCTAssertTrue(context.isHorizontalCompact == isHorizontalCompact)
        XCTAssertTrue(context.isVerticalCompact == isVerticalCompact)
        XCTAssertTrue(context.isHorizontalVerticalRegular == isRegular)
        XCTAssertTrue(context.isHorizontalRegular == isHorizontalRegular)
        XCTAssertTrue(context.isVerticalRegular == isVerticalRegular)
    }
    
    func testThatContextIsInitializedWithTheExpectedValuesUsingCustomRegularVerticalTraits() {
        // given
        let traitCollection = UITraitCollection(verticalSizeClass: .Regular)
        let isPad = UI_USER_INTERFACE_IDIOM() == .Pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .Phone
        let isCompact = traitCollection.verticalSizeClass == .Compact && traitCollection.horizontalSizeClass == .Compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .Compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .Compact
        let isRegular = traitCollection.verticalSizeClass == .Regular && traitCollection.horizontalSizeClass == .Regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .Regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .Regular
        
        // when
        let context = Context(with: traitCollection)
        
        // then
        XCTAssertTrue(context.isPad == isPad)
        XCTAssertTrue(context.isPhone == isPhone)
        XCTAssertTrue(context.isHorizontalVerticalCompact == isCompact)
        XCTAssertTrue(context.isHorizontalCompact == isHorizontalCompact)
        XCTAssertTrue(context.isVerticalCompact == isVerticalCompact)
        XCTAssertTrue(context.isHorizontalVerticalRegular == isRegular)
        XCTAssertTrue(context.isHorizontalRegular == isHorizontalRegular)
        XCTAssertTrue(context.isVerticalRegular == isVerticalRegular)
    }
    
    func testThatContextIsInitializedWithTheExpectedValuesUsingCustomCompactVerticalTraits() {
        // given
        let traitCollection = UITraitCollection(verticalSizeClass: .Compact)
        let isPad = UI_USER_INTERFACE_IDIOM() == .Pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .Phone
        let isCompact = traitCollection.verticalSizeClass == .Compact && traitCollection.horizontalSizeClass == .Compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .Compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .Compact
        let isRegular = traitCollection.verticalSizeClass == .Regular && traitCollection.horizontalSizeClass == .Regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .Regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .Regular
        
        // when
        let context = Context(with: traitCollection)
        
        // then
        XCTAssertTrue(context.isPad == isPad)
        XCTAssertTrue(context.isPhone == isPhone)
        XCTAssertTrue(context.isHorizontalVerticalCompact == isCompact)
        XCTAssertTrue(context.isHorizontalCompact == isHorizontalCompact)
        XCTAssertTrue(context.isVerticalCompact == isVerticalCompact)
        XCTAssertTrue(context.isHorizontalVerticalRegular == isRegular)
        XCTAssertTrue(context.isHorizontalRegular == isHorizontalRegular)
        XCTAssertTrue(context.isVerticalRegular == isVerticalRegular)
    }
    
    func testThatContextIsInitializedWithTheExpectedValuesUsingCustomCompactHorizontalTraits() {
        // given
        let traitCollection = UITraitCollection(horizontalSizeClass: .Compact)
        let isPad = UI_USER_INTERFACE_IDIOM() == .Pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .Phone
        let isCompact = traitCollection.verticalSizeClass == .Compact && traitCollection.horizontalSizeClass == .Compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .Compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .Compact
        let isRegular = traitCollection.verticalSizeClass == .Regular && traitCollection.horizontalSizeClass == .Regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .Regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .Regular
        
        // when
        let context = Context(with: traitCollection)
        
        // then
        XCTAssertTrue(context.isPad == isPad)
        XCTAssertTrue(context.isPhone == isPhone)
        XCTAssertTrue(context.isHorizontalVerticalCompact == isCompact)
        XCTAssertTrue(context.isHorizontalCompact == isHorizontalCompact)
        XCTAssertTrue(context.isVerticalCompact == isVerticalCompact)
        XCTAssertTrue(context.isHorizontalVerticalRegular == isRegular)
        XCTAssertTrue(context.isHorizontalRegular == isHorizontalRegular)
        XCTAssertTrue(context.isVerticalRegular == isVerticalRegular)
    }
    
}
