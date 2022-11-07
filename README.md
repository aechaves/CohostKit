# CohostKit

Unofficial API for cohost.org.

Extremely work in progress. Contributions welcome.

## Install

Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) to specify the dependency in `Package.swift` by adding this:

```swift
.package(url: "https://github.com/aechaves/CohostKit.git", .upToNextMajor(from: "1.0.0"))
```

Note: one of our dependencies runs weirdly slow when using a debug configuration, [see their notes about it](https://github.com/krzyzanowskim/CryptoSwift#swift-package-manager). I purposely skip some tests from running in debug mode, but be aware of things running slow when using crypto functions (at least until a figure out a workaround that works for clients of this library)


## Features

- Logging in

## TODOs
- Getting the posts of a project
- Creating a post
- Editing a post
- Sharing a post
- Liking a post
- Getting notifications
- Getting the home feed
- Editing profiles
- Getting followers and following
- Getting bookmarks and bookmarking

## Thanks

- [cohost.js](https://github.com/mogery/cohost.js) and [cohost.py](https://github.com/valknight/Cohost.py): Without their work I would't had cared to figure this out
- [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift): Allows me to generate the magic hash for the login
- [swift-extras-base64](https://github.com/swift-extras/swift-extras-base64.git): Allows me too work around the lack of padding of the base64 encoded salt
- [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs.git): Allows me to stub requests for tests

## Where are you on cohost.org?

[anco](https://cohost.org/anco)
