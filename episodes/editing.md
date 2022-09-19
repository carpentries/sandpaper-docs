---
title: "Editing a {sandpaper} lesson"
teaching: 5
exercises: 0
---

:::::::::::::::::::: questions

 - What is the folder structure of a lesson?
 - How do you download an existing {sandpaper} lesson?
 
:::::::::::::::::::::::::::::

:::::::::::::::::::: objectives

 - Understand how to clone an existing lesson from GitHub
 - Use `sandpaper::build_lesson()` to preview a lesson
 - Update the configuration for a lesson
 - Rearrange the order of episodes

:::::::::::::::::::::::::::::::


If you want to edit and preview a full lesson using {sandpaper}, this is the
episode for you. If you want to create a new lesson, head back to the episode
for [Creating a New Lesson](introduction.html). I believe it's beneficial to
experience editing a fully functional lesson, so you will edit THIS lesson. The
first step is to fork and clone it from GitHub:

## Fork and Clone a Lesson {#create-from-github}

If you are familiar with the process of forking and cloning, then you may fork
and clone as you normally do. If you would like a reminder, here are the steps:

1. Think about a place on your computer where you want to work on your fork
   of the lesson (e.g. `~/Documents/Lessons/`) and make sure that folder exists.

2. Go to https://github.com/carpentries/sandpaper-docs/fork/ to fork the repository 
   to your account

3. In the shell and use this command to clone this repository to your working
   directory, replacing `<USERNAME>` with your username
   ```bash
   cd ~/Documents/Lessons/
   git clone git@github.com:<USERNAME>/sandpaper-docs.git
   cd sandpaper-docs
   ```

::::::::::::::: callout

### One-step fork with R

If you use R and you also use an HTTPS protocol, you might be interested to know
that the above three steps can be done in a single step with the {usethis}
package via the GitHub API:

```r
usethis::create_from_github("carpentries/sandpaper-docs", "~/Documents/Lessons/")
```

:::::::::::::::::::::::

In the next section, we will explore the folder structure of a lesson. 

:::::::::::::::::::::::::::: challenge

### Preview the Lesson

1. Open the lesson in RStudio (or whatever you use for R)
2. Use the keyboard shortcut <kbd>ctrl + shift + b</kbd> 
   (<kbd>cmd + shift + b</kbd> on macOS) to build and preview this lesson (or 
   type `sandpaper::build_lesson()` in the console if you are not using RStudio)
3. Open THIS file (`episodes/editing.Rmd`) and add step 4: preview the lesson again.

What do you notice?

::::::::: solution

What you should notice is that the only file updated when you re-render the
lesson is the file you changed (`episodes/editing.Rmd`). 

:::::::::::::::::
::::::::::::::::::::::::::::::::::::::

## Folder Structure

:::::::::::::::: callout

### :construction: This May Change :construction:

The exact folder structure still has the possibility to change based on user
testing for the front-end of the lesson website.

::::::::::::::::::::::::

The template folder structure will contain markdown files arranged so that they
match what we expect the menubar for the lesson should be. All folders and files
with an arrow `<-` are places in the lesson template you will be modifying:

