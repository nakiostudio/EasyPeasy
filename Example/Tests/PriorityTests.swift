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

class PriorityTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatThatOrderIsCorrect() {
        // given
        let required = Priority.required
        let high = Priority.high
        let medium = Priority.medium
        let low = Priority.low
        
        // when
        // then
        XCTAssertTrue(required.layoutPriority() > high.layoutPriority())
        XCTAssertTrue(high.layoutPriority() > medium.layoutPriority())
        XCTAssertTrue(medium.layoutPriority() > low.layoutPriority())
    }
    
    func testThatCustomPriorityRetursTheValueGiven() {
        // given
        let myCustomValue: Float = 234.0
        
        // when
        let priority = Priority.custom(myCustomValue)
        
        // then
        XCTAssertTrue(priority.layoutPriority() == myCustomValue)
    }
    
    func testThatThatOrderIsCorrect_deprecatedCases() {
        // given
        let high = Priority.high
        let medium = Priority.medium
        let low = Priority.low
        
        // when
        // then
        XCTAssertTrue(high.layoutPriority() > medium.layoutPriority())
        XCTAssertTrue(medium.layoutPriority() > low.layoutPriority())
    }

    func testThatCustomPriorityRetursTheValueGiven_deprecatedCases() {
        // given
        let myCustomValue: Float = 234.0
        
        // when
        let priority = Priority.custom(myCustomValue)
        
        // then
        XCTAssertTrue(priority.layoutPriority() == myCustomValue)
    }

}
