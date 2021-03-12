---
title: "Migrating from Jekyll"
teaching: 5 
exercises: 2
---

:::::::::::::::: questions :::::::::::::::::::::

- Who is responsible for migrating a lesson?
- What package should I use for migration?

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: objectives ::::::::::::::::::::

- Understand the challenges involved in migration
- Identify the shared components between the current and new lesson template
- Identify the tool needed for migration

::::::::::::::::::::::::::::::::::::::::::::::::


## Quick Start

Got a lesson you want to convert? The [{pegboard}] package was built to do that!
The best way to do this is to **ask Zhian to do it for you** since this is a
process that should ideally only be done once. If you really want to, you can
also try for yourself:

1. Install the package using [the setup instructions](setup.html)
2. Open R
3. Run `pegboard::jekyll_to_sandpaper()` to transform your lesson.


::::::::::::::: callout

### :caution: THINGS MIGHT CHANGE :caution:

This feature is still in active development and may not yet work as advertised.

::::::::::::::::::::::::

## Challenges

In an ideal world, migration of a lesson would involve moving shared markdown
documents between folders, but unfortunately, this is not the case. The truth is
that there are [dozens of markdown
interpreters](https://github.com/markdown/markdown.github.com/wiki/Implementations)
that all have a complicated hierarchy of rules.

### A Question of Syntax

The current template uses a markdown interpreter called [kramdown] because it
was the default interpreter for [Jekyll][jekyll] at the time. This syntax 
allowed us to create customized block quotes that served as waypoints in our
lessons to facilitate active learning. Unfortunately, the syntax diverged far 
enough from [GitHub Flavoured markdown (GFM)](https://github.github.com/gfm/)
that even if you were familiar with markdown, you would have to learn a new 
syntax to write your content.

Enter [pandoc]. This tool is a cross-platform document converter that [uses its
own flavor of markdown](https://pandoc.org/MANUAL#pandocs-markdown), that is
more closely related to GFM than [kramdown]. For example, all of the features
listed in the [extended syntax of the markdown guide](https://www.markdownguide.org/extended-syntax/)
are present in pandoc.

One of the biggest hurdles for the translation between [kramdown] and [pandoc]
syntax are two things: 

1. [Liquid templating syntax](https://shopify.github.io/liquid/basics/introduction/) (e.g. `{{ relative_root_path }}/{% link LICENSE.md %}` to link to the license
2. Trailing styles: https://github.com/swcarpentry/DEPRECATED-lesson-template/issues/279#issuecomment-115491610

To give a succint example, if I wanted to write this code block in markdown:

```python
import matplotlib
```

I would write

````markdown
```python
import matplotlib
```
````

However, [kramdown] specified this syntax:

````markdown
~~~
import matplotlib
~~~
{: .language-python}
````

While it was possible to use the GFM syntax in Kramdown, the first recommendation
from the documentation has always been to use the trailing styles, and so that
pattern stuck with the lessons. 

All this goes to show that switching between these two syntaxes is not a simple
task of find and replace.

### Folder structure

The folder structure of the Lesson has evolved sporadically based on need and 
entropy, which leaves us with "junk drawer" folders like "extras" that contain
materials for both the learners and instructors. Moreover, the old template had
separated the data folders from the episodes folders[^1]. On top of that, the 
lessons that use RMarkdown had episodes embedded in `_episodes_rmd/` where some
of the files in that folder were artifacts from previous runs.

### Questions, Objectives, and Keypoints

The yaml headers of lessons contained bullet points for the questions, objectives,
and keypoints, but it became difficult to write markdown in yaml quotation marks,
so we have decided to migrate them to blocks in the lesson document itself.

### Block Quotes

Block quotes are convenient visual aids for writing callouts, but they are 
challenging to wrangle when you need to write code inside of them, especially
if you have nested content. Our solution to this is to use [fenced divs](https://zkamvar.github.io/glowing-chainsaw/05-fenced-div-challenge-blocks.html#example-1). 

## Solution

The migration of the lesson template is taken care of via [{pegboard}], which 
reads in the markdown source files using the commonmark markdown interpreter and
internally manipulates the kramdown syntax to something it can interpret.

The resulting markdown is then written to convert the following:

1. block quotes become fenced divs
2. code blocks are converted to standard markdown
3. liquid tags are converted to normal, reference-based links
4. non-metadata yaml items moved to the body of the document. 

::::::::::::::::::::::::::::: keypoints

 - Zhian will help migrate official lessons
 - use [{pegboard}] for migration

:::::::::::::::::::::::::::::::::::::::

[{pegboard}]: validator.html
[^1]: This was an explicit design choice to mimic how researchers should set up
    their analysis projects, but it lead to some confusion when it came to 
    rendering RMarkdown documents. 

<!-- Please do not delete anything below this line -->


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
