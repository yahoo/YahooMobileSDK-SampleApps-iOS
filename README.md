# Yahoo Mobile SDK Sample App (iOS)

Example applications for iOS that use the Yahoo Mobile SDK.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contribute](#contribute)
- [License](#license)

## Background

The Yahoo Mobile SDK is designed for publishers that are interested in incorporating Inline, Interstitial, and/or Native ads into their mobile applications. The Yahoo Mobile SDK Sample Apps provide examples of how you can integrate the Yahoo Mobile SDK in your app. This repo contains two Sample Apps for iOS, one written in Objective-C and one written in Swift. See the ObjC and Swift directories to find those apps. If you are looking for Android Sample Apps, head over to [YahooMobileSDK-SampleApps-Android](https://github.com/yahoo/YahooMobileSDK-SampleApps-Android).

## Install

If you've never used git before, please take a moment to familiarize yourself with [what it is and how it works](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics). To install this project, you'll [need to have git installed and set up](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) on your local dev environment.

Install by running the following command.

```
git clone https://github.com/yahoo/YahooMobileSDK-SampleApps-iOS.git
```
This will create a directory called YahooMobileSDK-SampleApps-iOS and download the contents of this repo to it.

## Configuration

- If you do not already have Xcode installed, you can download it from the App Store or see [their documentation](https://developer.apple.com/documentation/xcode) for more details.
- The Objective-C app uses CocoaPods. If that is the sample app you plan on using, and if you do not already have CocoaPods installed, see their [Getting Started guide](https://guides.cocoapods.org/using/getting-started.html#getting-started) for details on how to install it.

## Usage

After you've cloned this repo:
1. Open a terminal, cd to where you cloned this repo, cd into either the ObjC or Swift subdirectory.
2. If you are using the Objective-C sample app, run `pod install`.
3. In Finder, navigate to where you cloned this repo, and navigate into either the ObjC or Swift subdirectory.
4. If you are using the ObjC sample app, double-click SampleApp.xcworkspace to open it in Xcode. If you are using the Swift sample app, double-click SampleApp.xcodeproj to open it in Xcode.
5. Click the Run button to run the sample app.

## Contribute

Please refer to [the contributing.md file](Contributing.md) for information about how to get involved. We welcome issues, questions, and pull requests.

## Maintainers

- Eric Stevens: eric.stevens@yahooinc.com

## License

This project is licensed under the terms of the Apache 2.0 open source license. Please refer to [LICENSE](LICENSE) for the full terms.
