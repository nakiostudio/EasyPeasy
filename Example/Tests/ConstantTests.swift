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
    
    func testThatConstantCreatedWithEqualPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (==350)
        
        // then
        XCTAssertTrue(constant.value == 350)
        XCTAssertTrue(constant.relation == .equal)
    }
    
    func testThatConstantCreatedWithGreaterThanPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (>=350)
        
        // then
        XCTAssertTrue(constant.value == 350)
        XCTAssertTrue(constant.relation == .greaterThanOrEqual)
    }
    
    func testThatConstantCreatedWithLessThanPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (<=210)
        
        // then
        XCTAssertTrue(constant.value == 210)
        XCTAssertTrue(constant.relation == .lessThanOrEqual)
    }
    
    func testThatConstantCreatedWithMultiplierPrefixCreatesTheExpectedProperties() {
        // given
        // when
        let constant = (*5)
        
        // then
        XCTAssertTrue(constant.value == 5)
        XCTAssertTrue(constant.relation == .equal)
        XCTAssertTrue(constant.multiplier == 5.0)
    }
    
    func testThatInitWithValueParameterCreatesTheExpectedProperties() {
        // given
        // when
        let constant = Constant(value: 12, relation: .equal, multiplier: 1.0)
        
        // then
        XCTAssertTrue(constant.value == 12)
        XCTAssertTrue(constant.relation == .equal)
        XCTAssertTrue(constant.multiplier == 1.0)
    }
    
    func testThatLayoutRelationIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(value: 200, relation: .equal, multiplier: 1.0)
        let equalToPref = (==200)
        
        // when
        let greaterThanRelation = greaterThan.relation
        let lessThanRelation = lessThan.relation
        let multipliedByRelation = multipliedBy.relation
        let equalToRelation = equalTo.relation
        let equalToPrefRelation = equalToPref.relation
        
        // then
        XCTAssertTrue(greaterThanRelation == .greaterThanOrEqual)
        XCTAssertTrue(lessThanRelation == .lessThanOrEqual)
        XCTAssertTrue(multipliedByRelation == .equal)
        XCTAssertTrue(equalToRelation == .equal)
        XCTAssertTrue(equalToPrefRelation == .equal)
    }
    
    func testThatLayoutMultiplierIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(value: 200, relation: .equal, multiplier: 1.0)
        let equalToPref = (==200)
        
        // when
        let greaterThanMultiplier = greaterThan.multiplier
        let lessThanMultiplier = lessThan.multiplier
        let multipliedByMultiplier = multipliedBy.multiplier
        let equalToMultiplier = equalTo.multiplier
        let equalToPrefMultiplier = equalToPref.multiplier
        
        // then
        XCTAssertTrue(greaterThanMultiplier == 1.0)
        XCTAssertTrue(lessThanMultiplier == 1.0)
        XCTAssertTrue(multipliedByMultiplier == 200.0)
        XCTAssertTrue(equalToMultiplier == 1.0)
        XCTAssertTrue(equalToPrefMultiplier == 1.0)
    }
    
    func testThatLayoutValueIsTheExpected() {
        // given
        let greaterThan = (>=200)
        let lessThan = (<=200)
        let multipliedBy = (*200)
        let equalTo = Constant(value: 200, relation: .equal, multiplier: 1.0)
        let equalToPref = (==200)
        
        // when
        let greaterThanValue = greaterThan.value
        let lessThanValue = lessThan.value
        let multipliedByValue = multipliedBy.value
        let equalToValue = equalTo.value
        let equalToPrefValue = equalToPref.value
        
        // then
        XCTAssertTrue(greaterThanValue == 200.0)
        XCTAssertTrue(lessThanValue == 200.0)
        XCTAssertTrue(multipliedByValue == 200.0)
        XCTAssertTrue(equalToValue == 200.0)
        XCTAssertTrue(equalToPrefValue == 200.0)
    }
    
    func testThatMultiplierIsCorrectlyCombinedWithAConstant() {
        // given
        let eqMult = ==20.0*0.5
        let gtMult = >=20*0.5
        let ltMult = <=20*0.5
        
        // when
        // then
        XCTAssertTrue(eqMult.multiplier == 0.5)
        XCTAssertTrue(eqMult.value == 20)
        XCTAssertTrue(eqMult.relation == .equal)
        XCTAssertTrue(gtMult.multiplier == 0.5)
        XCTAssertTrue(gtMult.value == 20)
        XCTAssertTrue(gtMult.relation == .greaterThanOrEqual)
        XCTAssertTrue(ltMult.multiplier == 0.5)
        XCTAssertTrue(ltMult.value == 20)
        XCTAssertTrue(ltMult.relation == .lessThanOrEqual)
    }
    
}
