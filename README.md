# Terra

### Status: 
*Active. Planned September release.*


## Introduction

•It's estimated that [by 2100, 50% of life on Earth could become extinct](https://www.worldanimalprotection.ca/news/climate-change-silent-terminator-could-make-50-worlds-species-go-extinct-2100). 

•Biodiversity is what makes Earth special, and is absolutely worth preserving. No child in the distant future should have to sit and wonder what a Lion was like.

•Extinction is as old as life itself. But the current extinction crisis is largely our own doing.

•A lot of people might not understand this, or know how they can get involved. But a lot of people *do* have smartphones.

•Terra is an iOS app that attempts to make this information accessible. 

•Data is packaged from multiple sources, among which include the [International Union for Conservation of Nature](https://www.iucnredlist.org/) and [World Wide Fund for Nature](https://www.worldwildlife.org/). This is to ensure that the data is accurate and up-to-date.

•Tapping on any animal transitions to a new page where you can learn more about that animal, including its habitat and the current population threats it faces.

•Each page also has a large donation button which redirects you in-app to a conservation/project for that specific animal. You can then opt to donate.

•One major design principle behind the app is keeping the look of it clean, accessible, and visually appealing.

•Studies have shown the importance of imagery in the learning process. Interest wanes if the topic is presented dryly with minimal stimulation. 

•Using a phone is a more intimate experience than using a computer browser. An app should package content in such a way that there's preference to use it as opposed to just getting the data from a website. 


## Technologies 

•[Swift 5](https://docs.swift.org/swift-book/)

•[UIKit](https://developer.apple.com/documentation/uikit)

•[Safari Services](https://developer.apple.com/documentation/safariservices)

•[Combine](https://developer.apple.com/documentation/combine)

•[Mapbox](https://www.mapbox.com/)

•[CocoaPods](https://cocoapods.org/) 

•[JSON/REST API](https://newsapi.org/)

•[Firebase](https://firebase.google.com/) is used as the backend. Writing to Firebase is managed via a [separate helper app](https://github.com/Anthony-R-G/Terra-Data-Upload-Helper).

Planned:

•[ARKit](https://developer.apple.com/augmented-reality/) (some animals will have the option to "View in AR" which will use iPhone's rear camera for plane detection. Tapping on the screen will place a 3D model at that position and the model can then be manipulated with gestures.)

## App Demo

•There are two main pages: the page containing the list of threatened animals, and a page that has recent wildlife & conservation-related news updates.

•On launch, the list of threatened animals is presented.

### Threatened Species List Page
| See All Species | Filtered By Critical Status | Filtered by Endangered Status | Filtered by Vulnerable Status |
| :-----: | :-----: | :-----: | :-----: |
|![screen 1](https://i.imgur.com/8c4jYoM.png) | ![screen 2](https://i.imgur.com/9dRdea4.png) | ![screen 3](https://i.imgur.com/u9Ezqte.png) | ![screen 4](https://i.imgur.com/av5CRZp.png) |

•This page contains a list of animals that are currently considered threatened. 

•The main three categories are: Critically Endangered, Endangered, and Vulnerable. 

•This system comes from the [IUCN Red List of Threatened Species](https://www.sanbi.org/skep/the-iucn-red-list-explained/), and is intended to be an easily and widely understood system for classifying species at high risk of global extinction.

•Each row contains the animal's common name, scientific name, conservation status, and the estimated population number according to the most recent census.

•Tapping any one row transitions to an individual page for that specific animal to read more about in-depth.

•Alternatively, tapping the earth glyph to the left of the title label presents the Map Exploration page.


## Map Exploration 

•Using Mapbox, this page is intended to be an alternative involved way to discover animals by panning around an interactive world map.

•The map has coordinates of each animal placed in the area they live. (Note: this will be updated to encompass larger polygon regions since not every species has one specific coordinate they reside in)

•Each coordinate annotation can be tapped to reveal a custom popup view..

•The popup displays information such as the animal's name, a small habitat summary, the distance that animal is away from you (if location access is granted), and will enable you to visit that animal's specific detail page.

•There are two map options: a default satellite street style map and a custom-made hypsometric map to see color-coordinated 3D elevation levels.

| Blue-Throated Macaw | Bornean Orangutan | Cheetah Hypsometric | Great White Shark |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/ZHzTsSj.png) | ![screen 2](https://i.imgur.com/F0eVnTl.png) |![screen 3](https://i.imgur.com/jD50BwP.png)|![screen 4](https://i.imgur.com/O8uLfRB.png)|



### News Updates Page
| Browsing | Selecting An Article | Sharing | 
| :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/ca2YBi4.png) | ![screen 2](https://i.imgur.com/kqGRs4a.png) | ![screen 3](https://i.imgur.com/pE02PJf.png) |

•The second tab on the home screen, this page gets data from [NewsAPI](https://newsapi.org/) with the endpoint specifically tailored for wildlife/animal conservation related news. 

•Each row can be tapped to read the article at its source. 

•Each row also has a share button, which can be used to share the website URL with others.

•Pagination is handled by using [Apple's data source prefetching protocol](https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching/prefetching_collection_view_data) so that more news articles are loaded in the background as the page is scrolled down.

![gif 1](https://media.giphy.com/media/QZPEvTdxH70KeocD3g/giphy.gif)



### Learn More About An Individual Species

| Amur Leopard | Blue-throated Macaw | Lion | Mountain Gorilla |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/Jpp3VVL.png) | ![screen 2](https://i.imgur.com/1gqqfCz.png) |![screen 3](https://i.imgur.com/zE7he7a.png)|![screen 4](https://i.imgur.com/mJ9PFDR.png)| 

•Each animal has its own cover page when selected from the list or map.

•Swiping up on this page will expand it and present different reading options, such as Overview or Threats.

•Selecting any of the panels will animate the transition to a full-sized screen that lays information out in digestible snippets.

•Blur effects and light transparency are used so that the color from the background image leaks through, making each page feel more aesthetically unique. 

![gif 1](https://media.giphy.com/media/hs0ClwPZRKGOw4UPy3/giphy.gif)
![gif 2](https://media.giphy.com/media/WTFRv9qAXxonVmHHA7/giphy.gif)



| African Elephant Overview | Cheetah Threats | Giant Panda Habitat | Panamanian Golden Frog Overview |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/DE3YgcR.png) | ![screen 2](https://i.imgur.com/oRbQb09.png)|![screen 3](https://i.imgur.com/u3WSaCo.png)| ![screen 4](https://i.imgur.com/w3KIQ5g.png) |

|  |  |  |  |
| :------: | :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/J7B6zjK.png) | ![screen 2](https://i.imgur.com/Vwy9Nde.png)|![screen 3](https://i.imgur.com/djh4zT8.png)| ![screen 4](https://i.imgur.com/KxWxo9o.png) |


### Donating
![screen 1](https://media.giphy.com/media/TdRL73btVxWARhxpVO/giphy.gif)

•You can show your support for animal conservation efforts by tapping on the large donate button found on every individual animal's page. 

•This will redirect you in-app to the relevant conservation/project for that specific animal. Getting involved is just a tap away.

| Bornean Orangutan Donation |Chimpanzee Donation| Great White Shark Donation | Hawksbill Sea Turtle Donation |
| :------: | :------: | :------: | :------: |
| ![screen 1](https://i.imgur.com/BtBjJTR.png) | ![screen 2](https://i.imgur.com/Ate9yTH.png)|![screen 3](https://i.imgur.com/wmRY7AW.png) | ![screen 4](https://i.imgur.com/5d1oMOj.png) |



### Device/iOS Version Support

•Minimum iOS Version: iOS 13

•Terra supports all current iPhone screen layouts. 

•iPad version not yet planned.

| iPhone SE | iPhone 8 | iPhone 7 Plus | iPhone X/Pro |
| :------:| :------: | :------: | :------: |
|![screen 1](https://i.imgur.com/CHy828U.png) | ![screen 2](https://i.imgur.com/qiwq7yV.png)| ![screen 3](https://i.imgur.com/IwewYsE.png) |![screen 4](https://i.imgur.com/WyXPu6l.png)|

