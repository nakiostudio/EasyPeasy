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

struct TweetModel {
    
    let name: String
    let username: String
    let displayableDate: String
    let tweet: String
    let thumbnail: UIImage?
    
    init(name: String, username: String, displayableDate: String, tweet: String, thumbnail: UIImage?) {
        self.name = name
        self.username = username
        self.displayableDate = displayableDate
        self.tweet = tweet
        self.thumbnail = thumbnail
    }
    
}

extension TweetModel {
    
    static func stubData() -> [TweetModel] {
        let tweetFelix = TweetModel(
            name: "Felix Krause",
            username: "@KrauseFX",
            displayableDate: "30m",
            tweet: "With Fastlane nobody has to deal with xcodebuild anymore. Say goodbye to NSLayoutConstraints thanks to EasyPeasy 🚀",
            thumbnail: UIImage.easy_thumbFelix()
        )
        let tweetEloy = TweetModel(
            name: "Eloy Durán",
            username: "@alloy",
            displayableDate: "1h",
            tweet: "EasyPeasy, best thing since CocoaPods socks were announced!",
            thumbnail: UIImage.easy_thumbEloy()
        )
        let tweetJavi = TweetModel(
            name: "Javi.swift",
            username: "@Javi",
            displayableDate: "2h",
            tweet: "EasyPeasy? another autolayout library? Okay, I can give it a try!",
            thumbnail: UIImage.easy_thumbJavi()
        )
        let tweetNacho = TweetModel(
            name: "NeoGazpatchOS",
            username: "@NeoNacho",
            displayableDate: "4h",
            tweet: "Just discovered EasyPeasy... silly name, great framework #yatusabes",
            thumbnail: UIImage.easy_thumbNacho()
        )
        return [tweetFelix, tweetEloy, tweetJavi, tweetNacho]
    }
    
}
