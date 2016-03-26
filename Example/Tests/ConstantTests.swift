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

class ConstantTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatConstantCreatedWithGreaterThanPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (>=350)
        
        // then
        XCTAssertTrue(constant.value == 350)
        XCTAssertTrue(constant.modifier == .GreaterThanOrEqualTo)
    }
    
    func testThatConstantCreatedWithLessThanPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (<=210)
        
        // then
        XCTAssertTrue(constant.value == 210)
        XCTAssertTrue(constant.modifier == .LessThanOrEqualTo)
    }
    
    func testThatConstantCreatedWithMultiplierPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (*5)
        
        // then
        XCTAssertTrue(constant.value == 5)
        XCTAssertTrue(constant.modifier == .MultipliedBy)
    }
    
    func testThatInitWithValueParameterCreatesTheExpectedProperties() {
        // given
        // when
        let constant = Constant(12)
        
        // then
        XCTAssertTrue(constant.value == 12)
        XCTAssertTrue(constant.modifier == .EqualTo)
    }
    
    func testThatLayoutRelationIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(200)
        
        // when
        let greaterThanRelation = greaterThan.layoutRelation()
        let lessThanRelation = lessThan.layoutRelation()
        let multipliedByRelation = multipliedBy.layoutRelation()
        let equalToRelation = equalTo.layoutRelation()
        
        // then
        XCTAssertTrue(greaterThanRelation == NSLayoutRelation.GreaterThanOrEqual)
        XCTAssertTrue(lessThanRelation == NSLayoutRelation.LessThanOrEqual)
        XCTAssertTrue(multipliedByRelation == NSLayoutRelation.Equal)
        XCTAssertTrue(equalToRelation == NSLayoutRelation.Equal)
    }
    
    func testThatLayoutMultiplierIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(200)
        
        // when
        let greaterThanMultiplier = greaterThan.layoutMultiplier()
        let lessThanMultiplier = lessThan.layoutMultiplier()
        let multipliedByMultiplier = multipliedBy.layoutMultiplier()
        let equalToMultiplier = equalTo.layoutMultiplier()
        
        // then
        XCTAssertTrue(greaterThanMultiplier == 1.0)
        XCTAssertTrue(lessThanMultiplier == 1.0)
        XCTAssertTrue(multipliedByMultiplier == 200.0)
        XCTAssertTrue(equalToMultiplier == 1.0)
    }
    
    func testThatLayoutValueIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(200)
        
        // when
        let greaterThanValue = greaterThan.layoutValue()
        let lessThanValue = lessThan.layoutValue()
        let multipliedByValue = multipliedBy.layoutValue()
        let equalToValue = equalTo.layoutValue()
        
        // then
        XCTAssertTrue(greaterThanValue == 200.0)
        XCTAssertTrue(lessThanValue == 200.0)
        XCTAssertTrue(multipliedByValue == 0.0)
        XCTAssertTrue(equalToValue == 200.0)
    }
    
}