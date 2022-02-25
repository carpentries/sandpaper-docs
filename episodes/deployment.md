---
title: "Lesson Deployment"
teaching: 5
exercises: 0
---

::::::::::::::::::::::::::::: questions

 - What is the two-step model of deployment?
 - Why do we preserve both generated markdown and HTML?

:::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::: objectives

 - Understand the two-step model for lesson deployment
 - Understand how our lessons are deployed on GitHub

::::::::::::::::::::::::::::::::::::::::

## Building A Lesson

Static site generators all know one thing: how to translate markdown to an HTML
website. The Carpentries Lesson Infrastructure is no different in that it will
generate an HTML website from markdown files using [pandoc]. The difference is
how we handle the generated content to make your lesson portable and
transferrable.

### Working With Generated Content

[The Carpentries has formally supported generated content from R lessons in the
form of R Markdown files since 2016][rmd-blog] and we are working on a solution
to incorporate generated content from other languages in the future. If you do
not use generated content in your lesson, you can skip this section.

The default paradigm for R Markdown is to first generate markdown output from
the R Markdown document, convert it to HTML, and then discard the generated
markdown output.

![Source: "Teaching In Production" by Dr. Allison Horst,
<https://rstd.io/tip>](https://github.com/rstudio-education/teaching-in-production/raw/master/slides/images/rmd_flowchart.png){alt="A
stylized flowchart with 'good ideas', 'code', and 'data' flowing into '.Rmd',
transformed to '.md' via 'knitr', and then transformed to 'html', 'pdf', and
'docx' via 'pandoc'. There is an illustration of a hedgehog knitting a sock to
the left and a rabbit wearing the other sock on the right."}

However, this default behavior for generated content is not conducive for
collaboration on lessons because the outputs often live in the same place as
the source files. Moreover, if any changes occur in the software used to
generate content, inspecting the differences between two HTML files is
difficult because of markup. We created the {sandpaper} package to alleviate
these downsides by clearly separating the generated content from the source 
material by taking advantage of a two-step model of deployment.

### The Two-Step Model of Deployment

To alleviate the downsides of working with generated content, The Carpentries
Workbench employs a two-step model of deployment when you run
`sandpaper::build_lesson()`

1. Take any source files with content that needs to be interpreted (e.g. 
   R Markdown) and **render them to markdown** in a staging area ignored by git. 
2. Apply the HTML style to the markdown files in the staging area to create the
   lesson website.

![The two-step model of lesson deployment](https://zkamvar.github.io/stunning-barnacle/img/local-flow.dot.svg){alt='Diagram showing the process of `build_lesson(rebuild = TRUE)`, starting from R Markdown to Markdown and finally to HTML. R Markdown is highlighted as being the only element tracked by git.'}

All of the generated content lives in the `site/` folder, and importantly: it
is all cached and ignored by git. Ignoring generated content locally means that
the source of truth for these files is no longer dependent on the maintainer's
local setup. 

The reason we have this model is also for portability. It's because markdown
output is a lot easier to audit than HTML when something goes wrong, rendered
markdown can be transferred to other contexts (e.g. books or blogposts), and we
can swap out the generators without needing to rewrite the entire pipeline.

:::::::::::::: callout

#### Did you know?

When the lesson is pushed to GitHub, all of the generated content IS stored in
separate branches so that we can provide a way for you to audit changes from 
pull requests. 

::::::::::::::::::::::

## Deploying On GitHub

For historical reasons, GitHub used the Jekyll static site generator to deploy
their documentation websites, but because we no longer use Jekyll, we we deploy
our sites in a different manner.

On GitHub, we store generated content in two orphan branches called
`md-outputs` and `gh-pages` for the generated markdown and html, respectively.
We use [GitHub Actions Workflows][gh-workflows] to build, validate, and deploy
our lessons on GitHub pages. Because the markdown and HTML outputs are preserved
in the git history, we can tag and preserve them for archiving.

These workflows are the source of truth for the lessons and will keep your
lesson up-to-date with the latest version of the HTML template. Moreover, each
week, these workflows will check for updates and, if there are any, a pull
request will be created to ensure you are using the latest versions. You can
[read more about updating your workflows in the Maitenance chapter](update.Rmd).

If you use R Markdown in your lesson, you will notice that for every pull
request (PR), a GitHub bot comments on your pull requests informing you about
what content has changed and gives you a link to the differences between the
current state of the `md-outputs` branch and the proposed changes. You can find
out more about this in the [Pull Request chapter](pull-request.md).

:::::::::::::::::::::::::::::: keypoints

 - Lessons are built using a two-step process of caching markdown outputs and then building HTML from that cache
 - We use GitHub Actions to deploy and audit generated lesson content to their websites

::::::::::::::::::::::::::::::::::::::::


