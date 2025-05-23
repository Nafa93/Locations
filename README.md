# Locations

Since the core of the application is the search feature, I'm going to do an investigation about which algorithms/data structures are best suited for solving this issue, i'm going to try at least three candidates and benchmark them against swift built-in functions.

``` dataSet.filter { $0.lowercased().hasPrefix(searchTerm.lowercased()) } ```

After all my research I came to the concluse that a ternary search tree was the best solution, it takes just a bit more time to load that a trie but after that it usually outperforms it.

I included a benchmarker class that helps testing the performance so you can try it out if you want.

I also made all three searching algorightms conform to a protocol so you can quickly change the implementation and see how it works on the app.

For the architecture I went with MVVM since that's the one that I think works best with SwiftUI in my experience. I also swapped SwiftUI's navigation with UIKit's and introduced coordinators to be able to pass that into the view models.

I got around 80% code coverage, I think that's the sweetspot because in order to get 100% you end up testing a few things that aren't as necessary. I think there could be a few more tests that could be good additions but I ran out of time.

I added a few UI tests to automate the most important features.

Finally I create a workflow in github to run the tests on each commit to main.
