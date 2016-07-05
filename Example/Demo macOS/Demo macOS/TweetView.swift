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

class TweetView: NSView {
    
    private lazy var userInfoLabel: NSTextField = {
        let label = NSTextField(frame: CGRectZero)
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        return label
    }()
    
    private lazy var displayableDateLabel: NSTextField = {
        let label = NSTextField(frame: CGRectZero)
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        return label
    }()
    
    private lazy var thumbnailImageView: NSImageView = {
        let imageView = NSImageView(frame: CGRectZero)
        return imageView
    }()
    
    private lazy var tweetLabel: NSTextField = {
        let label = NSTextField(frame: CGRectZero)
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        label.setContentCompressionResistancePriority(100, forOrientation: .Horizontal)
        label.setContentCompressionResistancePriority(1000, forOrientation: .Vertical)
        return label
    }()
    
    private lazy var separatorView: NSView = {
        let view = NSView(frame: CGRectZero)
        view.alphaValue = 0.5
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
        self.applyConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.applyConstraints()
    }
    
    override func layout() {
        super.layout()
        
        self.separatorView.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
    }
    
    // MARK: Public methods
    
    func configure(with tweet: TweetModel) {
        self.thumbnailImageView.image = tweet.thumbnail
        let userInfo = TweetView.attributedStringWithName(tweet.name, username: tweet.username)
        self.userInfoLabel.attributedStringValue = userInfo
        let displayableDate = TweetView.attributedStringWithDisplayableDate(tweet.displayableDate)
        self.displayableDateLabel.attributedStringValue = displayableDate
        let tweetString = TweetView.attributedStringWithTweet(tweet.tweet)
        self.tweetLabel.attributedStringValue = tweetString
    }
    
    // MARK: Private methods
    
    private func setup() {
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.displayableDateLabel)
        self.addSubview(self.userInfoLabel)
        self.addSubview(self.tweetLabel)
        self.addSubview(self.separatorView)
    }
    
}

/**
    Autolayout constraints
 */
extension TweetView {
    
    private func applyConstraints() {
        // Thumbnail imageview
        self.thumbnailImageView <- [
            Size(52.0),
            Top(12.0),
            Left(12.0)
        ]
        
        // Displayable date label
        self.displayableDateLabel <- [
            Width(<=40.0),
            Top(0.0).to(self.thumbnailImageView, .Top),
            Right(12.0)
        ]
        
        // UserInfo label
        self.userInfoLabel <- [
            Height(20.0),
            Top(0.0).to(self.thumbnailImageView, .Top),
            Left(10.0).to(self.thumbnailImageView),
            Right(10.0).to(self.displayableDateLabel)
        ]
        
        // Tweet label
        self.tweetLabel <- [
            Height(>=20.0),
            Top(0.0).to(self.userInfoLabel),
            Bottom(12.0),
            Left(0.0).to(self.userInfoLabel, .Left),
            Right(12.0)
        ]
        
        // Separator
        self.separatorView <- [
            Left(0.0),
            Right(0.0),
            Bottom(0.0),
            Height(1.0)
        ]
    }
    
}

/**
    NSAttributedString factory methods
 */
extension TweetView {
    
    @nonobjc static let darkGreyColor = NSColor(red: 140.0/255.0, green: 157.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    @nonobjc static let lightBlueColor = NSColor(red: 33.0/255.0, green: 151.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    
    static func attributedStringWithDisplayableDate(string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Right
        let attributes = [
            NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName: NSFont.systemFontOfSize(12.0),
            NSForegroundColorAttributeName: TweetView.darkGreyColor
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    static func attributedStringWithTweet(tweet: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Left
        paragraphStyle.lineHeightMultiple = 1.2
        let attributes = [
            NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName: NSFont.systemFontOfSize(13.0),
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        return NSMutableAttributedString(string: tweet, attributes: attributes)
    }
    
    static func attributedStringWithName(name: String, username: String) -> NSAttributedString {
        let string = "\(name) \(username)"
        let boldAttributes = [
            NSFontAttributeName: NSFont.boldSystemFontOfSize(14.0),
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        let lightAttributes = [
            NSFontAttributeName: NSFont.systemFontOfSize(12.0),
            NSForegroundColorAttributeName: TweetView.darkGreyColor
        ]
        
        let attributedString = NSMutableAttributedString(string: string, attributes: boldAttributes)
        let range = (string as NSString).rangeOfString(username)
        attributedString.addAttributes(lightAttributes, range: range)
        
        return attributedString
    }
    
}
