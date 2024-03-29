# ToldSDK

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Prerequisites

Create an account and a survey project on [Told website](https://told.club)

iOS app running Swift 4.0 or above.

## Installation

### 1. Install package

#### Swift Package Manager (SPM)

To install ToldSDK via SPM, simply add the following URL : `https://github.com/Slaymd/told-ios-sdk.git` to your project dependencies.

#### Cocoapods

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

### Compile app

Please be sure to have the last MacOS and Xcode versions.

Open terminal and install cocoapods package ./Example folder : `pod install`

Open the xworkspace file in the ./Example folder with Xcode : `open ToldSDK.xcworkspace`

In the top bar, select a device and click on the Run arrow icon to start an emulator. More info here : https://developer.apple.com/documentation/xcode/building-and-running-an-app

### Change local/prod/preprod API

In the root SDK file you can change the API version used : `open ./ToldSDK/Classes/Told.swift` :

```swift
let SERVER_API_URL = "https://api.told.club"
let WIDGET_URL = "https://widget.told.club"
```

If you are testing in local, be sure to set your local IP adress and not localhost.

### Changing GraphQL API

You need to re-build apollo graph by :

* Installing Apollo CLI : `swift package --allow-writing-to-package-directory apollo-cli-install`
* Removing old generated files : `rm -rf ./Sources/ToldSDK/Classes/API`
* In root, type following command : `./apollo-ios-cli generate --path ./apollo-codegen-config-spm.json`

### Publish new version

Follow this steps to publish a new release :

* Commit and push your updated codebase on a public repository
* Create a git tag `git tag <version>` and push it with `git push --tags`

#### SPM

* That's it ! 

#### Cocoapods

* Increment version in Told.podspec
* Remove apollo generated files : `rm -rf ./Sources/ToldSDK/Classes/API`
* In root, type following command : `./apollo-ios-cli generate --path ./apollo-codegen-config-cocoapods.json`
* Publish version to Cocoapods : `pod trunk push Told.podspec`

