# GPSSecurity

## Why?

The scope of the SDK is to limitate the use of fake GPS positions or mocked position through XCode.  

You can read more in this article: [https://www.albertopasca.it/whiletrue](https://www.albertopasca.it/whiletrue)


## How it works

You can pass the current `CLLocation` to the SDK.  

Every time the SDK receive a new location, save it in the device keychain (*if needed*) and compare to the newest one.  
The data saved locally contains also the timestamp.

If the travel-time distance, calculated using `MKDirections`, from the stored position and the newest position is greater that the latest stored timestamp return basically a `FALSE`.


## Example

**Valid** position example:

```
Location: 45.70 - 9.69 <--- new location
TRAVEL TIME  : 0h : 4 mins <--- travel time
LATEST UPDATE: 0h : 46 mins <--- last updated local position
Can reach this location in a valid time?: true <--- valid
```

**Invalid** position example:

```
Location: 45.47 - 9.19 <--- new location
TRAVEL TIME  : 0h : 56 mins <--- travel time
LATEST UPDATE: 0h : 46 mins <--- last updated local position
Can reach this location in a valid time?: false
```
In this case you're unable to reach the new position in ***46 minutes*** (*if the travel time is 56mins*).


## Limitations

1. Is a simple draft, created quick and dirty. Is suggested and appreciated to **improve** this project and ask for pull requests.  
**I accept Pull Requests only, not ISSUES**.

2. If you **take a flight** to change city, this check obviously fails, the travel-distance is calculated by car (you can change...).  
It should be used as a notificator to inform that something inside your application (or website) is unallowed, not as a strong blocker.


## Requirements

- XCode
- Swift 5
- Cocoapods

## Installation

*GPSSecurity* is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GPSSecurity', git: 'https://github.com/elpsk/GPSSecurity.git'
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How to use:

In your XCode project, simply import the SDK:

`import GPSSecurity`

and wherever you need to check the validity of GPS, call the:

```
GPSValidator().positionValid(currentPosition: yourDeviceLocation) { validLocation in
    print("Valid position?: \(validLocation)")
}
```
Asyncronously returns the validity of your position.

Optionally (else default values are used) you can configure the `GPSValidator(settings: GPSValidatorSettings)` passing a `GPSValidatorSettings`, a configuration model that contains:

- `refreshLocalPositionTime`: the time in hours to refresh the stored data
- `deltaTravelTimeMinutes`: if you want to add more minutes to be more elastic to the returned travel-time
- `travelTransportType`: the type of transport used to calculate the route [MKDirectionsTransportType](https://developer.apple.com/documentation/mapkit/mkdirectionstransporttype) 


#### Note

Is discorageus to call this function on every position changes, because it use the `MKDirections` API to get the travel-time and can be heavy from a network consumption.



## Author

Alberto Pasca, alberto.pasca@gmail.com  


## License

GPSSecurity is available under the MIT license. See the LICENSE file for more info.
