// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import EasyPeasy

class ViewController: UIViewController {
    
    var number: Bool = true

    @IBOutlet private var referenceView: UIView!
    
    private lazy var createView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.redColor()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial attributes
        self.view.addSubview(self.createView)
        self.createView <- [
            Width(20).when { _ in return !self.number  },
            Width(1000).when { _ in return self.number  },
            Height(20),
            Top(10).to(self.view, .TopMargin),
            Left().to(self.referenceView, .Left)
        ]
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
        self.number = !self.number
        self.createView.easy_reload()
    }
    
}

