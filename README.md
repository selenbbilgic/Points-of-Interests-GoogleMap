# Points-of-Interests-GoogleMap

This Flutter application shows nearby bars and allows users to search for bars based on the current map center. It integrates Google Maps and uses location services to track the user's location.

## Prerequisites
Ensure that the following tools are installed on your development machine:

Flutter: You need Flutter SDK installed. 

Xcode (for iOS development): Install Xcode from the Mac App Store if you're building for iOS.

Android Studio (for Android development): You need Android Studio with the Android SDK set up for Android development.

## Dependencies

* Run the following command to install the required packages:

```bash
flutter pub get
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
user's current or given location within a 1 km radius. The app can run on both Android and iOS with minimal platform-specific changes. 
