---
title: Setup
---

## Overview

The lesson infrastructure is built on Git, the R language, and pandoc. It consists of 
four components:

1. The source content (plain markdown or RMarkdown files organized into folders
   with a configuration yaml file)
2. The engine (R package [{sandpaper}])to orchestrate building the content from
   markdown to HTML
3. The validator (R package [{pegboard}]) to parse the source files and
   highlight common errors
4. The style (R package [{varnish}]) HTML, CSS, and JavaScript styling elements
   for the final website

Details of how these tools work together are explained in the [Lesson 
Deployment chapter](../episodes/deployment.md). In short, you can expect to
interact with the source content and {sandpaper} to author and preview your
lesson.

### Required Software {#required}

This setup document will walk you through the process of installing or upgrading
the required software in the following order.

1. **[Git]** (&ge; 2.28 recommended)
2. **[R]** (&ge; 4.x)
3. **[pandoc]** (&ge; 3.x)
4. The lesson infrastructure R packages
   i. **[{sandpaper}]** (development version)
   ii. **[{varnish}]** (development version)
   iii. **[{pegboard}]** (development version)
   iiii. **[{tinkr}]** (markdown parser required by {pegboard})

   Once you have Git, R, and Pandoc installed, these packages can be installed
   and updated via:
   ```r
   install.packages(c("sandpaper", "varnish", "pegboard"),
     repos = c("https://carpentries.r-universe.dev/", getOption("repos")))
   ```

### Recommended Software {#recommend}

If you are using R or pandoc for the first time, we recommend using [the RStudio
IDE][RStudio] for the following reasons:

1. It comes with [pandoc] pre-installed.
2. It works consistently across all major platforms.
3. It provides a dedicated BASH console so you can easily switch between R and Git
   operations.
4. There are convenient keyboard shortcuts to preview lessons.
5. On Windows, it will automatically detect your R installation without you
   needing to edit your `PATH`.

If you do not want to use RStudio, that's perfectly okay and expected! We want
to be able to meet you where you are to work with the new template. If you feel
comfortable using a different tool (e.g. the command line or VSCode), then you
should install R and pandoc separately and make sure that they are in your path.


### Installation 

This will guide you through installing the foundational software and 
infrastructure packages on your computer. If you already have software
installed and are curious if you should update it to a newer version, the answer
is almost always, yes, update to a newer version, because often the newer
versions will contain important bug fixes that are important to the secruity of
your computer.

