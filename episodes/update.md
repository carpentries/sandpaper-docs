---
title: "Maintaining a Healthy Infrastructure"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What are the four components of the lesson infrastructure?
- What lesson components are auto-updated on GitHub?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Identify components of the workbench needed for lesson structure, validation, 
  styling, and deployment
- Understand how to update R packages
- Understand how to update GitHub workflows

::::::::::::::::::::::::::::::::::::::::::::::::

:::: callout

#### :construction: Under Development

This episode is still actively being developed

::::

## Introduction

The Carpentries Lesson Infrastructure is designed to be cu

## Maintainer Tools

This is {sandpaper}! It takes your source files and generates the outputs!

Update in R with:

```r
install.packages("sandpaper", repos = "https://carpentries.r-universe.dev")
```


## Validator


This is {pegboard}! It runs behind the scenes in {sandpaper} to parse the source
documents and validate things like headings, images, and cross-links. It also 
can extract elements like code and individual sections.

Update in R with:

```r
install.packages("pegboard", repos = "https://carpentries.r-universe.dev")
```

## Styling

This is {varnish}! This package contains all the HTML, JavaScript, and CSS to
make your generated HTML look like a Carpentries Lesson!

Update in R with:

```r
sandpaper::update_varnish()
```


## Deployment

### Updating Your Deployment Workflows

The workflows are the the only place in our lesson that needs to be kept
up-to-date with upstream changes from [{sandpaper}]. While we try as much as
possible to keep the functionality of [{sandpaper}] inside the package itself,
there are times when we need to update the GitHub workflows for security or
performance reasons. You can update your workflows in one of two ways: via 
GitHub or via [{sandpaper}].


:::: callout

#### :construction: Under Development

Workflow updates are still underdevelopment, but **are available for use**. We
are exploring different methods for making these unobtrusive as possible such as
specifying scheduled updates via `config.yaml` and even creating a bot that will
remove the need for this workflow.

::::::::::::

### On Schedule (default)

The workflow update workflow is scheduled to run every Tuesday at 00:00 UTC. If
there are any changes in the upstream workflows, then a Pull Request will be
created with the new changes. If there are _no changes_ to the workflows, then
the process will silently exit and you will not be notified. 

### Via GitHub

To update your workflows in GitHub, go to 
`https://github.com/(ORGANISATION)/(REPOSITORY)/actions/workflows/update-workflows.yaml`

Once there, you will see a button that says "Run Workflow" in a blue field to
the right of your screen. Click on that Button and it will give you two options:

1. "Who this build (enter github username to tag yourself)?
2. "Workflow files/file extensions to clean (no wildcards, enter "" for none)

You can leave these as-is or replace them with your own values. You can now hit
the green "Run Workflow" button at the bottom.

![](fig/update-workflow-manual.png){alt='Screen shot of GitHub interface zoomed into a button that says "Run workflow" with two options to specify your name (@zkamvar) and files to clean (.yaml). A green Run Workflow button is at the bottom of the dialogue.'}

After ~10 seconds, your workflow will run and a pull request will be created 
from a GitHub bot (at the moment, this is @znk-machine) if your workflows are
in need of updating.

Check the changes and merge if they look okay to you. If they do not, contact
@zkamvar.


### Via R

If you want to update your workflows via R, you can use the 
`update_github_workflows()` function, which will report which files were updated.

```r
sandpaper::update_github_workflows()
```

```{.output}
ℹ Workflows/files updated:
- .github/workflows/pr-comment.yaml (modified)
- .github/workflows/pr-post-remove-branch.yaml (modified)
- .github/workflows/README.md (modified)
- .github/workflows/sandpaper-version.txt (modified)
- .github/workflows/update-workflows.yaml (new)
```

After that, you can add and commit your changes and then push them to GitHub.

:::::: callout

#### Do not combine workflow changes with other changes

If you bundle a workflow changes in a pull request, you will not get the benefit
of being able to inspect the output of the generated markdown files. Moreover,
while we try to make these workflow files as simple as possible, they are still
complex and would distract from any content that would be proposed for the
lesson.

:::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- Lesson structure, validation, and styling components are all updated
  automatically on GitHub.
- Lesson structure, validation, and styling components all live in your local
  R library.
- Locally, R packages can be updated with `install.packages()`
- Package styling can be updated any time with `sandpaper::update_varnish()`
- GitHub workflows live inside the lesson under `.github/workflows/`
- GitHub workflows can be updated with `sandpaper::update_github_workflows()`

::::::::::::::::::::::::::::::::::::::::::::::::

