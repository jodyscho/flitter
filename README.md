# flitter
twitter-ish mock sample project using VIPER

Written in (and may require) Xcode 8.2 / Swift 3

# Logging In
The default credentials are:

username: flitter

password: flitter123!


More users can be added/modified by editing the passwds.plist file in the Resources folder.

I implemented the app with the VIPER architecture. You end up with a lot of classes but each class has a very clear role. Perhaps, if I were to do it again I might have used MVVM, VIP, etc.

I let lower level objects handle the async dispatching and then push to the main thread when UI updates are required. To add a little "realism" to the app I used small timeouts to reflect network delays. I also added a 30% chance that posting a tweet will fail.

I didn't worry about optimizing for performance, i.e. There is no limit on the number of tweets fetched from the network or local data, large arrays of tweets and tweet viewmodels could be passed around.


# Frameworks
Swinject
- Most of the services make use of dependency injection: TweetGateway, UserGateway, TwitterWebservice
- The configurators used to set-up the VIPER modules are also injected so that the view controllers, like the sign in screen, can get it and configure itself. This allows a little more flexibilty because a different configurator to hook-up the UI with a mock presenter for doing screen grabs.

RxSwift/RxCocoa
- used for the sign in screen validation and enablement of the "Sign in" button
- also used for the compose tweet screen (text counter, tweet button enabled, keyboard show/hide)

Realm/RealmSwift
- used to store the current user and the tweets. I ran into some interesting threading issues I wasn't expecting. I still feel couchbase is more flexible.

** I was going to use BrightFutures but decided to stick with callback blocks instead.

# Tests
- The majority of the "business" logic is captured in the interactors/use cases so this is where most of the unit tests focus on. The unit tests where all written before the "production" code.
- Ideally it would have been nice to get a code coverage report and add more unit tests.