Jump to the installation instructions for your system: [Windows](#windows),
[MacOS](#mac), or [Linux](#linux)

## Installing on Windows {#windows}

### Git

We recommend installing git via the [Git for Windows installer](https://gitforwindows.org/). The installer is going to ask a lot of questions,
so we recommend [using The Carpentries instructions for workshop
participants](https://carpentries.github.io/workshop-template/#the-bash-shell).

#### Test your installation

To test that you have git installed, open your command line by pressing <kbd>Windows</kbd>+<kbd>R</kbd>
and type `cmd` to bring up the command prompt. From there, you
can type `git --version` to see the version of your git installation. You might
see something like this:

```bash
git --version
```

```output
git version 2.31.1.windows.1
```

If, however, you see this error, then you should try to install git again. 

```error
'git' is not recognised as an internal or external command,
operable program or batch file.
```


### R

Install the [latest version of R for Windows](https://cran.r-project.org/bin/windows/base/). There is also a video tutorial
up on [The Carpentries instructions for workshop
participants](https://carpentries.github.io/workshop-template/#r-1)
that can be quite helpful for parsing the steps of installing R on Windows.

::::::::::::::::::::: callout

#### Optional: Want to add R to your PATH? {#winpath}

As we mention above, [we recommend using RStudio for your lesson](#recommend),
but if you want to be able to integrate the lesson infrastructure into your own
preferred workflow, you need to have R on your path. The catch is that R for
Windows does not automatically set your `PATH` variable. 

[Here are some instructions on setting up your PATH on Windows using both the
GUI and CLI](https://www.maketecheasier.com/what-is-the-windows-path/). Note
that R will normally install at something like 
`c:\Program Files\R\R-4.1.0\bin\x64`, but if you are not admin, it will install
in your Documents folder. 

To verify that R is installed in your `PATH`, open your command line by pressing
<kbd>Windows</kbd>+<kbd>R</kbd>
and type `cmd` to bring up the command prompt. From there,
you can type `R --version` at the prompt. Your output should be similar to below,
with a version ≥ 4.x.

```bash
R --version
```
```output
R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.
```

:::::::::::::::::::::::::::::

### pandoc

There are two ways to install pandoc:

#### Via RStudio (recommended)

Since pandoc comes bundled with RStudio, you can install it by installing the
latest version of RStudio. You can [download the installer from the RStudio 
website][RStudio].

#### Via the pandoc website

If you are comfortable adding R to your windows PATH (see [previous 
section](#winpath)), then you can install pandoc by using the binary provided on
its website at <https://pandoc.org/installing.html>

#### Test your installation

We will wait to test the pandoc installation after we have installed the
infrastructure packages, to make sure it's discoverable by R. 

### Infrastructure R packages

To install the R packages, you will need to **open RStudio** (or start R from
the command line if you did not install RStudio) and enter the following lines
into the console.

```r
# register the repositories for The Carpentries and CRAN
options(repos = c(
  carpentries = "https://carpentries.r-universe.dev/",
  CRAN = "https://cran.rstudio.com/"
))

# Install the template packages to your R library
install.packages(c("sandpaper", "varnish", "pegboard"))
```

## Installing on MacOS {#mac}



### Git

You should have git pre-installed on your macOS, but it is likely that this is
an old version. We recommend installing [The latest version of Git for MacOS](https://git-scm.com/downloads/mac). 
For a video guide, you can look at 
the [instructions for workshop 
participants](https://carpentries.github.io/workshop-template/#git-1).

#### Test your installation

To test your installation of Git and confirm it works, open **Terminal.app** and
type the following:

```bash
git --version
```

```output
git version 2.31.0
```

If you have the default version of git, you might see this output, and that's
okay for the purposes of this template.

```output
git version 2.24.3 (Apple Git-128)
```

### R

::: prereq

### Homebrew Not Recommended

Installing R via Homebrew can allow you to customise your installation, but you
lose the advantage of having readily available package binaries. Moreover, if
you do not have the required C libraries (e.g. `libxslt`) installed, then the
installation of some packages will fail. So, unless you are prepared for this,
please do not use Homebrew to install R.

:::


You can install the [latest R release][R] for MacOS from 
<https://cran.r-project.org/bin/macosx>. There is also a video tutorial
up on [The Carpentries instructions for workshop
participants](https://carpentries.github.io/workshop-template/#rstats-macos)
that can be quite helpful for parsing the steps of installing R on MacOS.

#### Test your installation

You can test your installation of R by opening **Terminal.app** and typing `R
--version` into the prompt.  Your output should be similar to below,
with a version ≥ 4.x.

```bash
R --version
```
```output
R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin17.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.
```

### pandoc

There are two ways to install pandoc:

#### Via RStudio (recommended)

Since pandoc comes bundled with RStudio, you can install it by installing the
latest version of RStudio. You can [download the installer from the RStudio 
website][RStudio]. RStudio will be a `*.dmg` (disk image) that you will
double click to open a window that will look something like this:

![](fig/rstudio-mac-install.png){alt="Installation window for RStudio on mac
showing two items on a plain background: the Applications folder on the left and
the RStudio icon on the right."}

You should *drag the RStudio icon to the left, **into** the Applications folder*
to install RStudio on your computer.

#### Via the pandoc website

If are more comfortable using R from the command line, then you can [install
pandoc](https://pandoc.org/installing.html) by clicking the "Download the latest 
installer for macOS" button. This will save a file called 
`pandoc-X.XX-macOS.pkg` installer to your computer. Open the installer and
follow the instructions to install pandoc on your computer.

#### Test your installation

We will wait to test the pandoc installation after we have installed the
infrastructure packages, to make sure it's discoverable by R. 

### Infrastructure R packages

To install the R packages, you will need to **open RStudio** (or start R from
the command line if you did not install RStudio) and enter the following lines
into the console.

```r
# register the repositories for The Carpentries and CRAN
options(repos = c(
  carpentries = "https://carpentries.r-universe.dev/",
  CRAN = "https://cran.rstudio.com/"
))

# Install the template packages to your R library
install.packages(c("sandpaper", "varnish", "pegboard"))
```

## Installing on Linux {#linux}

Instructions for installing on Linux are nuanced due to the variety and availability of 
libraries and dependencies for each distribution, e.g. Ubuntu is Debian based whereas 
Fedora is Red Hat based. These instructions will use Ubuntu as the preferred distribution. 
The default `apt` repository is often out of date, so you will need to use a 
[Personal Package Archive aka PPA](https://itsfoss.com/ppa-guide/) to install
the latest version of a particular software, which will be included in these
instructions. 

### Git

Many distributions include git by default, but it is often outdated. 
It is useful to try to update in case a newer version is available:

```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

#### Test your installation

Test your git installation by opening the terminal and running

```bash
git --version
```
```output
git version 2.31.1
```

### R

To install R, you can visit [CRAN's Linux page](https://cran.r-project.org/bin/linux/) to check if
your platform is supported. Detailed instructions exist [for Ubuntu](https://cran.r-project.org/bin/linux/ubuntu/). 
Here are the commands to register
the PPA on your machine and then install R:

```bash
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# import the signing key (by Michael Rutter) for these repo
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Install R
sudo apt install --no-install-recommends r-base
```

#### Test your installation

Test your R installation by opening your terminal and running  
`R --version` into the prompt.  Your output should be similar to below,
with a version ≥ 4.x.

```bash
R --version
```

```output
R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.

```

### pandoc

There are two ways to install pandoc:

#### Via RStudio (recommended)

Pandoc comes bundled with RStudio. You can [download the installer from the RStudio
website][RStudio]. When installing RStudio for Linux, your distribution may not
be shown on the landing page. If your Ubuntu version is not listed, check the 
[RStudio Previous Versions](https://docs.posit.co/previous-versions/rstudio.html) page
to see if there are builds available.

::::::::::: callout

##### Optional: verify the install

You can optionally verify the download before installing by following the
instructions at <https://posit.co/code-signing/>.

:::::::::::::::::::


#### Via the pandoc website

If you are more comfortable using R from the command line, then you can install
pandoc from the [releases page](https://pandoc.org/installing.html). From the list on the GitHub page,
for Ubuntu, choose the appropriate `.deb` file for your chip architecture (i.e. AMD64 or ARM64).

#### Test your installation

We will wait to test the pandoc installation after we have installed the
infrastructure packages, to make sure it's discoverable by R. 

### Infrastructure R packages

Linux packages normally need to be compiled into binaries by your system, which can take a 
long time the first time it happens. RStudio provides a package manager that
pre-compiles Linux binaries. Note that you do not have to be using RStudio to
take advantage of these binaries. The one we are using is set up for Ubuntu 
22.04 (jammy).

::::: callout

#### Dependencies of Dependencies

If you are not used to installing software on Linux, it can be frustrating 
sometimes because things can go wrong and it’s not always immediately clear why. The
same is true for some R packages with compiled code.

Some packages require underlying C libraries (e.g. the xml2 library), which are
catalogued for Ubuntu in [The Carpentries R
Universe](https://carpentries.r-universe.dev/ui#builds) and [available via the
API](https://carpentries.r-universe.dev/apis). To produce a list 
(you may need to `sudo apt install jq` if it is not already on your system):

```bash
curl https://carpentries.r-universe.dev/stats/sysdeps 2> /dev/null | jq -r '.headers[0] | select(. != null)'
```

This list can be sent to `apt install` to install everything:

```bash
sudo apt-get install -y \
  $(curl https://carpentries.r-universe.dev/stats/sysdeps 2> /dev/null | jq -r '.headers[0] | select(. != null)') 2> /dev/null \
  || echo "Not on Ubuntu"
```

After you have these installed, you will be able to install the required R 
packages without error. 

:::::

:::: callout

#### What if I have a different version of Linux?


For the dependencies above, you can browse the [rstudio/r-system-requirements 
repository](https://github.com/rstudio/r-system-requirements) to find the
correct formulation for your computer.

In addition, you should check [the supported operating systems for the Posit
Package
Manager](https://packagemanager.posit.co/__docs__/admin/serving-binaries/#supported-operating-systems)
to see if you will benefit from pre-built binaries.


::::

To install the R packages, you will need to **open RStudio** (or start R from
the command line if you did not install RStudio) and enter the following lines
into the console.

```r
# Set the default HTTP user agent to get pre-built binary packages
RV <- getRversion()
OS <- paste(RV, R.version["platform"], R.version["arch"], R.version["os"])
codename <- sub("Codename.\t", "", system2("lsb_release", "-c", stdout = TRUE))
options(HTTPUserAgent = sprintf("R/%s R (%s)", RV, OS))

# register the repositories for The Carpentries and CRAN
options(repos = c(
  carpentries = "https://carpentries.r-universe.dev/",
  CRAN = paste0("https://packagemanager.posit.co/all/__linux__/", codename, "/latest")
))

# Install the template packages to your R library
install.packages(c("sandpaper", "varnish", "pegboard"))
```

::::::::::::: discussion

#### Saving these settings for later

To not have to run this block of code every time you want to update, 
add the following code into your `~/.Rprofile` to run it every time you open your terminal:

::::::::::::::::::::::::

:::::: solution

#### Add this to `~/.Rprofile`

```r
local({
  # Set the default HTTP user agent to get pre-built binary packages
  RV <- getRversion()
  OS <- paste(RV, R.version["platform"], R.version["arch"], R.version["os"])
  codename <- sub("Codename.\t", "", system2("lsb_release", "-c", stdout = TRUE))
  options(HTTPUserAgent = sprintf("R/%s R (%s)", RV, OS))

  # register the repositories for The Carpentries and CRAN
  options(repos = c(
    carpentries = "https://carpentries.r-universe.dev/",
    CRAN = paste0("https://packagemanager.posit.co/all/__linux__/", codename, "/latest")
  ))
})
```
:::::::::::::::


::::::::::::: callout

#### What if I get errors installing packages?

If you run into errors (non-zero exit status), it probably means that you were
missing a C library dependency that needs to be installed via your package 
manager (i.e. apt). To resolve these issues, scroll back in the log and you
might find messages that looks similar to this:

```output
* installing *source* package ‘xslt’ ...
** using staged installation
Package libexslt was not found in the pkg-config search path.
Perhaps you should add the directory containing `libexslt.pc'
to the PKG_CONFIG_PATH environment variable
No package 'libexslt' found
Using PKG_CFLAGS=-I/usr/include/libxml2
Using PKG_LIBS=-lexslt -lxslt -lxml2
-----------------------------[ ANTICONF ]-------------------------------
Configuration failed to find libexslt library. Try installing:
 * deb: libxslt1-dev (Debian, Ubuntu, etc)
 * rpm: libxslt-devel (Fedora, CentOS, RHEL)
 * csw: libxslt_dev (Solaris)
If libexslt is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a libexslt.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
---------------------------[ ERROR MESSAGE ]----------------------------
<stdin>:1:10: fatal error: libxslt/xslt.h: No such file or directory
compilation terminated.
------------------------------------------------------------------------
```

Use the instructions in these logs to install the correct package from your
terminal and then open R or RStudio and retry installing the packages. 
For example, for the error above, use `sudo apt install libxslt1-dev`.

:::::::::::::::::::::

## Test your installation {#install-test}

Now that you have installed the lesson components, it is a good idea to run a
small test to verify that these components work together. To test your 
installation **open RStudio** (or launch R if you have not installed RStudio)
and enter the following commands to confirm everything works

```r
rmarkdown::pandoc_version()
tmp <- tempfile()
sandpaper::no_package_cache()
sandpaper::create_lesson(tmp, open = FALSE)
sandpaper::build_lesson(tmp, preview = FALSE, quiet = TRUE)
fs::dir_tree(tmp, recurse = 1)
```

```output
[1] '2.19.2'
ℹ Consent for package cache revoked. Use `use_package_cache()` to undo.
→ Creating Lesson in '/tmp/RtmpnRjHyr/file12f34734be05f'...
✔ First episode created in '/tmp/RtmpnRjHyr/file12f34734be05f/episodes/01-introduction.Rmd'
ℹ Workflows up-to-date!
✔ Lesson successfully created in '/tmp/RtmpnRjHyr/file12f34734be05f'
/tmp/RtmpnRjHyr/file12f34734be05f
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE.md
├── README.md
├── config.yaml
├── episodes
│   ├── 01-introduction.Rmd
│   ├── data
│   ├── fig
│   └── files
├── index.md
├── instructors
│   └── instructor-notes.md
├── learners
│   └── setup.md
├── profiles
│   └── learner-profiles.md
└── site
    ├── DESCRIPTION
    ├── README.md
    ├── _pkgdown.yaml
    ├── built
    └── docs
```

If the installation did not work, please [raise an issue on
GitHub](https://github.com/carpentries/sandpaper-docs/issues/new). 

## Installation FAQ

### Why does it take 5 lines of code to install the infrastructure?

As the Workbench packages are in The Carpentries R-Universe and not CRAN, 
we need to tell R to get the packages from R-Universe.

### What is an R Library?

An R library is a folder on your computer that stores R packages. When you
install R packages, the first message you will see will probably be something
like (on Windows):

```
Installing packages into ‘c:/Users/USER/Documents/R/win-library/4.0’
(as ‘lib’ is unspecified)
```

On Ubuntu, this may look like: 

```
Installing packages into ‘/home/<user>/R/x86_64-pc-linux-gnu-library/4.4’
```

This folder is where all of the R packages you install via `install.packages()`
will live. If you ever need to look this up, you can use the `.libPaths()`
function. 

### Using a personal library

Sometimes, your R session will issue a warning that says a folder is not
writeable and asks if you would like to use a personal library instead. In this
case, select "yes".

## Opening your R environment

If you are using
RStudio, you can open it by double-clicking on the RStudio icon in your
application launcher; you do not have to open R separately to use RStudio. 

If you are using R, you can open it in your terminal application by typing `R`.
Your prompt will be replaced by a `>`, which indicates that you are in R's 
interactive [REPL](https://glosario.carpentries.org/en/#repl). 

You can exit R or RStudio by typing `q()` in the R console. 

::::::::: prereq

### Setting up your R workspace

When you set up R, it's important to make sure you set it up to always start R
with a clean slate[^workspace]: never save your workspace on exit and never
load a previously saved workspace on startup.  

#### Via RStudio 

If you are using RStudio, you can [follow the instructions in this forum 
post](https://community.rstudio.com/t/first-line-of-every-r-script/799/12?u=zkamvar):

1. From the menu, select <cmd>Tools<cmd> > <cmd>Global Options</cmd>
2. Under **Workspace Options**, de-select "Restore .RData into workspace at
   startup" and set "Save workspace to .RData on exit" to "Never"

#### Via Command Line Interface

The flags `--no-restore` and `--no-save` will set these defaults, so you can 
create an alias for R in the `.bashrc` file in your home directory:

```bash
alias R='R --no-restore --no-save'
```

::::::::::::::::::

## Connect to GitHub

You will need to make sure your git session is connected to GitHub. To do so, 
you will need to use an SSH or HTTPS protocol. If you already know how to push
and pull from GitHub using the command line, you do not need to worry about 
setting this up. 

If you do not have this set up, you should [choose a protocol
](https://docs.github.com/en/github/getting-started-with-github/about-remote-repositories) 
and then set them up according to the instructions from GitHub. 

It’s recommended to use the SSH protocol, unless you explicitly cannot, 
e.g. behind an institutional firewall or proxy.

:::::::::::::::: callout

### Is GitHub's Documentation Confusing?

If you are like me, you may find GitHub's documentation slightly confusing 
and/or lacking. I've found the following resources to be extremely helpful for
setting up authentication credentials for your account:

[Remotes in GitHub (Software Carpentry)](https://swcarpentry.github.io/git-novice/07-github)
: A walkthrough of creating a repository on GitHub and pushing to it via the 
  command line.

[Connect to GitHub (Happy Git With R)](https://happygitwithr.com/push-pull-github.html)
: A walkthrough of creating a throwaway repository that gives you a good idea 
  for the mechanics of working with GitHub. 

[Cache credentials for HTTPS (Happy Git With R)](https://happygitwithr.com/credential-caching.html)
: Clear explanation on how to set up a Personal Access Token and the benefits of
  using HTTPS. This explains how to do this in both the shell and R.

[Set up keys for SSH (Happy Git With R)](https://happygitwithr.com/ssh-keys.html)
: Clear explanation on what SSH key pairs are and how to set up and connect them
  with GitHub. This has recommendations using both the shell and RStudio. 

::::::::::::::::::::::::

[Git]: https://git-scm.com/
[R]: https://cran.rstudio.org/
[pandoc]: https://pandoc.org/
[{tinkr}]: https://docs.ropensci.org/tinkr/
[RStudio]: https://rstudio.com/products/rstudio/download/#download
[^workspace]: By default, R will ask if you want to save your workspace to a
  hidden file called `.RData`. This is loaded when you start R, restoring your
  environment with all of the packages and objects you had previously loaded.
  This default behavior is not good for reproducibility and makes updating
  packages very very difficult. In 2017 Jenny Bryan wrote a very good article
  about the benefits of having a project-based workflow, starting from a clean
  slate: <https://www.tidyverse.org/blog/2017/12/workflow-vs-script/>
