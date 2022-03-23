# The Carpentries Workbench Documentation

This lesson gives a high-level overview of how you can use The Carpentries
Workbench (our new and improved lesson infrastructure) to build beautiful and
accessible lessons from markdown or RMarkdown sources.

If you want to try out this lesson, you can create a copy of it on the RStudio
Cloud: https://rstudio.cloud/project/3507333

## Setup the Workbench

To build this lesson locally, you should follow the [setup instructions for the
workbench](https://carpentries.github.io/sandpaper-docs/#overview). In short,
make sure you have R, Git, and Pandoc installed, open R and use the following
commands to install/update the packages needed for the infrastructure:

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
   git clone https://github.com/carpentries/sandpaper-docs && cd sandpaper-docs
   ```
 - via R: 
   ```r
   usethis::create_from_github("https://github.com/carpentries/sandpaper-docs/")
   ```

## Build and Preview

Launch R in this folder and use this command to build and preview the lesson

```r
sandpaper::serve()
```

[{sandpaper}]: https://carpentries.github.io/sandpaper/
