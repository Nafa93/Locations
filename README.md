# Locations

Since the core of the application is the search feature, I'm going to do an investigation about which algorithms/data structures are best suited for solving this issue, i'm going to try at least three candidates and benchmark them against swift built-in functions.

``` dataSet.filter { $0.lowercased().hasPrefix(searchTerm )} ```

After that I'm going to decide how to load the data set into the app to make it as responsive as posible

