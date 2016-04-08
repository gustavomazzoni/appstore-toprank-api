# AppStore Info API
## Goal

Create a REST API that pulls the Apple App Store top lists from US and provides additional metadata information for each of the ids returned via Apple lookup API together with a simple aggregation functionality.

## User Stories

* As a user I want to provide category id and monetization(Free, Paid, Grossing) as an input value and receive top 200 apps ordered by rank position together with the metadata information as a json result (Metadata infor described in Apple Lookup API section)
* As a user I want to input category id, monetization and rank position and receive app data for single application together with the metadata as json result
* As a user I want to provide category id, monetization and receive top publishers rank by the amount of apps available in the top list as a json result. (publisher id, publisher name, rank, number of apps, app names in array)
* As a user I want to be able to access the resources mentioned in points above via REST API

## Guidelines

* Rspec to Test the application (Rspec)
* Minimize the http request calls to api where possible
* Consider as many possible inputs as possible and test for edge cases
* Develop the application using the best software development practices Quality of the code is the key.


## Running the application
### Download the project
Download or clone the project using following command:
```sh
$ git clone https://github.com/gustavomazzoni/appstore-info-api
```

### Run locally
Start the server
```sh
$ rails server
```

### Test the API
#### Top 200 apps
To receive top 200 apps ordered by rank position together with the metadata information as a json result, use the following URL format like:
```sh
http://localhost:3000/api/v1/top_rank?genreId=6001&monetization=Paid&popId=30
```

It is mandatory to inform genreId and monetization params. Monetization and genreId refers to the type of the rank list, where monetization must be 'Paid', 'Free' or 'Top Grossing' and genreId, can be found here:

https://www.apple.com/itunes/affiliates/resources/documentation/genre­mapping.html

#### Apps metadata by rank position
To receive app data for single application at the rank list together with the metadata as json result, use the following URL format like:
```sh
http://localhost:3000/api/v1/top_rank?genreId=6001&monetization=Paid&popId=30&rankPosition=7
```

It is mandatory to inform genreId and monetization params as well as rankPosition param. Rank position refers to the position of the app you want the metadata informations.

#### Apps metadata by rank position
To receive top publishers rank by the amount of apps available in the top list as a json result (with publisher id, publisher name, rank, number of apps, app names in array), use the following URL format like:
```sh
http://localhost:3000/api/v1/top_rank/publishers?genreId=6001&monetization=Paid&popId=30
```

popId param tells if the rank list is for iPhone or iPad, where 47 is for ipad and 30 is for iphone.

