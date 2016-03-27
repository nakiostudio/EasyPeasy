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

// NOTE:
// I know this controller could be easily achievable with a regular
// UITableViewController but this way is much easier to show the 
// potential of EasyPeasy!

class FeedController: UIViewController {
    
    private var tweets: [TweetModel] = []
    private var tweetViews: [TweetView] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRectZero)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.populateFeed()
    }
    
    // MARK: Private
    
    private func setup() {
        // Set stub data
        self.tweets = TweetModel.stubData()
        
        // Background color
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1.0)
        
        // Set title view
        let logoImageView = UIImageView(image: UIImage.easy_twitterLogo())
        self.navigationItem.titleView = logoImageView
        
        // Scrollview
        self.view.addSubview(self.scrollView)
        self.scrollView <- [
            Edges()
        ]
    }
    
    private func populateFeed() {
        // It creates the constraints for each entry
        for (index, tweet) in self.tweets.enumerate() {
            let view = TweetView(frame: CGRectZero)
            view.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
            view.setContentHuggingPriority(600, forAxis: .Vertical)
            self.scrollView.addSubview(view)
            view <- [
                Width(<=420),
                Height(>=78),
                CenterX(),
                Left().with(.MediumPriority),
                Right().with(.MediumPriority),
                // Pins to top only when we place the first row
                Top().when { index == 0 },
                // Pins to bottom of the preivous item for the other cases
                Top(1).to(self.tweetViews.last ?? self.scrollView).when { index > 0 }
            ]
            
            view.configureWithModel(tweet)
            self.tweetViews.append(view)
        }
        
        // Establishes constraint with the bottom of the scroll view to adjust
        // the content size
        self.tweetViews.last! <- [
            Bottom().to(self.scrollView, .Bottom)
        ]
    }
    
}
