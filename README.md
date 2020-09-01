# AlamofireSwiftSoup

[![Build Status](https://github.com/aporat/AlamofireSwiftSoup/workflows/Tests/badge.svg)](https://github.com/aporat/AlamofireSwiftSoup/actions)
[![Cocoapods](https://img.shields.io/cocoapods/v/AlamofireSwiftSoup.svg)](https://cocoapods.org/pods/AlamofireSwiftSoup)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

## Installation

The recommended approach for installing AlamofireSwiftSoup is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Edit your Podfile and add `AlamofireSwiftSoup`:

``` bash
$ edit Podfile
platform :ios, '12.0'

pod 'AlamofireSwiftSoup'
```

Install into your Xcode project:

``` bash
$ pod install
```

## Usage
```swift
import AlamofireSwiftSoup
```

```swift
AF.request("https://httpbin.org/").responseSwiftSoupHTML { dataResponse in
  switch dataResponse.result {
  case .failure(let error):
    debugPrint(error)
  case .success(let document):
    if let scriptElement = try? document.select("title").first(), let titleString = try? scriptElement.html() {
      debugPrint(titleString)
    }
  }
}

```
