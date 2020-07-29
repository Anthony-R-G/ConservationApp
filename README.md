# Terra

## Introduction
Note: Still a WIP!

Terra is an iOS application meant to educate people on the biodiversity in the world and the importance of conserving it. Data is packaged from multiple sources, among which include the IUCN and WWF. This is to ensure that information is accurate and up-to-date.

Clicking on any animal brings the user to a page displaying more information about the animal as well as the option to be redirected to a donation page to help support conservation efforts. 

One principle behind the app is keeping the design clean and visually appealing. Learning should be fun! It's hard to feel interested in a subject if it's presented in a way that feels lifeless and drab. Additionally, mobile apps are unique in that they enable you to interact directly with your content. Because of that, an app should package content in such a way that there's preference to use it and not simply get the data from a web browser.

## Technologies 
Written in Swift using UIKIt

CocoaPods 

Google's Firebase is used as the backend. Writing to Firebase is managed via a [separate helper app](https://github.com/Anthony-R-G/Terra-Data-Upload-Helper).

Coming:

CoreLocation (for determining your position relative to a species habitat range)

ARKit (some animals will have the option to "View in AR" which will bring up a 3D model that can be placed and manipulated using iPhone's rear camera.)

## Screenshots
List of animal species, separated by Red List conservation levels:

![Example 1](https://i.imgur.com/qI0W18I.png)

Tapping any one cell will transition to a new page where the species you've selected is put at the forefront:

![Example 2](https://i.imgur.com/PPx1lXy.png)


![Example 3](https://i.imgur.com/fsasSpG.png)


Scrolling up on this page will bring up an overview of the species. You can then swipe left and right or use the buttons on the bottom bar to get other information on the species such as the threats that it faces at the moment. Each panel also has it's own "Learn More" button to transition to a full-sized screen. 

![Example 4](https://i.imgur.com/ZGcKpU1.png)

You can show your support for animal conservation efforts by clicking on the donate button. This will redirect you in-app to the relevant conservation for that specific animal. This makes it easy to get involved.

![Example 5](https://i.imgur.com/XABKk0Q.png)

![Example 6](https://i.imgur.com/o26bLy6.png)
