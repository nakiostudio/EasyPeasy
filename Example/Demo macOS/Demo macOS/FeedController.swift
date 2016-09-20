// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import AppKit
import EasyPeasy

// NOTE:
// I know this controller could be easily achievable with a regular table 
// but this way is much easier to show the potential of EasyPeasy
class FeedController: NSViewController {
    
    fileprivate let stubData = TweetModel.stubData()
    
    fileprivate lazy var sideBarView: SideBarView = {
        let view = SideBarView(frame: CGRect.zero)
        return view
    }()
    
    fileprivate lazy var feedView: FeedView = {
        let view = FeedView(frame: CGRect.zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.feedView.title = "Home"
        self.feedView.configure(with: self.stubData)
        self.sideBarView.configure(
            with: "thumb-easypeasy",
            tabs: "icon-home",
            "icon-moments",
            "icon-notifications",
            "icon-messages",
            "icon-search"
        )
    }
    
}

/**
    Autolayout constraints
 */
extension FeedController {
    
    fileprivate func setup() {
        // Side bar
        self.view.addSubview(self.sideBarView)
        self.sideBarView <- [
            Width(80.0),
            Left(0.0),
            Top(0.0),
            Bottom(0.0)
        ]
        
        // Feed view
        self.view.addSubview(self.feedView)
        self.feedView <- [
            Top(0.0),
            Right(0.0),
            Bottom(0.0),
            Left(0.0).to(self.sideBarView)
        ]
    }
    
}
