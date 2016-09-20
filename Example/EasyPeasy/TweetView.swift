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

class TweetView: UIView {

    fileprivate lazy var userInfoLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        return label
    }()
    
    fileprivate lazy var displayableDateLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        return label
    }()
    
    fileprivate lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6.0
        return imageView
    }()
    
    fileprivate lazy var tweetLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(100, for: .horizontal)
        label.setContentCompressionResistancePriority(1000, for: .vertical)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
        self.layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.layout()
    }
    
    // MARK: Public methods
    
    func configureWithModel(_ tweetModel: TweetModel) {
        self.thumbnailImageView.image = tweetModel.thumbnail
        let userInfo = TweetView.attributedStringWithName(tweetModel.name, username: tweetModel.username)
        self.userInfoLabel.attributedText = userInfo
        let displayableDate = TweetView.attributedStringWithDisplayableDate(tweetModel.displayableDate)
        self.displayableDateLabel.attributedText = displayableDate
        let tweet = TweetView.attributedStringWithTweet(tweetModel.tweet)
        self.tweetLabel.attributedText = tweet
    }
    
    // MARK: Private methods
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.displayableDateLabel)
        self.addSubview(self.userInfoLabel)
        self.addSubview(self.tweetLabel)
    }
    
}

/**
    Autolayout constraints
 */
extension TweetView {

    fileprivate func layout() {
        // Thumbnail imageview
        self.thumbnailImageView <- [
            Size(52),
            Top(12),
            Left(12)
        ]
        
        // Displayable date label
        self.displayableDateLabel <- [
            Width(<=40),
            Top().to(self.thumbnailImageView, .top),
            Right(12)
        ]
        
        // UserInfo label
        self.userInfoLabel <- [
            Height(20),
            Top().to(self.thumbnailImageView, .top),
            Left(10).to(self.thumbnailImageView),
            Right(10).to(self.displayableDateLabel)
        ]
        
        // Tweet label
        self.tweetLabel <- [
            Height(>=20),
            Top(0).to(self.userInfoLabel),
            Bottom(12),
            Left().to(self.userInfoLabel, .left),
            Right(12)
        ]
    }
    
}

/**
    NSAttributedString factory methods
 */
extension TweetView {
    
    @nonobjc static let darkGreyColor = UIColor(red: 140.0/255.0, green: 157.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    @nonobjc static let lightBlueColor = UIColor(red: 33.0/255.0, green: 151.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    
    static func attributedStringWithDisplayableDate(_ string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes = [
            NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName: TweetView.darkGreyColor
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    static func attributedStringWithTweet(_ tweet: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineHeightMultiple = 1.2
        let attributes = [
            NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName: UIFont.systemFont(ofSize: 15.0),
            NSForegroundColorAttributeName: UIColor.black
        ]
        
        let string = NSMutableAttributedString(string: tweet, attributes: attributes)
    
        for hashtagRange in tweet.easy_hashtagRanges() {
            string.addAttribute(NSForegroundColorAttributeName, value: TweetView.lightBlueColor, range: hashtagRange)
        }
        
        return string
    }
    
    static func attributedStringWithName(_ name: String, username: String) -> NSAttributedString {
        let string = "\(name) \(username)"
        let boldAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16.0),
            NSForegroundColorAttributeName: UIColor.black
        ]
        let lightAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName: TweetView.darkGreyColor
        ]
        
        let attributedString = NSMutableAttributedString(string: string, attributes: boldAttributes)
        let range = (string as NSString).range(of: username)
        attributedString.addAttributes(lightAttributes, range: range)
        
        return attributedString
    }
    
}
