---
title: "Creating a New Lesson"
teaching: 5
exercises: 0
---

:::::::::::::::::::: questions

 - What command do you use to create a new lesson?
 - How do you add a new episode?

::::::::::::::::::::::::::::::

:::::::::::::::::::::: objectives

 - Remember the command to create new lessons

:::::::::::::::::::::::::::::::::

So you want to bootstrap a new lesson? You've come to the right place! If you
want to edit an existing lesson, [advance ye to the next episode, 
partner!](editing.html). 

To bootstrap a new lesson, you need three things:

1. The [R with the {sandpaper} package (and pandoc)](setup.html)
2. A place where you want your lesson to live on your computer (e.g 
   `~/Documents/Lessons/`)
3. A lesson name (e.g. `r-penguins`)

Once you have these, you can open RStudio (or your preferred R interface of 
choice) and type the following command:

```r
sandpaper::create_lesson("~/Documents/Lessons/r-penguins/")
```

From here, a new lesson will be created at `~/Documents/Lessons/r-penguins/` and
if you are using RStudio, a new RStudio session will be launched, or if you are
using your own interface, the working directory will automatically change to 
the new lesson.

:::::::::::::::::::::::::: callout

### Batteries Included!

Even if you do not have git on your computer, the lesson will be initialized as
a git repository. If you want to connect your lesson to your github account, you
can use the following command inside your lesson:

```r
usethis::use_github()
```

This will create a github repository for your lesson and will guide you to set
up your credentials if you don't have them set up already.

::::::::::::::::::::::::::::::::::

In the next episode, you can [find out how to add new episodes to your lesson](editing.html#create-episode).

::::::::::::::::::::: keypoints

 - Use the command `sandpaper::create_lesson("/path/to/dir")` to create a new lesson.

:::::::::::::::::::::::::::::::
