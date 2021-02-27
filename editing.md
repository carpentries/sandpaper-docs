---
sandpaper-digest: 8c81e7a19d52477a4a83efc6f4f6aa59
sandpaper-source: /Users/runner/work/sandpaper-docs/sandpaper-docs/episodes/editing.Rmd

title: "Editing a {sandpaper} lesson"
teaching: 5
exercises: 0
---

:::::::::::::::::::: questions

 - How do you download an existing {sandpaper} lesson?
 - What command do you use to preview a lesson?
 
:::::::::::::::::::::::::::::

:::::::::::::::::::: objectives

 - Understand the usage of `usethis::create_from_github()`
 - Understand the process of `sandpaper::build_lesson()`
 - Remember the RStudio keyboard shortcuts and buttons

:::::::::::::::::::::::::::::::


If you want to edit and preview your lesson using {sandpaper}, this is the
episode for you. If you want to create a new lesson, head back to the episode
for [Creating a New Lesson](new-site.html).

## Downloading a Lesson {#create-from-github}

If you are comfortable with git, use this command to clone this repository to
your working directory

```bash
cd ~/Documents/Lessons
git clone https://github.com/zkamvar/sandpaper-docs.git
cd sandpaper-docs
R
```

If you are NOT comfortable with git, you can download with R. First, open 
RStudio and think about where on your computer you want to work on lessons
(e.g. `~/Documents/Lessons`). Once you know this, you can open RStudio and type
in the R console:

```r
usethis::create_from_github("zkamvar/sandpaper-docs", destdir = "~/Documents/Lessons")
```

By default, this will clone the lesson to `~/Documents/Lessons/sandpaper-docs`
and open a new RStudio session inside of the lesson repository.

## Preview Lesson Content {#build-lesson}

To preview the lesson, if you are using RStudio, you can use the keyboard
shortcut <kbd>cmd + shift + B</kbd> (short for **B**uild) OR you can use the
dropdown menu item <kbd>Build > Build All</kbd>. 

If you want to use the R command line, you can preview the lesson with:

```r
sandpaper::build_lesson()
```

The first time you run this, there will be A LOT of output to your console as
the RMarkdown documents are rendered into markdown and then the 
[{varnish} styling template](template.html) is applied. If you run it again, you
will notice that it takes much less time because the RMarkdown documents don't
need to be rebuilt. 


## Adding a new episode {#create-episode}

To add a new episode, you can use the function `sandpaper::create_episode()`.
This will template a {sandpaper} episode in the `episodes/` directory of your
lesson and pre-populate it with objectives, questions, and keypoints. 

After you add your draft of the episode, you need to add it to the `episodes`
section of `config.yaml`. This will be your table of contents. By default, all
of the episodes are rendered in alphabetical order, and the `config.yaml` can
allow you to work on episodes that are not yet ready for production. 

To view your current episode order, you can use:

```r
sandpaper::get_episodes()
```


## Clearing the cache {#reset-site}

If you are working on the lesson and you want to make sure that everything 
renders from scratch, you can reset the site and the markdown cache with one 
command:

```r
sandpaper::reset_site()
```

::::::::::::::::::::: keypoints

 - `usethis::create_from_github()` will download a github repository to your computer
 - `sandpaper::build_lesson()` renders the site and rebuilds any sources that have changed. - RStudio shortcuts are <kbd>cmd + shift + B</kbd> and <kbd>cmd + shift + K</kbd>
 - New episodes can be added with `sandpaper::create_episode()`

:::::::::::::::::::::::::::::::
