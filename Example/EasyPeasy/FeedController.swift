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
// potential of EasyPeasy

class FeedController: UIViewController {
    
    fileprivate var tweets: [TweetModel] = []
    fileprivate var tweetViews: [TweetView] = []
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        return scrollView
    }()
    
    fileprivate lazy var newTweetsView: UIImageView = {
        let imageView = UIImageView(image: UIImage.easy_newTweets())
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.populateFeed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // An example of UIView animation
        self.showNewTweetsIndicator(true)
    }
    
    // MARK: Private
    
    fileprivate func setup() {
        // Set stub data
        self.tweets = TweetModel.stubData()
        
        // Background color
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1.0)
        
        // Set title view
        let logoImageView = UIImageView(image: UIImage.easy_twitterLogo())
        self.navigationItem.titleView = logoImageView
        
        // Scrollview
        self.view.addSubview(self.scrollView)
        self.scrollView.easy.layout(
            Edges()
        )
        
        // New tweets indicator
        self.view.addSubview(self.newTweetsView)
        self.newTweetsView.easy.layout(
            Size(CGSize(width: 118.0, height: 30.0)),
            Top(-100),
            CenterX()
        )
    }
    
    fileprivate func populateFeed() {
        // It creates the constraints for each entry
        for (index, tweet) in self.tweets.enumerated() {
            let view = TweetView(frame: CGRect.zero)
            view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            view.setContentHuggingPriority(UILayoutPriority(rawValue: 600), for: .vertical)
            self.scrollView.addSubview(view)
            view.easy.layout(
                Width(<=420),
                Height(>=78),
                CenterX(),
                Left().with(.medium),
                Right().with(.medium),
                // Pins to top only when we place the first row
                Top().when { index == 0 },
                // Pins to bottom of the preivous item for the other cases
                Top(1).to(self.tweetViews.last ?? self.scrollView).when { index > 0 }
            )
            
            view.configureWithModel(tweet)
            self.tweetViews.append(view)
        }
        
        // Establishes constraint with the bottom of the scroll view to adjust
        // the content size
        self.tweetViews.last!.easy.layout(
            Bottom().to(self.scrollView, .bottom)
        )
    }
    
    fileprivate func showNewTweetsIndicator(_ show: Bool) {
        UIView.animate(withDuration: 0.3, delay: 2.0, options: UIView.AnimationOptions(), animations: {
            self.newTweetsView.easy.layout(Top(10).when { show })
            self.newTweetsView.easy.layout(Top(-100).when { !show })
            self.view.layoutIfNeeded()
        }, completion: { complete in
            if show {
                self.showNewTweetsIndicator(false)
            }
        })
    }
    
}
