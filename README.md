<!-- badges: start -->
<!-- badges: end -->

# druid

A logger middleware for [ambiorix](https://ambiorix.dev).

## Installation

``` r
# install.packages("devtools")
devtools::install_github("devOpifex/druid")
```

## Example

Pass the `druid` function to the `use` method.

``` r
library(druid)

library(ambiorix)

app <- Ambiorix$new(log = FALSE)

app$use(
  druid(
    path_info = TRUE,
    remote_port = TRUE
  )
)

app$get("/", \(req, res){
  res$send("Using {ambiorix}!")
})

app$start()
```

