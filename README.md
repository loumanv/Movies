# LocalWikipedia

An iPhone app that displays reviews of the most popular movies of the week. The app is written in Swift and supports iOS 11+. Uses Carthage and Alamofire.

The app gets the data from a sample API that is accessible through the endpoint http://s.telegraph.co.uk/tmgmobilepub/articles.json

- On launch the app connects to the sample API to asynchronously get the data
- Presents the movies in tiles and supports both iPhone and iPad in portrait and lanscape.
- When the user taps on a movie it opens the associated website in a SFSafariViewController.
