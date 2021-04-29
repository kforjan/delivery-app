# DeliveryApp - Flutter application for making and delivering orders

Flutter application for tracking the delivery of your orders or delivering the orders to the customers.
Main focus was on location tracking and exchanging location data between devices.

## About

The main focus of this project was on location tracking and exchanging location data between devices. The application connects two users and enables the exchange of their current locations with one another. Main communication between devices is achieved with the help of Firebase services. Firebase stores the current location of the delivery every few seconds after it has started and shares it with it's customer whose ID is recorded in the order's information.

## Used packages

* [provider](https://pub.dev/packages/provider)
* [firebase_auth](https://pub.dev/packages/firebase_auth)
* [cloud_firestore](https://pub.dev/packages/cloud_firestore)
* [geolocator](https://pub.dev/packages/geolocator)
* [geodesy](https://pub.dev/packages/geodesy)
* [flutter_map](https://pub.dev/packages/flutter_map)
* [wakeclock](https://pub.dev/packages/wakelock)

## Features

* Selection between delivery or order

###### Order features

* Order selection
* Finding current location
* Once the order is accepted by the delivery, live tracking of the delivery
* Confirming the successful delivery

###### Delivery features

* Selection between all available orders
* Display of order's distance
* Once the order is selected, display of the delivery location

## Setup

  1. Clone the repository using the link below:
  ```
  https://github.com/kforjan/delivery-app.git
  ```
  2. Go to the project root and execute the following commands:
  ```
  flutter pub get
  flutter run
  ```

## Preview

![Preview of both delivery and order device functionality](https://s3.gifyu.com/images/delivery-app-preview.gif)

*note: distance from delivery and delivery location is 0.00km because emulators always have the same coordinates*

## Possible improvements

* Separation in 2 applications
* Recommended route for the delivery
* Location fetching interval regulation
* User account implementation
* Better map providing service

##### Find the full article [here](https://repozitorij.etfos.hr/islandora/object/etfos%3A2627) (in Croatian)
