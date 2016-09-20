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

class SideBarView: NSView {
    
    fileprivate lazy var profileImageView: NSImageView = {
        let imageView = NSImageView(frame: CGRect.zero)
        return imageView
    }()
    
    fileprivate lazy var composeImageView: NSImageView = {
        let composeImageView = NSImageView(frame: CGRect.zero)
        return composeImageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.easy_backgroundBlue().setFill()
        NSRectFill(dirtyRect)
        super.draw(dirtyRect)
    }
    
    override func layout() {
        super.layout()
        self.profileImageView.layer?.cornerRadius = 4.0
        self.profileImageView.layer?.masksToBounds = true
    }
    
    // MARK: Public methods
    
    func configure(with profileImage: String, tabs: String...) {
        self.restore()
        self.profileImageView.image = NSImage(named: profileImage)
        self.composeImageView.image = NSImage(named: "icon-compose")?.easy_tint(with: NSColor.easy_highlightedBlue())
        
        var previousItem: NSView = self.profileImageView
        var color: NSColor = NSColor.easy_highlightedBlue()
        var topPadding: CGFloat = 20.0
        
        // Creates an UImageView per string within tabs array
        for tabImage in tabs {
            // Create tab
            let tab = NSImageView(frame: CGRect.zero)
            tab.image = NSImage(named: tabImage)?.easy_tint(with: color)
            
            // Layout UIImageView
            self.addSubview(tab)
            tab <- [
                Size(33.0),
                CenterX(0.0),
                Top(topPadding).to(previousItem)
            ]
            
            // Set properties that apply to next UIImageView creation
            color = NSColor.easy_blue()
            previousItem = tab
            topPadding = 14.0
        }
    }
    
    // MARK: Private methods
    
    fileprivate func restore() {
        let tabs = self.subviews.filter { $0 !== self.profileImageView  && $0 !== self.composeImageView }
        for tab in tabs {
            tab.removeFromSuperview()
        }
    }
    
}

/**
    Autolayout constraints
 */
extension SideBarView {
    
    fileprivate func setup() {
        // Profile picture
        self.addSubview(self.profileImageView)
        self.profileImageView <- [
            Size(46.0),
            Top(60.0),
            CenterX(0.0)
        ]
        
        // Compose tweet icon
        self.addSubview(self.composeImageView)
        self.composeImageView <- [
            Size(33.0),
            Bottom(20.0),
            CenterX(0.0)
        ]
    }
    
}
