# CryptoKit 🔑
[![Build Status](https://travis-ci.org/chrisamanse/CryptoKit.svg?branch=master)](https://travis-ci.org/chrisamanse/CryptoKit)
![Swift Version](https://img.shields.io/badge/swift-3.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![spm compatible](https://img.shields.io/badge/spm-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CryptoKit.svg)](https://github.com/CocoaPods/CocoaPods)
![Platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20tvos%20%7C%20watchos%20%7C%20linux-lightgrey.svg)


A Swift framework containing implementations of cryptographic functions.

## Features

### Hashing Algorithms

- [x] MD5
- [x] SHA-1
- [x] SHA-224
- [x] SHA-256
- [x] SHA-384
- [x] SHA-512

### HMAC (Hash-based Message Authentication Code)

- [x] HMAC (using any of the implemented hash functions)

# Usage

Try **CryptoKit** API right now in [IBM Swift Sandbox](https://swiftlang.ng.bluemix.net/#/repl?gitPackage=https:%2F%2Fgithub.com%2Fchrisamanse%2FCryptoKit-Sample&swiftVersion=latest).

## Hash / Digest

```swift

let message = "The quick brown fox jumps over the lazy dog".data(using: .utf8)!

let hash = message.digest(using: .sha256) // Supports MD5, SHA-1 and SHA-2 variants

```

## HMAC

```swift

let hmac = HMAC(key: secret, message: message, hashFunction: .sha1)

```

# License

Copyright (c) 2016 Joe Christopher Paul Amanse

This software is distributed under the [MIT License](./LICENSE).
