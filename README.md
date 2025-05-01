# AlamofireSwiftSoup

A lightweight extension that combines [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftSoup](https://github.com/scinfu/SwiftSoup) for easy HTML parsing from web requests.

> ✅ Written in Swift 5.9 — designed for iOS, macOS, and tvOS projects

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