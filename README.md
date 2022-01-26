# sandpaper-docs

This is the documentation repository for the [{sandpaper}] R package that will eventually serve as the new lesson template engine for Carpentries Lessons.

If you want to try out this lesson, you can create a copy of it on the RStudio Cloud: https://rstudio.cloud/project/2247061


## Infrastructure Setup

To build this lesson locally, you should follow the [setup instructions for the infrastructure](https://carpentries.github.io/sandpaper-docs/#overview).
In short, make sure you have R, Git, and Pandoc installed, open R and use the
following to install/update the infrastructure:

```r
# register the repositories for The Carpentries and CRAN
options(repos = c(
  carpentries = "https://carpentries.r-universe.dev/",
  CRAN = "https://cran.rstudio.com/"
))

# Install the template packages to your R library
install.packages(c("sandpaper", "varnish", "pegboard", "tinkr"))
```

## Download this lesson from GitHub

There are two ways to download the lesson from github:

 - via the command line: 
   ```
   git clone https://github.com/carpentries/sandpaper-docs && cd sandpaper-docs)
   ```
 - via R: 
   ```r
   usethis::create_from_github()
   ```

## Build and Preview

Launch R in this folder and use this command to build and preview the lesson

```r
sandpaper::serve()
```

[{sandpaper}]: https://carpentries.github.io/sandpaper/
