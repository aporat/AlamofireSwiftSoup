# AlamofireSwiftSoup

A lightweight extension that combines [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftSoup](https://github.com/scinfu/SwiftSoup) for easy HTML parsing from web requests.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Faporat%2FAlamofireSwiftSoup%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/aporat/AlamofireSwiftSoup)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Faporat%2FAlamofireSwiftSoup%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/aporat/AlamofireSwiftSoup)
![GitHub Actions Workflow Status](https://github.com/aporat/AlamofireSwiftSoup/actions/workflows/ci.yml/badge.svg)

[![codecov](https://codecov.io/gh/aporat/AlamofireSwiftyJSON/graph/badge.svg?token=YYQOZL6W2K)](https://codecov.io/gh/aporat/AlamofireSwiftyJSON)
---

## 📦 Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/your-username/AlamofireSwiftSoup.git", from: "1.0.0")
```

And add `"AlamofireSwiftSoup"` to your target dependencies.

---

## ✅ Requirements

- iOS 15+ / macOS 12+ / tvOS 13+
- Swift 5.9+
- Alamofire 5.x
- SwiftSoup 2.x

---

## 🚀 Usage

```swift
import Alamofire
import AlamofireSwiftSoup

AF.request("https://example.com").responseHTML { response in
    switch response.result {
    case .success(let document):
        if let title = try? document.title() {
            print("Page title:", title)
        }
    case .failure(let error):
        print("Failed to parse HTML:", error)
    }
}
```

---

## 📘 How It Works

This package adds a custom Alamofire response serializer that:

1. Downloads HTML content using Alamofire
2. Parses the raw HTML into a `SwiftSoup.Document`
3. Returns the document in the `responseHTML` callback

---

## 📚 Example

```swift
AF.request("https://news.ycombinator.com").responseHTML { response in
    if let document = try? response.result.get() {
        let links = try? document.select("a.storylink")
        links?.forEach { print(try? $0.text()) }
    }
}
```

---

## 🛠 License

MIT License. See [LICENSE](LICENSE) for details.
