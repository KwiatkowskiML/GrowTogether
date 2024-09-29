# Grow Together

A new Flutter project.

## Getting Started

For the web version you need .env in the `web/assets` folder with the following content:
```
GOOGLE_MAPS_API_KEY={YOUR_API_KEY}
```

Where {YOUR_API_KEY} is your Google Maps API key.

## Running
The fronted for the app can be run with
```bash
flutter run
```
and choosing web

or alternatively
```bash
flutter run -d chrome
```
on devices with google chrome

## Testing widgets
Widget designs are tested by running
```bash
flutter run test/{widget_name}_test.dart
```

There is no actual testing, just visual inspection.