```
|-- .gitignore         #  | Ignore everything in the site/ folder
|-- .github/           #  | Configuration for deployment
|-- episodes/          # <- PUT YOUR EPISODE MARKDOWN FILES IN THIS FOLDER
|-- instructors/       # <- Information for Instructors (e.g. guide.md)
|-- learners/          # <- Information for Learners (e.g. reference.md and setup.md)
|-- profiles/          # <- Learner and/or Instructor Profiles
|-- site/              #  | This is a "scratch" folder ignored by git and is where the rendered markdown files and static site will live
|-- config.yaml        # <- Use this to configure lesson metadata
|-- index.md           # <- The landing page of your site
|-- CONTRIBUTING.md    #  | Carpentries Rules for Contributions (REQUIRED)
|-- CODE_OF_CONDUCT.md #  | Carpentries Code of Conduct (REQUIRED)
|-- LICENSE.md         #  | Carpentries Licenses (REQUIRED)
`-- README.md          # <- Introduces folks how to use this lesson and where they can find more information.
```

This folder structure is heavily opinionated towards achieving our goals of
creating a lesson infrastructure that is fit for the purpose of delivering lesson
content for not only Carpentries instructors, but also for learners and
educators who are browsing the content after a workshop. It is not designed to
be a blog or commerce website. Read the following sections to understand the 
files and folders you will interact with most. 

All source files in {sandpaper} are written in [pandoc]-flavored markdown and
all require yaml header called `title`. Beyond that, you can put anything in
these markdown files. 

## `config.yaml`

This configuration file contains global information about the lesson. It is
purposefully designed to only include information that is editable and
relevant to the lesson itself and can be divided into two sections: information
and organization

### Information

These fields will be simple key-pair values of information used throughout the episode

carpentry
: The code for the specific carpentry that the lesson belongs to (swc, dc, lc, cp)

title
: The main title of the lesson

life_cycle
: What life cycle is the lesson in? (pre-alpha, alpha, beta, stable)

license
: The license the lesson is registered under (defaults to CC-BY 4.0)

source
: The github source of the lesson

branch
: The default branch

contact
: Who should be contacted if there is a problem with the lesson

### Organization

These fields match the folder names in the repository and the values are a list of
file names in the order they should be displayed. By default, each of these fields
is blank, indicating that the default alphabetical order is used. To list items,
add a new line with a hyphen and a space preceding the item name (`- `). For
example, if I wanted to have the episodes called "one.md", "two.Rmd", "three.md",
and "four.md" in numerical order, I would use:

```yaml
episodes:
- one.md
- two.Rmd
- three.md
- four.md
```

Below are the four possible fields {sandpaper} will recognize:

episodes
: The names of the episodes (main content)

instructors
: Instructor-specific resources (e.g. outline, etc)

learners
: Resources for learners (e.g. Glossary terms)

profiles
: Learner profile pages 


::::::::::::::::::::::::::::::: challenge

### Configuring Episode Order

Open `config.yaml` and change the order of the episodes. Preview the lesson
after you save the file. How did the schedule change?

::::::::::::::::: solution

The episodes appear in the same order as the configuration file and the timings
have rearranged themselves to reflect that.

::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::

## `episodes/`

This is the folder where all the action is. It contains all of the episodes, 
figures, and data files needed for the lesson. By default, it will contain an
episode called introduction.Rmd. You can edit this file to use as your
introduction. To create a new Markdown episode, use the folowing function:

```r
sandpaper::create_episode_md("Episode Name")
```

This will create a Markdown episode called `episode-name.md` in the
`episodes/` directory of your lesson, pre-populated with objectives,
questions, and keypoints. The episode will be added to the end of the `episodes:`
list in `config.yaml`, which serves as the table of contents.

If you want to create an episode, but are not yet ready to render or publish it,
you can create a draft using the `draft_episode` family of functions:

```r
sandpaper::draft_episode_rmd("Visualising Data")
```

This will create an R Markdown episode called `visualising-data.Rmd` in the
`episodes/` directory of your lesson, but it will NOT be added to `config.yaml`,
allowing you to work on it at your own pace without the need to publish it.

When you are ready to publish an episode or want to move an existing episode to
a new place, you can use `move_episode()` to pull up an interactive menu for 
moving the episode.

```r
sandpaper::move_episode("visualising-data.Rmd")
```

```output
ℹ Select a number to insert your episode
(if an episode already occupies that position, it will be shifted down)

1. introduction.md
2. episode-name.md
3. [insert at end]

Choice:          
```

::::::::::::::::: callout

### Should I use R Markdown or Markdown Episodes?

All {sandpaper} lessons can be built using Markdown, R Markdown, or a mix of
both. If you want to dynamically render the output of your code via R (other
languages will be supported in the future), then you should use R Markdown, but
if you do not need to dynamically render output, you should stick with Markdown.

Sandpaper offers four functions that will help with episode creation depending
on your usage:

| R Markdown             | Markdown              |
| ---------------------- | --------------------- |
| `create_episode_rmd()` | `create_episode_md()` |
| `draft_episode_rmd()`  | `draft_episode_md()`  |


:::::::::::::::::::::::::

## `instructors/`

This folder contains information used for instructors only. Downloads of code
outlines, aggregated figures, and slides would live in this folder. 

## `learners/`

All the extras the learner would need, mostly a setup guide and glossary 
live here.

The glossary page is populated from the `reference.md` file in this folder.
The format of the glossary section of the `reference.md` file is a heading title 
`## Glossary` followed by [a definition list](https://pandoc.org/MANUAL.html#definition-lists). 
Definition lists are formatted as two lines for each term, the first
includes the term to be defined and then the second line starts with a ":"
and a space then the definition.
i.e.

```markdown
term
: definition
```

term
: definition

## `profiles/`

Learner profiles would live in this folder and target learners, instructors, and
maintainers alike to give a focus on the lesson.

## `index.md`

This is the landing page for the lesson. The schedule is appended at the bottom
of this page and this will be the first page that anyone sees.

## `README.md`

This page gives information to maintainers about what to expect inside of th
repository and how to contribute. 


::::::::::::::::::::: keypoints

- `sandpaper::build_lesson()` renders the site and rebuilds any sources that have changed. 
- RStudio shortcuts are <kbd>cmd + shift + B</kbd> and <kbd>cmd + shift + K</kbd>
- To edit a lesson, you only need to know Markdown and/or R Markdown
- The folder structure is designed with maintainers in mind   
- New episodes can be added with `sandpaper::create_episode()`

:::::::::::::::::::::::::::::::

[pandoc]: https://pandoc.org/
