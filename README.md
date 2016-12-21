# flitter
twitter-ish mock sample project using VIPER

Written in (and may require) Xcode 8.2 / Swift 3

# Logging In
The default credentials are:
username: flitter
password: flitter123!

More users can be added/modified by editing the passwds.plist file in the Resources folder.

I implemented the app with the VIPER architecture. You end up with a lot of classes but each class has a very clear role. Perhaps, if I were to do it again I might have used MVVM, VIP, etc.

I let lower level objects handle the async handling and then push to the main thread when UI updates are required. To add a little flavor to the app I used small timeouts to reflect network delays. I also added a 30% chance that posting a tweet will fail.

# Frameworks
Swinject
- Most of the services make use of dependency injection: TweetGateway, UserGateway, TwitterWebservice
- The configurators used to set-up the VIPER modules are also injected

RxSwift/RxCocoa
- used for the sign in screen validation
- also used for the compose tweet screen (text counter, tweet button enabled, keyboard show/hide)

Realm/RealmSwift
- used to store the current user and the tweets

** I was going to use BrightFutures but decided to stick with closures/blocks instead.

# Tests
- The majority of the "business" logic is captured in the interactors/use cases so this is where most of the unit tests focus on. The unit tests where all written before the "production" code.
