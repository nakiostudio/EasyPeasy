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

extension NSImage {
    
    func easy_tint(with color: NSColor) -> NSImage? {
        if let image = self.copy() as? NSImage {
            let bounds = CGRect(origin: CGPoint.zero, size: self.size)
            image.lockFocus()
            color.set()
            NSRectFillUsingOperation(bounds, .sourceAtop)
            image.unlockFocus()
            return image
        }
        
        return nil
    }
    
}
