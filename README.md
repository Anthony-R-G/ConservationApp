# Terra

## Introduction
Note: Still a WIP!

Terra is an iOS application meant to educate people on the biodiversity in the world and the importance of conserving it. Data is packaged from multiple sources, among which include the IUCN and WWF. This is to ensure that information is accurate and up-to-date.

Clicking on any animal brings the user to a page displaying more information about the animal as well as the option to be redirected to a donation page to help support conservation efforts. 

One principle behind the app is keeping the design clean and visually appealing. Learning should be fun! It's hard to feel interested in a subject if it's presented in a way that feels lifeless and drab. Additionally, mobile apps are unique in that they enable you to interact directly with your content. Because of that, an app should package content in such a way that there's preference to use it and not simply get the data from a web browser.

## Technologies 
Written in Swift

UIKit (programmatic, no Storyboards)

MapKit

CocoaPods 

Google's Firebase is used as the backend. Writing to Firebase is managed via a [separate helper app](https://github.com/Anthony-R-G/Terra-Data-Upload-Helper).

Coming:

CoreLocation (for determining your position relative to a species habitat range)

ARKit (some animals will have the option to "View in AR" which will bring up a 3D model that can be placed and manipulated using iPhone's rear camera.)

## Screenshots

### List Page
List of animal species, separated by Red List conservation levels:

|  |  |  
|:-----:|:-------:|
|![screen 1](https://i.imgur.com/h36QYDc.png) | ![screen 2](https://i.imgur.com/ur4JDNq.png) 

Tapping any one cell will transition to a new page with a minimalistic user interface where the species you've selected is put at the forefront:

### Individual Species Page 
| Amur Leopard | Blue Whale | Lion | Mountain Gorilla |
|:-----:|:-------:|:-------:|:-------:|
|![screen 1](https://i.imgur.com/4LOHr9o.png) | ![screen 2](https://i.imgur.com/E4Ayd80.png) |![screen 3](https://i.imgur.com/h6s1IGG.png)|![screen 4](https://i.imgur.com/HEA6LRg.png)|


Scrolling up on this page will bring up an overview of the species. You can then swipe left and right or use the buttons on the bottom bar to get information snippets on that specific species such as the current threats to its population. Each panel also has it's own "Learn More" button to transition to a full-sized screen with even more data such as taxonomy and distribution. 

### Getting Detailed Information
| African Elephant Overview | Blue-throated Macaw Habitat | Blue-throated Macaw Distribution | Panamanian Golden Frog Distribution |
|:-----:|:-------:|:-------:|:-------|
|![screen 1](https://i.imgur.com/G2HG7Ju.png) | ![screen 2](https://i.imgur.com/gAL8twq.png) |![screen 3](https://i.imgur.com/Ueikygo.png)|![screen 4](https://i.imgur.com/fz7PtXS.png)|

You can show your support for animal conservation efforts by clicking on the donate button. This will redirect you in-app to the relevant conservation for that specific animal. This makes it easy to get involved.

### Donating
| African Elephant Donation |Bornean Orangutan Donation | Great White Shark Donation |
|:-----:|:-------:|:-------:|
|![screen 1](https://i.imgur.com/SvsfysX.png) | ![screen 2](https://i.imgur.com/3x6d1IV.png) | ![screen 3](https://i.imgur.com/5rljCyK.png)



