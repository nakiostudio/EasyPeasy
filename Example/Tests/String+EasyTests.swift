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

class String_EasyTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testThatAGoodBunchOfAttributesHaveTheExpectedSignature() {
        // given 
        let a: Attribute = Width(>=10).with(.CustomPriority(300))
        let b: Attribute = Height(100)
        let c: Attribute = Left(<=40).with(.LowPriority)
        let d: Attribute = CenterXWithinMargins().with(.MediumPriority)
        let e: Attribute = LastBaseline(>=30)
        let f: Attribute = BottomMargin()
        let g: Attribute = CenterYWithinMargins(<=40)
        let h: Attribute = CenterX(>=0).with(.CustomPriority(244))
        
        // when
        // then
        XCTAssertTrue(a.signature == "h_gt_300.0")
        XCTAssertTrue(b.signature == "v_eq_1000.0")
        XCTAssertTrue(c.signature == "h_lt_1.0")
        XCTAssertTrue(d.signature == "h_eq_500.0")
        XCTAssertTrue(e.signature == "v_gt_1000.0")
        XCTAssertTrue(f.signature == "v_eq_1000.0")
        XCTAssertTrue(g.signature == "v_lt_1000.0")
        XCTAssertTrue(h.signature == "h_gt_244.0")
    }

}
