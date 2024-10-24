# Points-of-Interests-GoogleMap

This Flutter application shows nearby bars and allows users to search for bars based on the current map center. It integrates Google Maps and uses location services to track the user's location.

## Prerequisites
Ensure that the following tools are installed on your development machine:

Flutter: You need Flutter SDK installed. 

Xcode (for iOS development): Install Xcode from the Mac App Store if you're building for iOS.

Android Studio (for Android development): You need Android Studio with the Android SDK set up for Android development.

## Dependencies

* Required Packages:
Run the following command to install the required packages.

```bash 
flutter pub get
```

## API Key Setup:

You need to configure the API keys for both Android and iOS.

* Android

Open the file android/app/src/main/AndroidManifest.xml.

Inside the <application> tag, add the following line with your Google Maps API key:

```bash 
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE"/>
```

* iOS

Open the file ios/Runner/AppDelegate.swift (or AppDelegate.m for Objective-C).

Add the following line inside didFinishLaunchingWithOptions:

```bash 
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```


## Building and Running the App

* For both IOS / Android

```bash
flutter run
```

## Implementation Choices

Map Integration: Google Maps was chosen for its extensive feature set 

Geolocator for Location: The geolocator package was chosen for fetching the user's location. It provides an API for requesting location permissions and retrieving location updates.

Google Places API: This was used to fetch the nearby bars by sending requests based on the current map center.

## Conclusion

This Flutter app displays Points of Interest (POIs) around a
user's current or given location within a 1km radius. The app can run on both Android and iOS with minimal platform-specific changes. 
