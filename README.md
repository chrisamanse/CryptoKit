# CryptoKit 🔑
[![Build Status](https://travis-ci.org/chrisamanse/CryptoKit.svg?branch=master)](https://travis-ci.org/chrisamanse/CryptoKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


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

## Hash / Digest

```swift

let message = "abc".data(using: .utf8)!

let hash = message.digest(using: .sha256) // Supports MD5, SHA-1 and SHA-2 variants

```

# License

Copyright (c) 2016 Joe Christopher Paul Amanse

This software is distributed under the [MIT License](./LICENSE).
