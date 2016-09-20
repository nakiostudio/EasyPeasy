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
    
    static let minimumHeight: CGFloat = 76.0
    
    fileprivate lazy var userInfoLabel: NSTextField = {
        let label = NSTextField(frame: CGRect.zero)
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = false
        return label
    }()
    
    fileprivate lazy var displayableDateLabel: NSTextField = {
        let label = NSTextField(frame: CGRect.zero)
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = false
        return label
    }()
    
    fileprivate lazy var thumbnailImageView: NSImageView = {
        let imageView = NSImageView(frame: CGRect.zero)
        return imageView
    }()
    
    fileprivate lazy var tweetLabel: NSTextField = {
        let label = NSTextField(frame: CGRect.zero)
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.setContentCompressionResistancePriority(100, for: .horizontal)
        label.setContentCompressionResistancePriority(1000, for: .vertical)
        return label
    }()
    
    fileprivate lazy var separatorView: NSView = {
        let view = NSView(frame: CGRect.zero)
        view.alphaValue = 0.4
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
        
        self.separatorView.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.thumbnailImageView.layer?.cornerRadius = 4.0
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        self <- Bottom(100).to(self.tweetLabel, .bottom).with(.mediumPriority)
    }
    
    // MARK: Public methods
    
    func configure(with tweet: TweetModel) {
        self.thumbnailImageView.image = tweet.thumbnail
        let userInfo = TweetView.attributedStringWithName(tweet.name, username: tweet.displayableUsername)
        self.userInfoLabel.attributedStringValue = userInfo
        let displayableDate = TweetView.attributedStringWithDisplayableDate(tweet.displayableDate)
        self.displayableDateLabel.attributedStringValue = displayableDate
        let tweetString = TweetView.attributedStringWithTweet(tweet.tweet)
        self.tweetLabel.attributedStringValue = tweetString
    }
    
    // MARK: Private methods
    
    fileprivate func setup() {
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
    
    fileprivate func applyConstraints() {
        // Thumbnail imageview
        self.thumbnailImageView <- [
            Size(52.0),
            Top(12.0),
            Left(12.0)
        ]
        
        // UserInfo label
        self.userInfoLabel <- [
            Height(>=0.0),
            Top(0.0).to(self.thumbnailImageView, .top),
            Left(10.0).to(self.thumbnailImageView),
            Right(10.0).to(self.displayableDateLabel)
        ]
        
        // Displayable date label
        self.displayableDateLabel <- [
            Width(<=40.0),
            Height(>=0.0),
            CenterY(0.0).to(self.userInfoLabel),
            Right(12.0)
        ]
        
        // Tweet label
        self.tweetLabel <- [
            Height(>=0.0),
            Top(2.0).to(self.userInfoLabel),
            Bottom(6.0),
            Left(-2.0).to(self.userInfoLabel, .left),
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
    
    static func attributedStringWithDisplayableDate(_ string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes = [
            NSParagraphStyleAttributeName: paragraphStyle,
            NSFontAttributeName: NSFont.systemFont(ofSize: 12.0),
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
            NSFontAttributeName: NSFont.systemFont(ofSize: 13.0),
            NSForegroundColorAttributeName: NSColor.black
        ]
        
        return NSMutableAttributedString(string: tweet, attributes: attributes)
    }
    
    static func attributedStringWithName(_ name: String, username: String) -> NSAttributedString {
        let string = "\(name) \(username)"
        let boldAttributes = [
            NSFontAttributeName: NSFont.boldSystemFont(ofSize: 14.0),
            NSForegroundColorAttributeName: NSColor.black
        ]
        let lightAttributes = [
            NSFontAttributeName: NSFont.systemFont(ofSize: 12.0),
            NSForegroundColorAttributeName: TweetView.darkGreyColor
        ]
        
        let attributedString = NSMutableAttributedString(string: string, attributes: boldAttributes)
        let range = (string as NSString).range(of: username)
        attributedString.addAttributes(lightAttributes, range: range)
        
        return attributedString
    }
    
}
