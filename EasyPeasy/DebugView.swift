// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) || os(tvOS)

import UIKit
    
/**
     `UIView` in which some `Attributes` will be drawn based on the absolute 
     position of the relative `createItem` and `referenceItem` views.
 */
internal class DebugView: UIView {
    
    /// `Attributes` to be drawn, this array might include inactive ones
    private(set) var attributes: [Attribute] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    // MARK: Overriden methods
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // Common context attributes
        context.setLineWidth(1.0)
        context.setLineDash(phase: 0.0, lengths: [2.0, 2.0])
        
        // Draw Attributes added to the DebugView
        for attribute in self.attributes {
            // Only draw active Attributes
            guard attribute.shouldInstall() else {
                continue
            }
            
            //
            var referenceMidPoint: CGPoint?
            if let referenceView = attribute.referenceItem as? UIView {
                let referenceAttribute = attribute.referenceAttributeHelper()
                let path = referenceView.path(for: referenceAttribute, extended: true)
                // Draw
                context.setStrokeColor(UIColor.orange.cgColor)
                context.addPath(path.cgPath)
                context.strokePath()
                
                // Do not store referenceMidPoint for Width or Height attributes
                if !(attribute is Width || attribute is Height) {
                    referenceMidPoint = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
                }
            }
            
            if let createView = attribute.createItem as? UIView {
                let createAttribute = attribute.createAttribute
                let path = createView.path(for: createAttribute, extended: false)
                
                // Draw
                context.setStrokeColor(UIColor.blue.cgColor)
                context.addPath(path.cgPath)
                context.strokePath()
                
                // Draw segment between reference Attribute and create Attribute
                let midPoint = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
                if var referenceMidPoint = referenceMidPoint, referenceMidPoint.x != midPoint.x && referenceMidPoint.y != midPoint.y {
                    let isVerticalLine = path.bounds.width == 0
                    let midPoint = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
                    referenceMidPoint.x = isVerticalLine ? referenceMidPoint.x : midPoint.x
                    referenceMidPoint.y = isVerticalLine ? midPoint.y : referenceMidPoint.y
                    
                    // Draw
                    context.saveGState()
                    context.move(to: midPoint)
                    context.addLine(to: referenceMidPoint)
                    context.setStrokeColor(UIColor.red.cgColor)
                    context.setLineDash(phase: 0.0, lengths: [])
                    context.strokePath()
                    context.restoreGState()
                }
            }
        }
    }
   
    // MARK: Public methods
    
    /**
        Adds an `Attribute` to the array of `Attributes` to be drawn
        - parameter attribute: Attribute to be drawn
     */
    func show(attribute: Attribute) {
        self.attributes.append(attribute)
        self.setNeedsDisplay()
    }
    
    // MARK: Private methods
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
        
        // Add double gesture recognizer that triggers redrawing
        let doubleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didPerformMultipleTap(gestureRecognizer:)))
        doubleGestureRecognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleGestureRecognizer)
        
        // Add triple gesture recognizer that dismissed the view
        let tripleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didPerformMultipleTap(gestureRecognizer:)))
        tripleGestureRecognizer.numberOfTapsRequired = 3
        self.addGestureRecognizer(tripleGestureRecognizer)
    }
    
    func didPerformMultipleTap(gestureRecognizer: UITapGestureRecognizer?) {
        if gestureRecognizer?.numberOfTapsRequired == 3 {
            self.removeFromSuperview()
        }
        else if gestureRecognizer?.numberOfTapsRequired == 2 {
            self.setNeedsDisplay()
        }
    }

    // MARK: Static methods
    
    /**
        Static methods that finds an existing `DebugView` on the
        main window or creates a new one and adds an `Attribute`
        to be drawn.
        - parameter attribute: `Attribute` to be added to the
        `DebugView`
     */
    static func show(attribute: Attribute) {
        DebugView.findOrCreate()?.show(attribute: attribute)
    }
    
    private static func findOrCreate() -> DebugView? {
        // Return if there is no key window
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return nil
        }
        
        // If there is a `DebugView` on the view hierarchy return it
        if let debugView = (keyWindow.subviews.filter { $0 is DebugView }).first as? DebugView {
            return debugView
        }
        
        // Otherwise create a new one and add to the key window
        let debugView = DebugView(frame: CGRect.zero)
        debugView.frame = keyWindow.bounds
        debugView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        keyWindow.addSubview(debugView)
        
        return debugView
    }
    
}
    
/**
     Helper methods to create the path for the given `ReferenceAttributes`
 */
internal extension Item {
    
    /// `CGRect` relative to the key window
    var absoluteRect: CGRect {
        return self.owningView?.convert(self.frame, to: nil).integral ?? CGRect.zero
    }
    
    /**
        Given a `ReferenceAttribute` creates the correspondent bezier path
        - parameter referenceAttribute: ReferenceAttribute which path will be drawn
        - parameter extended: Boolean that indicates whether the path must be limited to 
        current `Item` bounds
        - return: `UIBezierPath` that is going to be drawn
     */
    func path(for referenceAttribute: ReferenceAttribute, extended: Bool) -> UIBezierPath {
        // The current item is the reference view when extended is set to false, otherwise
        // the owning view will be the reference view
        guard let referenceView = (extended ? self.owningView : (self as? View)) else {
            return UIBezierPath()
        }
        
        let referenceViewFrame = referenceView.absoluteRect
        let viewFrame = self.absoluteRect
        let bezierPath = UIBezierPath()
        
        // Add line points depending on `ReferenceAttribute` type
        switch referenceAttribute {
        case .left, .leading, .leftMargin, .leadingMargin:
            bezierPath.move(to: CGPoint(x: viewFrame.minX, y: referenceViewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: viewFrame.minX, y: referenceViewFrame.maxY))
        case .right, .trailing, .rightMargin, .trailingMargin:
            bezierPath.move(to: CGPoint(x: viewFrame.maxX, y: referenceViewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: viewFrame.maxX, y: referenceViewFrame.maxY))
        case .top, .topMargin, .firstBaseline:
            bezierPath.move(to: CGPoint(x: referenceViewFrame.minX, y: viewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: referenceViewFrame.maxX, y: viewFrame.minY))
        case .bottom, .bottomMargin, .lastBaseline:
            bezierPath.move(to: CGPoint(x: referenceViewFrame.minX, y: viewFrame.maxY))
            bezierPath.addLine(to: CGPoint(x: referenceViewFrame.maxX, y: viewFrame.maxY))
        case .centerX, .centerXWithinMargins:
            bezierPath.move(to: CGPoint(x: viewFrame.midX, y: referenceViewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: viewFrame.midX, y: referenceViewFrame.maxY))
        case .centerY, .centerYWithinMargins:
            bezierPath.move(to: CGPoint(x: referenceViewFrame.minX, y: viewFrame.midY))
            bezierPath.addLine(to: CGPoint(x: referenceViewFrame.maxX, y: viewFrame.midY))
        case .width:
            bezierPath.move(to: CGPoint(x: referenceViewFrame.minX, y: viewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: referenceViewFrame.maxX, y: viewFrame.minY))
        case .height:
            bezierPath.move(to: CGPoint(x: viewFrame.minX, y: referenceViewFrame.minY))
            bezierPath.addLine(to: CGPoint(x: viewFrame.minX, y: referenceViewFrame.maxY))
        }
        
        return bezierPath
    }
    
}
    
#endif
