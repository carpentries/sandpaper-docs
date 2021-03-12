---
title: "Introduction to the New Template"
teaching: 10
exercises: 2
---

:::::::::::: questions

 - Why make a new lesson template?
 - How do I get started?

::::::::::::::::::::::

::::::::::: objectives

- Contrast the new template with the old
- Understand the basic structure of the new template
- Identify the main command to preview the template

::::::::::::::::::::::


## Quickstart

:::::::::::::::::: callout

### Takeaway message

Contributors should only be expected to know basic markdown and *very* minimal
yaml syntax in order to work on lessons.

:::::::::::::::::::::::::::

The new lesson template is designed to be modular with clear, cross-platform
system requirements. It will use the R programming language and [pandoc] under
the hood and will abide bhe the following rules:

1. Lesson contributors do not need to know anything about the toolchain to
   contribute in a meaningful way.
2. Elements of the toolchain that evaluates, validates, and stylizes lessons
   should live in separate repositories to allow for seamless updating.
3. The procedures should be well-documented and generalizable enough that the
   toolchain is not entirely dependent on R.

R is beneficial because it already has a mature ecosystem of packages for
publishing dynamic reports and web content from markdown, it works on all
platforms, and we teach it as part of our core curriculum.


::::::::::::::::: challenge

### Try it yourself!

You can explore this lesson with the following steps:

1. Follow the [setup instructions](setup.html)
2. Open RStudio (or your preferred interface to R)
3. Use the following code:

```r
library("usethis")
library("sandpaper")

# Download this repository to your Desktop and move into it
# (If you are using RStudio, it will open a new session)
usethis::create_from_github("zkamvar/sandpaper-docs", open = TRUE)

# Render and preview the lesson
sandpaper::build_lesson()
```

::::::::::::::::::::::::

:::::::::::::: callout

### Keyboard Shortcuts

If you are using RStudio, did you know you can use keyboard shortcuts to render
the lesson as you are working on the episodes?

Render and preview the whole lesson
:    <kbd>ctrl + shift + B</kbd>

Render and preview an episode
:    <kbd>ctrl + shift + K</kbd>
::::::::::::::::::::::

:::::::::::::: callout

### Did everything work?

If everything worked, you should have seen a lot of output in your R console and
then your browser window open to reveal a page that looks identical to
https://zkamvar.github.io/sandpaper-docs/.

If this did NOT work for you, please send any errors you encountered to Zhian at
zkamvar@carpentries.org or you can reach him on The Carpentries Slack. 

:::::::::::::::::::::::

The new lesson template is an R package called [{sandpaper}](engine.html), which
is designed to provide rapid updates to the lessons on the fly. It uses a 
**two-step process for building lessons**:

1. render all modified source documents (e.g [RMarkdown][r-markdown] or plain
   Markdown) to [pandoc-flavored markdown][pandoc] to a staging folder called 
   `site/built/`.
2. combine metadata with the contents of `site/built/` and convert to HTML to
   the folder called `site/docs/`

