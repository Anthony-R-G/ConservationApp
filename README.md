# Terra

## Introduction

*Note: Still a WIP!*

*Note: Gifs still need to be updated to match the new design*

•Terra is an iOS application meant to educate people on biodiversity and the importance of conserving it. 

•Data is packaged from multiple sources, among which include the [International Union for Conservation of Nature](https://www.iucnredlist.org/) and [World Wide Fund for Nature](https://www.worldwildlife.org/). This is to ensure that the data is accurate and up-to-date.

•Tapping on any animal brings you to a page where you can learn more about that specific animal. 

•Each page also has a large donation button which, when tapped, will redirect you in-app to a conservation/project for that specific animal. You can then opt to donate.

•One major design principle behind the app is keeping the look of it clean and visually appealing. Information should be interesting!

•Studies have shown the importance of imagery in the learning process. Interest in a subject wanes if it's presented in a way that's unstimulating and flat. 

•The main focus of Terra is the list of threatened animals, so that's what the UI puts at the forefront. This is done through the use of visuals, thin lines, and light blur effects.

•When it comes to UI, it's the little things that matter. This means consistent spacing, color schemes, etc. 

•Using a phone is a more intimate experience than using a computer browser. With that in mind, an app should package content in such a way that there's preference to use it as opposed to just getting the data from a website. 



## Technologies 
•Swift 5

•UIKit

•Safari Services

•Combine

•[Mapbox](https://www.mapbox.com/)

•[CocoaPods](https://cocoapods.org/) 

•JSON/REST API

•[Google's Firebase](https://firebase.google.com/) is used as the backend. Writing to Firebase is managed via a [separate helper app](https://github.com/Anthony-R-G/Terra-Data-Upload-Helper).

Coming:

•ARKit (some animals will have the option to "View in AR" which will use iPhone's rear camera for plane detection. Tapping on the screen will place a 3D model at that position and the model can then be manipulated with gestures.)

## App Demo

•The app will load into the first tab on the bottom tab bar, the Species List page.

### Species List Page
| See All Species | Filtered By Critical Status | Filtered by Endangered Status | Filtered by Vulnerable Status |
| :-----: | :-----: | :-----: | :-----: |
|![screen 1](https://i.imgur.com/HxvBpZt.png) | ![screen 2](https://i.imgur.com/6f0PHHK.png) | ![screen 3](https://i.imgur.com/ntSuVUF.png) | ![screen 4](https://i.imgur.com/ORsMVlO.png) |

•This page contains a list of animals that are currently considered threatened. 

•The main three categories are: Critically Endangered, Endangered, and Vulnerable. 

•This system comes from the [IUCN Red List of Threatened Species](https://www.sanbi.org/skep/the-iucn-red-list-explained/), and is intended to be an easily and widely understood system for classifying species at high risk of global extinction.

•Tapping any one cell will transition to a new individual species page with a minimalistic user interface where the animal selected is the main focus.



### News Page
| Transitioning Between Tabs | Selecting Articles to Read |
| :------: | :------: |
|![screen 1](https://media.giphy.com/media/ieaU0z4wACLIYrWIey/giphy.gif) | ![screen 2](https://media.giphy.com/media/IejPdlUw4B2Yj2cfVp/giphy.gif) |

•Selecting the second tab on the bottom tab bar takes you to a news page. 

•This page gets data from [NewsAPI](https://newsapi.org/) with the endpoint specifically tailored for wildlife/animal conservation related news. 

•Each cell can be pressed to read the article at its source. 

•Pagination is handled by using Apple's data source prefetching protocol so that more news articles are loaded as you scroll down.



### Individual Species Page 
| Amur Leopard | Blue-throated Macaw | Lion | Mountain Gorilla |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/g3PRCTW.png) | ![screen 2](https://i.imgur.com/5lMRdil.png) |![screen 3](https://i.imgur.com/GB0ALHf.png)|![screen 4](https://i.imgur.com/M2Zkcgz.png)| 

•The initial appearance of this page is a cover page for the selected animal with minimal text.

•Scrolling up on this page will adjust the UI to scale/pin to the top and bring up an overview of the species. 

•You can then swipe left and right or use the buttons on the bottom bar to get information snippets on that specific species such as the current threats to its population. 

•Each panel also has it's own "Learn More" button to transition to a full-sized screen with even more data such as taxonomy and distribution. 

•Blur effects and light transparency are used so that the color from the background image leaks through, making each page feel more aesthetically unique. 

![screen 1](https://media.giphy.com/media/iIoxEOe632nhzJz6Lq/giphy.gif)



#### Getting Detailed Information
| African Elephant Overview | Cheetah Threats | Giant Panda Habitat | Panamanian Golden Frog Overview |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/xfVRJuB.png) | ![screen 2](https://i.imgur.com/0W0iTcL.png)|![screen 3](https://i.imgur.com/68puLAh.png)| ![screen 4](https://i.imgur.com/1eR55nK.png) |

|  |  |  |  |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/WMEjkmx.png) | ![screen 2](https://i.imgur.com/N4zgxVn.png)|![screen 3](https://i.imgur.com/qxsmoWP.png)| ![screen 4](https://i.imgur.com/dTLfYtN.png) |


## Map Exploration 

•Tap the globe icon next to the Terra title label to see a fully interactive map using Mapbox SDK that allows you to explore the earth.

•The map has coordinates of each animal placed in the area they live. (Note: this will be updated to encompass larger polygon regions since not every species has one specific coordinate they reside in)

•Each coordinate annotation can be tapped to bring up a callout view.

•The callout view will contain information such as the animal's name, a small habitat summary, the distance that coordinate is away from you (if location access granted), and will enable you to visit that animal's individual species page.

•There are two map options: a default satellite street style map and a custom-made hypsometric map to see color-coordinated 3D elevation levels.

•The purpose of this is to make an alternative fun way to discover animals and feel more immersed in the content.

| Blue-Throated Macaw | Bornean Orangutan | Cheetah Hypsometric | Great White Shark |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/ZHzTsSj.png) | ![screen 2](https://i.imgur.com/F0eVnTl.png) |![screen 3](https://i.imgur.com/jD50BwP.png)|![screen 4](https://i.imgur.com/O8uLfRB.png)|


### Donating
![screen 1](https://media.giphy.com/media/Rm2YUtHLivpcvSU0Yg/giphy.gif)


•You can show your support for animal conservation efforts by clicking on the large donate button found on every animal's page. 

•This will redirect you in-app to the relevant conservation/project for that specific animal. Getting involved is just a tap away.

| Bornean Orangutan Donation |Chimpanzee Donation| Great White Shark Donation | Hawksbill Sea Turtle Donation |
| :------: | :------: | :------: | :------: |
| ![screen 1](https://i.imgur.com/BtBjJTR.png) | ![screen 2](https://i.imgur.com/Ate9yTH.png)|![screen 3](https://i.imgur.com/wmRY7AW.png) | ![screen 4](https://i.imgur.com/5d1oMOj.png) |



### Multiple Screen Size Support

| iPhone SE | iPhone 8 | iPhone 7 Plus | iPhone X/Pro |
| :------:| :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/1VMfpew.png) | ![screen 2](https://i.imgur.com/pMQjM2C.png)| ![screen 3](https://i.imgur.com/VRxmmLU.png) |![screen 4](https://i.imgur.com/ored1J4.png)|

