# Terra

## Introduction
Note: Still a WIP!

Terra is an iOS application meant to educate people on the biodiversity in the world and the importance of conserving it. Data is packaged from multiple sources, among which include the IUCN and WWF. This is to ensure that information is accurate and up-to-date.

Clicking on any animal brings the user to a page displaying more information about the animal as well as the option to be redirected to a donation page to help support conservation efforts. 

One principle behind the app is keeping the design clean and visually appealing. Learning should be fun! It's hard to feel interested in a subject if it's presented in a way that feels lifeless and drab. 

## Technologies 
Written in Swift using UIKIt

CocoaPods 

Google's Firebase is used as the backend. Writing to Firebase is managed via a [separate helper app](https://github.com/Anthony-R-G/Terra-Data-Upload-Helper).

Coming:

CoreLocation (for determining your position relative to a species habitat range)

ARKit (some animals will have the option to "View in AR" which will bring up a 3D model that can be placed and manipulated using iPhone's rear camera.)

## Screenshots
List of animal species, separated by Red List conservation levels:

![Example 1](https://i.imgur.com/QJb4S1d.png)

Tapping any one cell will bring up a new page with more information about the animal:

![Example 2](https://i.imgur.com/2FBgKyC.png)


![Example 3](https://i.imgur.com/rO4OsTG.png)
