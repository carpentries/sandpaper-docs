---
sandpaper-digest: e38fea702d70556aa8e267f6b5ef19a0
sandpaper-source: /Users/runner/work/sandpaper-docs/sandpaper-docs/episodes/introduction.Rmd

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


## Why make a new template?

New templates are nothing new for The Carpentries[^An incomplete history is
noted in the 9.1.0 release:
https://github.com/carpentries/styles/releases/tag/v9.1.0] as we are forever
searching for a balance between using the tools we teach and scaling our
operations to accomodate the growing number of lessons we have in [The
Carpentries Incubator]. 

::::::::::::: discussion

### What's wrong with the current template?

The current template is a lesson template wrapped around a Jekyll blog. It has
all of the features we want, but it's showing its age in several ways:

1. By requiring four different languages to check and render the lesson,
   several people have turned to elaborate solutions to preview their lessons
   including [Using a GitHub fork](https://www.youtube.com/watch?v=0XoEdznJARc)
   and [Creating a Docker image](https://github.com/carpentries/lesson-docker/)
2. All of our R lessons use RMarkdown to combine code and prose into a document
   that renders the output automatically, which means any updates will get
   propogated. Because Jekyll sites do not run R in the background, they cannot
   render these lessons, so a fifth language must be added on and pre-rendered
   before lessons are built.
3. Updating the lessons is no small feat. It relies on a trick that we use for
   people creating lessons by importing the carpentries repository (because the
   template button did not yet exist) so that we can create a new branch and 
   merge the current branch of the styles repository. This creates a pull request
   with potentially hundreds of commits that you just have to trust works.

::::::::::::::::::

The new lesson template is fresh start as we look back to our founding principles
and think about what is important for the lesson maintainer to focus on: the
lesson content. To achieve this, we have stripped away the styling elements and
present to you a template that contains two things you need to worry about:
content files written in plain markdown and one (1) flat configuration file. All
the styling templates and tooling have been cast off into their own repositories
so that these can be updated on the fly without needing to undergo a complex
pull requests. Moreover, the template will treat RMarkdown documents as 
first-class citizens without any extra setup or commands.

## Template Structure

:::::::::::::::: callout

### :construction: This May Change :construction:

The exact folder structure still has the possibility to change based on user
testing for the front-end of the lesson website.

::::::::::::::::::::::::

The template folder structure will contain markdown files arranged so that they
match what we expect the menubar for the lesson should be:

 - `episodes/` contains the lesson episode documents and all the figures and files associated with them
 - `learners/` contains materials for learners such as the setup document and the glossary
 - `instructors/` contains materials for instructors such as outline and slides.
 - `profiles/` contains learner profiles for the course
 - `config.yaml` is a flat yaml file where you can arrange the files in the above
 folders in any order and specify the metadata for the lesson.

## Tools

As described in [the setup document](setup.html), the lesson template now only
requires R and pandoc to be installed. The tooling from the current lesson
template has been split up into three R packages:

1. [{varnish}](template.html) contains the HTML, CSS, and JavaScript elements
1. [{pegboard}](validator.html) is a validator for the markdown documents
1. [{sandpaper}](engine.html) is the engine that puts everything together. 

## Processing

The previous Jekyll template used a single step to render markdown to HTML, with
the new template, we have a two step process that renders (R)Markdown to 
markdown and then to HTML. Why use two steps? By rendering in two steps, we do
a couple of things:

1. Any format that can be rendred to markdown can potentially be a source
2. Markdown provides a much better diff than HTML, so diagnosing output issues
   on a lesson is eaiser. 
3. The resulting markdown can be used in other contexts without needing to
   rebuild. 

<!-- Please do not delete anything below this line -->

[The Carpentries Incubator]: https://carpentries.org/community-lessons/


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
