---
title: Setup
---

The {sandpaper} template requires [R] and [pandoc] to be installed, both of 
which are bundled in the [RStudio] IDE. 

## Foundational software

There are three programs that the template works with: Git, RStudio, and pandoc.
They can be installed from the following resources:

 - **Git** https://carpentries.github.io/workshop-template/#git
 - **R** https://carpentries.github.io/workshop-template/#r
 - **pandoc** we recommend installing this by [installing the RStudio IDE][RStudio]

::::: solution

### What if I don't want to use RStudio?

That's perfectly okay! If you do not want to use RStudio, you can install pandoc
directly to your computer by following the directions on https://pandoc.org/installing.html.
We recommend using RStudio because it is tightly integrated with pandoc. 

:::::::::

::::::::: prereq

### Setting up your R workspace

When you set up R, it's important to make sure you set it up to never save your
workspace on exit and never load a previously saved workspace on startup. 

#### Via RStudio 

If you are using RStudio, you can [follow the instructions in this forum 
post](https://community.rstudio.com/t/first-line-of-every-r-script/799/12?u=zkamvar):

1. From the menu, select <cmd>Tools<cmd> > <cmd>Global Options</cmd>
2. Under **Workspace Options**, de-select "Restore .RData into workspace at startup" and set "Save workspace to .RData on exit" to "Never"

#### Via Command Line Interface

The flags `--no-restore` and `--no-save` will set these defaults, so you can 
create an alias for BASH:

```bash
alias R='R --no-restore --no-save'
```

::::::::::::::::::

:::::::::::::::::::::: callout

### There are many ways to set up R to work with the lesson template

For example, Zhian Kamvar uses Vim with the NVim-R plugin and 
[radian](https://github.com/randy3k/radian#readme). There is no one right way!

:::::::::::::::::::::::::::::::

## Lesson Template Modules (R packages)

The template is divided into three R pakages, which are designed to be modular
and upgradable on the fly. Because these are still in developement, please use
the following to install (*and update*) the packages:

First, **open R/RStudio** and then follow the instructions based on your
operating system:

::::::::::: solution

### MacOS/Windows

```r
# register the repositories for The Carpentries and CRAN
options(repos = c(
  carpentries = "https://carpentries.github.io/drat/",
  CRAN = "https://cran.rstudio.com/"
))

# Install the template packages to your R library
install.packages(c("sandpaper", "varnish", "pegboard"))
```

::::::::::::::::::::


::::::::::: solution

### Linux

Note: we are using the RStudio package manager. This is set up for Ubuntu 20.04,

:::: callout

### What if I have a different version of Linux?

If you have a different version of linux, you can visit https://packagemanager.rstudio.com/client/#/repos/1/overview, 
select your system where it says "Use this URL to work with the latest binary
packages for Ubuntu 20.04 (Focal) **change**", and replace the packagemanager
URL below.

::::

```r
options(repos = c(
  carpentries = "https://carpentries.github.io/drat/",
  CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"
))

install.packages(c("sandpaper", "varnish", "pegboard"))
```
::::::::::::::::::::

## Connect to GitHub

If you are currently able to interact with GitHub via the command line without
having to provide your password, then it is very likely that you already have
your credentials set up. 

To confirm that your Git session is correctly configured, open RStudio, and run
the following line to check if your credentials are set up properly:

```r
library("usethis")
git_sitrep()
```

```output
Git config (global)
● Name: 'Zhian N. Kamvar'
● Email: 'zkamvar@gmail.com'
● Vaccinated: FALSE
ℹ See `?git_vaccinate` to learn more
● Default Git protocol: 'ssh'
GitHub
● Default GitHub host: 'https://github.com'
● Personal access token for 'https://github.com': '<discovered>'
● GitHub user: 'zkamvar'
● Token scopes: 'gist, repo, user, workflow'
● Email(s): 'zkamvar@gmail.com (primary)'
Git repo for current project
ℹ No active usethis project
```

There will be a lot of output for this, but you will want to focus on the
**GitHub** section. If your output is similar to the one above, then no further
action nees to be taken.

If you see errors associated with your GitHub token (e.g.
'Token is invalid' or 'Can't retrieve registered email address(es)'), then you
should create a new one. Dr. Jenny Bryan wrote [an excellent resource for 
creating and caching your GitHub credentials on your computer
](https://happygitwithr.com/credential-caching.html#how-to-manage-a-pat) that
will walk you through the process of generating a PAT, and storing it in a 
secure location. Here are the steps briefly via R:

1. Create a GitHub PAT via R with `usethis::create_github_token()` (this will
   open a page in your browser. If this does not work, [use this link to 
   generate a new token for R](https://github.com/settings/tokens/new?scopes=repo,user,gist,workflow&description=R:GITHUB_PAT).)
2. Copy and store the token in a password manager (Lastpass, 1Password)
3. Back in R, use `gitcreds::gitcreds_set()` to register your token with git.


[R]: https://cran.rstudio.org/
[pandoc]: https://pandoc.org/
[RStudio]: https://rstudio.com/products/rstudio/download/#download
