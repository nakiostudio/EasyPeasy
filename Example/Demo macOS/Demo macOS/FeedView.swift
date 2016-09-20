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

class FeedView: NSView {
    
    fileprivate static let headerPadding: CGFloat = 12.0

    fileprivate lazy var titleLabel: NSTextField = {
        let label = NSTextField(frame: CGRect.zero)
        label.font = NSFont.boldSystemFont(ofSize: 14.0)
        label.textColor = NSColor.darkGray
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    
    fileprivate lazy var scrollView: NSScrollView = {
        let view = NSScrollView(frame: CGRect.zero)
        return view
    }()
    
    fileprivate lazy var contentView: NSView = {
        let view = NSView(frame: CGRect.zero)
        return view
    }()
    
    fileprivate lazy var separatorView: NSView = {
        let view = NSView(frame: CGRect.zero)
        view.alphaValue = 0.4
        return view
    }()
    
    var title: String? {
        didSet {
            self.titleLabel.stringValue = self.title ?? ""
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.setFill()
        NSRectFill(dirtyRect)
        super.draw(dirtyRect)
    }
    
    override func layout() {
        super.layout()
        
        self.separatorView.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
    // MARK: Public methods
    
    func configure(with tweets: [TweetModel]) {
        var priority = 500 - Float(tweets.count)
        var previousItem: NSView = self.contentView
        // Creates a tweetView for every tweet model within tweets array
        for tweet in tweets {
            let tweetView = TweetView(frame: CGRect.zero)
            tweetView.configure(with: tweet)
            
            // Layout "cells"
            self.contentView.addSubview(tweetView)
            tweetView <- [
                Top(0.0).to(previousItem),
                Left(0.0),
                Right(0.0),
                Height(>=TweetView.minimumHeight)
            ]
            
            // Pins contentView to bottom of the this item
            self.contentView <- [
                Bottom(>=0.0).to(tweetView, .bottom).with(.customPriority(priority))
            ]
            
            // Set properties that apply to next tweetview creation
            previousItem = tweetView
            priority += 1.0
        }
    }
    
}

/**
    Autolayout constraints
 */
extension FeedView {
    
    fileprivate func setup() {
        // Title header
        self.addSubview(self.titleLabel)
        self.titleLabel <- [
            Top(FeedView.headerPadding),
            Size(>=0.0),
            CenterX(0.0)
        ]
        
        // Separator beneath title
        self.addSubview(self.separatorView)
        self.separatorView <- [
            Top(FeedView.headerPadding).to(self.titleLabel),
            Left(0.0),
            Right(0.0),
            Height(1.0)
        ]
        
        // Scroll view
        self.addSubview(self.scrollView)
        self.scrollView <- [
            Top(0.0).to(self.separatorView),
            Left(0.0),
            Right(0.0),
            Bottom(0.0)
        ]
        
        // Content of the scroll
        self.scrollView.documentView = self.contentView
        self.contentView <- [
            Top(0.0),
            Left(0.0),
            Bottom(>=0.0),
            Width(0.0).like(self.scrollView),
            Height(>=0.0)
        ]
    }
    
}
