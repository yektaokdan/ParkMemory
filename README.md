# Car Parking Location Saver

## Summary

This project is an iOS application that allows users to save the location where they parked their car and list these saved locations.

## Features

- **Map Integration**: Displays the user's current location on a map and allows them to save their parking spot.
- **Parking Spot List**: Lists all saved parking spots in a table view.
- **Pin Management**: Adds and removes pins on the map corresponding to the saved parking spots.
- **Navigation**: Provides driving directions to saved parking spots via the Maps app.

## Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-repository/car-parking-location-saver.git
    ```
2. **Open the project in Xcode**:
    ```sh
    cd car-parking-location-saver
    open CarParkingLocationSaver.xcodeproj
    ```
3. **Install dependencies** (if any, e.g., via CocoaPods):
    ```sh
    pod install
    ```
4. **Run the app on a simulator or device**.

## Usage

1. **Save Parking Spot**:
   - Open the app and allow location permissions.
   - Tap the "Save My Location" button to save your current parking spot.
   
2. **View Saved Parking Spots**:
   - Navigate to the Locations tab to view the list of saved parking spots.
   - Tap on a parking spot to see it on the map.
   
3. **Delete Parking Spot**:
   - Swipe left on a parking spot in the list and tap delete to remove it.

## Code Structure

- **MapViewVC**: Handles the map view and saving parking spots.
- **LocationsVC**: Manages the list of saved parking spots.
- **MapVM**: ViewModel for handling location updates and storage.
- **LocationsViewModel**: ViewModel for managing the list of saved parking spots.

## Notifications

- **didSaveLocation**: Triggered when a new parking spot is saved.
- **didDeleteLocation**: Triggered when a parking spot is deleted.

## Titles and Subtitles

**Title 1**: Effortlessly Save Your Parking Spot
**Subtitle 1**: Never lose track of where you parked your car again with our easy-to-use app.

**Title 2**: Simplify Your Parking Experience
**Subtitle 2**: Save, view, and navigate to your parking spots with just a few taps.
