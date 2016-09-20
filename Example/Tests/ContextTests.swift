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
        let isPad = UI_USER_INTERFACE_IDIOM() == .pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .phone
        let isCompact = view.traitCollection.verticalSizeClass == .compact && view.traitCollection.horizontalSizeClass == .compact
        let isHorizontalCompact = view.traitCollection.horizontalSizeClass == .compact
        let isVerticalCompact = view.traitCollection.verticalSizeClass == .compact
        let isRegular = view.traitCollection.verticalSizeClass == .regular && view.traitCollection.horizontalSizeClass == .regular
        let isHorizontalRegular = view.traitCollection.horizontalSizeClass == .regular
        let isVerticalRegular = view.traitCollection.verticalSizeClass == .regular
        
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
        let traitCollection = UITraitCollection(horizontalSizeClass: .regular)
        let isPad = UI_USER_INTERFACE_IDIOM() == .pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .phone
        let isCompact = traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .compact
        let isRegular = traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .regular
        
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
        let traitCollection = UITraitCollection(verticalSizeClass: .regular)
        let isPad = UI_USER_INTERFACE_IDIOM() == .pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .phone
        let isCompact = traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .compact
        let isRegular = traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .regular
        
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
        let traitCollection = UITraitCollection(verticalSizeClass: .compact)
        let isPad = UI_USER_INTERFACE_IDIOM() == .pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .phone
        let isCompact = traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .compact
        let isRegular = traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .regular
        
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
        let traitCollection = UITraitCollection(horizontalSizeClass: .compact)
        let isPad = UI_USER_INTERFACE_IDIOM() == .pad
        let isPhone = UI_USER_INTERFACE_IDIOM() == .phone
        let isCompact = traitCollection.verticalSizeClass == .compact && traitCollection.horizontalSizeClass == .compact
        let isHorizontalCompact = traitCollection.horizontalSizeClass == .compact
        let isVerticalCompact = traitCollection.verticalSizeClass == .compact
        let isRegular = traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular
        let isHorizontalRegular = traitCollection.horizontalSizeClass == .regular
        let isVerticalRegular = traitCollection.verticalSizeClass == .regular
        
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
