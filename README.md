# Wikipedia Search App

A native iOS app built with SwiftUI that allows users to search for Wikipedia articles by text or location, displaying results in both list and map views.

## Features

- **Text Search**: Search Wikipedia articles by entering search terms
- **Location Search**: Find nearby Wikipedia articles using device location
- **Dual View Modes**: Switch between list and map views
- **Rich Content**: Display article titles, descriptions, thumbnails, and coordinates
- **Direct Links**: Quick access to full Wikipedia articles
- **Clean UI**: Intuitive, modern SwiftUI interface

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Setup Instructions

### 1. Clone or Download
- Download the project files
- Open `WikipediaSearchApp.xcodeproj` in Xcode

### 2. Configure Project Settings
- Set your development team in Signing & Capabilities
- Ensure deployment target is set to iOS 17.0+

### 3. Update Info.plist
Add location usage descriptions to your `Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses location to find nearby Wikipedia articles</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app uses location to find nearby Wikipedia articles</string>
```
