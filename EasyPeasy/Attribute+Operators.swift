// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension Attribute: Equatable { }

/**
     Infix operator which determines whether two Attributes are equal
 */
public func == (lhs: Attribute, rhs: Attribute) -> Bool {
    
    // Create views
    if (lhs.createItem === rhs.createItem) == false {
        return false
    }
    
    // Create attributes
    if lhs.createAttribute.conflictingAttributes.contains(rhs.createAttribute) == false {
        return false
    }
    
    // Reference views
    if (lhs.referenceItem === rhs.referenceItem) == false {
        return false
    }
    
    // Reference attributes
    if lhs.referenceAttribute != rhs.referenceAttribute {
        return false
    }
    
    // Constant
    if lhs.constant.value != rhs.constant.value {
        return false
    }
    
    if lhs.constant.modifier != rhs.constant.modifier {
        return false
    }
    
    // Priorities
    if lhs.priority.layoutPriority() != rhs.priority.layoutPriority() {
        return false
    }
    
    // Conditions
    if lhs.shouldInstall() != rhs.shouldInstall() {
        return false
    }
    
    return true
}

infix operator =~ {}

/**
     Infix operator which determines whether two Attributes conflict
     between them or not
 */
internal func =~ (installed: Attribute, toInstall: Attribute) -> Bool {
    
    // Create views conflict
    if (installed.createItem === toInstall.createItem) == false {
        return false
    }
    
    // Create attributes conflict
    if installed.createAttribute.conflictingAttributes.contains(toInstall.createAttribute) == false {
        return false
    }
    
    // Priorities conflict
    if installed.priority.layoutPriority() != toInstall.priority.layoutPriority() {
        return false
    }
    
    // Conditions conflict
    if installed.shouldInstall() != toInstall.shouldInstall() {
        return false
    }
    
    return true
}
