# Terra

## Introduction

*Note: Still a WIP!*

•Terra is an iOS application meant to educate people on biodiversity and the importance of conserving it. 

•Data is packaged from multiple sources, among which include the [International Union for Conservation of Nature](https://www.iucnredlist.org/) and [World Wide Fund for Nature](https://www.worldwildlife.org/). This is to ensure that the data is accurate and up-to-date.

•Clicking on any animal brings you to a page where you can learn more about that specific animal. 

•Each page also has a large red donation button that will redirect you to a site to help support conservation efforts. 

•One major design principle behind the app is keeping the look of it clean and visually appealing. Learning should be fun! 

•Studies have shown the importance of imagery in the learning process. Interest in a subject wanes if it's presented in a way that's unstimulating and flat. 

•The main focus of Terra is the list of threatened animals, so that's what the UI puts at the forefront. This is done through the use of visuals, thin lines, and light blur effects.

•Using a phone is a more intimate experience than using a computer browser. With that in mind, an app should package content in such a way that there's preference to use it as opposed to just getting the data from a website. 



## Technologies 
•Swift 5

•UIKit (UI is created programmatically, without Storyboards)

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
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/T51jLj6.png) | ![screen 2](https://i.imgur.com/M4RlzgH.png) | ![screen 3](https://i.imgur.com/5ILSqcp.png) | ![screen 4](https://i.imgur.com/9rsLAt7.png) |

•This page contains a list of animals that are currently considered threatened. 

•The main three categories are: Critically Endangered, Endangered, and Vulnerable. 

•This system comes from the IUCN Red List of Threatened Species, and is intended to be an easily and widely understood system for classifying species at high risk of global extinction.

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
| Amur Leopard | Blue Whale | Lion | Mountain Gorilla |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/4LOHr9o.png) | ![screen 2](https://i.imgur.com/E4Ayd80.png) |![screen 3](https://i.imgur.com/h6s1IGG.png)|![screen 4](https://i.imgur.com/HEA6LRg.png)|

•The initial appearance of this page is a cover page for the selected animal with minimal text.

•Scrolling up on this page will adjust the UI to scale/pin to the top and bring up an overview of the species. 

•You can then swipe left and right or use the buttons on the bottom bar to get information snippets on that specific species such as the current threats to its population. 

•Each panel also has it's own "Learn More" button to transition to a full-sized screen with even more data such as taxonomy and distribution. 

•Blur effects and light transparency are used so that the color from the background image leaks through, making each page feel more aesthetically unique. 

![screen 1](https://media.giphy.com/media/iIoxEOe632nhzJz6Lq/giphy.gif)



#### Getting Detailed Information
| African Elephant Overview | Blue-throated Macaw Habitat | Cheetah Threats | Giant Panda Overview |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/PixInYV.png) | ![screen 2](https://i.imgur.com/nLOVowq.png) |![screen 3](https://i.imgur.com/vD58wua.png)|![screen 4](https://i.imgur.com/idsjgtZ.png)|


## Map Exploration 
*Experimental feature for post v1.0.0*

•A fully interactive map using Mapbox SDK that allows you to explore the earth.

•The map will have the coordinates of each animal placed in the area they live. (Note: this will be updated to encompass larger polygon regions since not every species has one specific coordinate they reside in)

•Each coordinate annotation can be tapped to bring up a callout view.

•The callout view will contain information such as the animal's name, the distance that coordinate is away from you (if location access granted), and will enable you to visit that animal's individual species page.

•There are two map options: a default satellite street style map and a custom-made hypsometric map to see color-coordinated 3D elevation levels.

•The purpose of this is to make an alternative fun way to discover animals and feel more immersed in the content.

| Blue-Throated Macaw | Cheetah | Cheetah Hypsometric | Giant Panda |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/sHmn7Ac.png) | ![screen 2](https://i.imgur.com/yNt86y6.png) |![screen 3](https://i.imgur.com/axdhtdh.png)|![screen 4](https://i.imgur.com/nYUa4EL.png)|


### Donating
![screen 1](https://media.giphy.com/media/Rm2YUtHLivpcvSU0Yg/giphy.gif)


•You can show your support for animal conservation efforts by clicking on the large donate button found on every animal's page. 

•This will redirect you in-app to the relevant conservation/project for that specific animal. Getting involved is just a tap away.

| African Elephant Donation | Bornean Orangutan Donation |Chimpanzee Donation| Great White Shark Donation |
| :------: | :------: | :------: | :------: |
| ![screen 2](https://i.imgur.com/SvsfysX.png) | ![screen 3](https://i.imgur.com/3x6d1IV.png) | ![screen 4](https://i.imgur.com/JxLGNa8.png)|![screen 5](https://i.imgur.com/5rljCyK.png)

