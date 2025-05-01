# AlamofireSwiftSoup

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Faporat%2FAlamofireSwiftSoup%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/aporat/AlamofireSwiftSoup)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Faporat%2FAlamofireSwiftSoup%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/aporat/AlamofireSwiftSoup)
![GitHub Actions Workflow Status](https://github.com/aporat/AlamofireSwiftSoup/actions/workflows/ci.yml/badge.svg)

[![codecov](https://codecov.io/gh/aporat/AlamofireSwiftyJSON/graph/badge.svg?token=YYQOZL6W2K)](https://codecov.io/gh/aporat/AlamofireSwiftyJSON)

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
