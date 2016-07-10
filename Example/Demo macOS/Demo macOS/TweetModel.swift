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

struct TweetModel {
    
    let name: String
    let username: String
    let displayableDate: String
    let tweet: String
    
    var thumbnail: NSImage? {
        get {
            return NSImage(named: self.username)
        }
    }
    
    var displayableUsername: String {
        get {
            return "@\(self.username)"
        }
    }
    
    init(name: String, username: String, displayableDate: String, tweet: String) {
        self.name = name
        self.username = username
        self.displayableDate = displayableDate
        self.tweet = tweet
    }
    
}

extension TweetModel {
    
    static func stubData() -> [TweetModel] {
        var tweets: [TweetModel] = []
        
        let tweetPete = TweetModel(
            name: "Peter Steinberger",
            username: "steipete",
            displayableDate: "1h",
            tweet: "My enhance request to incorporate EasyPeasy into UIKit is ready: rdar://27192334"
        )
        tweets.append(tweetPete)
        
        let tweetBen = TweetModel(
            name: "Ben Sandofsky",
            username: "sandofsky",
            displayableDate: "2h",
            tweet: "In 2016, it's nuts to not be using Auto-Layout... in July 2016, it's nuts not" +
            " to be using EasyPeasy"
        )
        tweets.append(tweetBen)
        
        let tweetChris = TweetModel(
            name: "Chris Lattner",
            username: "clattner_llvm",
            displayableDate: "4h",
            tweet: "Wouldn't mind sherlocking this EasyPeasy thing 😄"
        )
        tweets.append(tweetChris)
        
        let tweetOrta = TweetModel(
            name: "Orta Therox",
            username: "orta",
            displayableDate: "4h",
            tweet: "EasyPeasy was nice, aye, but now is rockin' it on OS X too"
        )
        tweets.append(tweetOrta)
        
        let tweetNatasha = TweetModel(
            name: "NatashaTheRobot",
            username: "NatashaTheRobot",
            displayableDate: "5h",
            tweet: "The talk \"Mastering Auto Layout with EasyPeasy\" at @tryswiftnyc is now live!"
        )
        tweets.append(tweetNatasha)
        
        let tweetAsh = TweetModel(
            name: "Ash Furrow",
            username: "ashfurrow",
            displayableDate: "6h",
            tweet: "Cool Auto Layout framework, the creator is not available in button format though... 🙃"
        )
        tweets.append(tweetAsh)
        
        let tweetAndy = TweetModel(
            name: "Andy Matuschak",
            username: "andy_matuschak",
            displayableDate: "7h",
            tweet: "EasyPeasy? hummm... fancy abstraction you should look at"
        )
        tweets.append(tweetAndy)
        
        return tweets
    }
    
}