![
Diagrammatic representation of the proposed toolchain (excluding GitHub). 
Lavender rectangles represent R packages, 
Plum rectangles represent interchangable tools, 
Powder Blue Ovals represent people.
](https://zkamvar.github.io/stunning-barnacle/img/broad-flow.dot.svg)

## Why make a new template?

New templates are nothing new for The Carpentries[^history] as we are forever
searching for a balance between using the tools we teach and scaling our
operations to accomodate the growing number of lessons we have in [The
Carpentries Incubator].

::::::::::::: discussion

### What can be improved?

The current template is a lesson template wrapped around a Jekyll blog. It has
all of the features we want, but it's showing its age in several ways:

1. By requiring four different languages to check and render the lesson,
   several people have turned to elaborate solutions to preview their lessons
   including [Using a GitHub fork](https://www.youtube.com/watch?v=0XoEdznJARc)
   and [Creating a Docker image](https://github.com/carpentries/lesson-docker/)
2. All of our R lessons use [RMarkdown][r-markdown] to combine code and prose
   into a document that renders the output automatically, which means any
   updates will get propogated. Because [Jekyll][jekyll] sites do not run R in
   the background, they cannot render these lessons, so a fifth language must
   be added on and pre-rendered before lessons are built.
3. Updating the lessons is no small feat. It relies on a trick that we use for
   people creating lessons by importing the carpentries repository (because the
   template button did not yet exist) so that we can create a new branch and 
   merge the current branch of the [styles repository][styles]. This creates a
   pull request with potentially hundreds of commits that you just have to
   trust works.
4. The configuration file contains a lot of information that the maintainer is
   explicitly expected to NOT change, which is the equivalent of 

::::::::::::::::::

The new lesson template is fresh start as we look back to our founding principles
and think about what is important for the lesson maintainer to focus on: the
lesson content. To achieve this, we have stripped away the styling elements and
present to you a template that contains two things you need to worry about:
content files written in plain markdown and one (1) flat configuration file. All
the styling templates and tooling have been cast off into their own repositories
so that these can be updated on the fly without needing to undergo a complex
pull requests. Moreover, the template will treat [RMarkdown][r-markdown]
documents as first-class citizens without any extra setup or commands.

The new lesson template is **not** designed to mimic aspects of the previous
template. This template is designed primarily for use in The Carpentries, but
should theoretically be extensible to other contexts. Most importantly,
**contributors should only be expected to know `markdown` and *very* minimal
`yaml` syntax.** in order to contribute to lessons.

Thus, there are a few rules that the new template should follow:

::::::::::::: checklist

### Template Rules

1. The main branch is the source of truth and should be protected
2. Accessibility is a priority for the lesson [based on the WCAG 2.1
   guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
3. The style of the lessons should not live in the template
4. The only committed content should be content directly by the
   maintainer/contributor and configuration files
5. Episodes should not depend on the lesson template to be rendered
6. The generated lesson web page should exist as a stand-alone directory that
   can be shared offline

:::::::::::::::::::::

## Template Structure

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
|-- profiles/          # <- Learner and/or Instructor Profiles (new)
|-- site/              #  | This is a "scratch" folder ignored by git and is where the rendered markdown files and static site will live
|-- config.yaml        # <- Use this to configure lesson metadata
|-- index.md           # <- The landing page of your site
|-- CONTRIBUTING.md    #  | Carpentries Rules for Contributions (REQUIRED)
|-- CODE_OF_CONDUCT.md #  | Carpentries Code of Conduct (REQUIRED)
|-- LICENSE.md         #  | Carpentries Licenses (REQUIRED)
`-- README.md          # <- Introduces folks how to use this lesson and where they can find more information.
```

This folder structure is heavily opinionated towards achieving our goals of
creating a lesson template that is fit for the purpose of delivering lesson
content for not only Carpentries instructors, but also for learners and
educators who are browsing the content after a workshop. It is not designed to
be a blog or commerce website. 

## Tools

As described in [the setup document](setup.html), the lesson template now only
requires R and [pandoc] to be installed. The tooling from the current lesson
template has been split up into three R packages:

1. [{varnish}] contains the HTML, CSS, and JavaScript elements
1. [{pegboard}] is a validator for the markdown documents
1. [{sandpaper}] is the engine that puts everything together. 


:::::::: callout

### Customization

One of the benefits of our [CC-BY 4.0][cc-by-human] template is that anyone can
take it and customize it for their own purposes. We have found such creative 
endeavors as using it as a [user guide for the Common Workflow Language](https://www.commonwl.org/user_guide/),
a [program-specific set of training materials](https://nbisweden.github.io/module-organising-data-dm-practices/),
and even [a lesson on cross-stitching](https://sgibson91.github.io/cross-stitch-carpentry/).

With the new tempalte, however, the customization would take place in a fork of
the [{varnish}] repository, where all of the styling elements live.

::::::::::::::

## Processing

The previous [Jekyll][jekyll] template used a single step to render markdown to
HTML, with the new template, we have a two step process that renders
[(R)Markdown][r-markdown] to markdown and then to HTML. Why use two steps? By
rendering in two steps, we do a couple of things:

1. Any format that can be rendred to markdown can potentially be a source
2. Markdown provides a much better diff than HTML, so diagnosing output issues
   on a lesson is eaiser. 
3. The resulting markdown can be used in other contexts without needing to
   rebuild. 

::::::::::::: keypoints

 - There are several usability issues in the current template, creating
   barriers to contribution
 - The new template will be built with the maintainers in mind
 - We are moving away from [kramdown] to [pandoc]-flavored markdown
 - Tools for the new template will be fully separated from content
 - Documents that need rendered output (e.g. [RMarkdown][r-markdown]) are
   treated as first-class citizens
 - The lessons will be rendered in a two-step process

:::::::::::::::::::::::


<!-- Please do not delete anything below this line -->

[{varnish}]: template.html
[{pegboard}]: validator.html
[{sandpaper}]: engine.html
[The Carpentries Incubator]: https://carpentries.org/community-lessons/
[^history]: An incomplete history is noted in the 9.1.0 release: https://github.com/carpentries/styles/releases/tag/v9.1.0


[cc-by-human]: https://creativecommons.org/licenses/by/4.0/
[cc-by-legal]: https://creativecommons.org/licenses/by/4.0/legalcode
[ci]: http://communityin.org/
[coc-reporting]: https://docs.carpentries.org/topic_folders/policies/incident-reporting.html
[coc]: https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html
[concept-maps]: https://carpentries.github.io/instructor-training/05-memory/
[contrib-covenant]: https://contributor-covenant.org/
[contributing]: {{ repo_url }}/blob/{{ source_branch }}/CONTRIBUTING.md
[cran-checkpoint]: https://cran.r-project.org/package=checkpoint
[cran-knitr]: https://cran.r-project.org/package=knitr
[cran-stringr]: https://cran.r-project.org/package=stringr
[dc-lessons]: http://www.datacarpentry.org/lessons/
[email]: mailto:team@carpentries.org
[github-importer]: https://import.github.com/
[importer]: https://github.com/new/import
[jekyll-collection]: https://jekyllrb.com/docs/collections/
[jekyll-install]: https://jekyllrb.com/docs/installation/
[jekyll-windows]: http://jekyll-windows.juthilo.com/
[jekyll]: https://jekyllrb.com/
[jupyter]: https://jupyter.org/
[kramdown]: https://kramdown.gettalong.org/
[lc-lessons]: https://librarycarpentry.org/lessons/
[lesson-aio]: {{ relative_root_path }}{% link aio.md %}
[lesson-coc]: {{ relative_root_path }}{% link CODE_OF_CONDUCT.md %}
[lesson-example]: https://carpentries.github.io/lesson-example/
[lesson-license]: {{ relative_root_path }}{% link LICENSE.md %}
[lesson-mainpage]: {{ relative_root_path }}{% link index.md %}
[lesson-reference]: {{ relative_root_path }}{% link reference.md %}
[lesson-setup]: {{ relative_root_path }}{% link setup.md %}
[mit-license]: https://opensource.org/licenses/mit-license.html
[morea]: https://morea-framework.github.io/
[numfocus]: https://numfocus.org/
[osi]: https://opensource.org
[pandoc]: https://pandoc.org/
[paper-now]: https://github.com/PeerJ/paper-now
[python-gapminder]: https://swcarpentry.github.io/python-novice-gapminder/
[pyyaml]: https://pypi.python.org/pypi/PyYAML
[r-markdown]: https://rmarkdown.rstudio.com/
[rstudio]: https://www.rstudio.com/
[ruby-install-guide]: https://www.ruby-lang.org/en/downloads/
[ruby-installer]: https://rubyinstaller.org/
[rubygems]: https://rubygems.org/pages/download/
[styles]: https://github.com/carpentries/styles/
[swc-lessons]: https://software-carpentry.org/lessons/
[swc-releases]: https://github.com/swcarpentry/swc-releases
[training]: https://carpentries.github.io/instructor-training/
[workshop-repo]: {{ site.workshop_repo }}
[yaml]: http://yaml.org/
