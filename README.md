# ToldSDK

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Prerequisites

Create an account and a survey project on [Told website](https://told.club)

iOS app running Swift 4.0 or above.

## Installation

### 1. Install via Cocoapods

ToldSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToldSDK'
```

### 2. Setup SDK

Call Told init method in AppDelegate.swift :

```swift
//
//  AppDelegate.swift
//

import Told // <-- Import SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        ...
        
        Told.initSDK(projectId: "<projectId>") // <-- Init SDK
        
        return true
    }
    
    ...
}
```

## License

ToldSDK is available under the MIT license. See the LICENSE file for more info.

## Maintainers

Follow this steps to publish a new release :

* Increment version in Told.podspec
* Create a git tag `git tag <version>` and push it with `git push --tags`
* Publish version to Cocoapods : `pod trunk push Told.podspec`
