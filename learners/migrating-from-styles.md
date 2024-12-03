---
title: Migrating lessons from the previous infrastructure
---

This page describes a workflow for semi-automated transition from The Carpentries old infrastructure to the Workbench.
It is based on the transition workflows and documentation originally written by [Zhian Kamvar](https://github.com/zkamvar/). See the full set of lesson transition scripts and documentation at <https://github.com/carpentries/lesson-transition>.
Please contact [The Carpentries Curriculum Team](mailto:curriculum@carpentries.org) with questions about this workflow.

The workflow is intended for use by Carpentries community members who want to transition their own lesson repository from the old "styles" infrastructure to use the Workbench.

After following this process you will have replaced the contents of your current lesson repository with a Workbench version containing the same lesson content. 

::: callout
**_We strongly recommend that you create a backup of your lesson repository before you follow this workflow._**
:::

:::::::: prereqs 

## Prerequisites

Before following the steps described below, please make sure that you have done the following:

1. Enabled push access to GitHub from the command line on your local system: you will need to have SSH or HTTPS access configured to allow you to push changes to your GitHub repository from the command line. See [_Authenticating with the command line_](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github#authenticating-with-the-command-line) in GitHub's documentation for more details and step-by-step guides.
2. Merged or closed all open pull requests on your lesson repository. Any open pull requests will be rendered invalid by the migration between infrastructures.
3. Installed Git and R on your local system. The workflow described below assumes that you can call R as a command from a Bash shell session.
4. (Optional, but highly recommended) archived a final version of your lesson in the old infrastructure. Although this workflow has been documented with recommendations to minimise the chances of accidentally overwriting your lesson with anything other than a fully-tranisitoned equivalent, it is still wise to ensure that you have a complete and up-to-date copy of your lesson as a backup. For example, you could publish a release to [Zenodo](https://zenodo.org/).
5. (Optional, but highly recommended) created or synced up a fork of the lesson. This can be used to test the transitioned lesson on GitHub before making the final, irreversible changes to your primary lesson repository. The fork only needs to contain a copy of the default branch of your lesson (usually `gh-pages`).

:::::::::::::::::

---

## Transition Workflow

1. [Set up the transition tools](#workflow-setup)
2. [Create an Rscript for your lesson](#Rscript)
3. [Run the transition tool](#transition)
4. [Set up your GitHub repository to receive the transitioned lesson](#github)
5. [Post-transition steps](#post-transition)

::: callout
Note: these steps assume your lesson exists in The Carpentries Incubator i.e. under the `carpentries-incubator` organisation on GitHub. If it does not, you will need to replace all of the folder names etc below accordingly.
:::

### 1. Set up the transition tools{#workflow-setup}

1. Open a Bash shell and run the following:

    ```bash
    git clone https://github.com/carpentries/lesson-transition.git && cd lesson-transition
    git switch -c YOUR-LESSON-NAME-transition # provide a branch name appropriate for your lesson, e.g. for the carpentries-incubator/docker-introduction lesson, you would call the branch docker-introduction-transition
    git submodule update --init git-filter-repo # this will ensure the git-filter-repo tool is available
    ```

2. Install dependencies for lesson transition tool:
    - If you already have `renv` installed on your system: open R in this directory (run the `R` command in Bash), answer `y` to the prompt `Would you like to restore the project library?`, wait for the project setup to complete, then exit R
    - If you do not yet have `renv` installed: open R in this directory (run the `R` command in Bash), then run the following:

        ```R
        install.packages('renv') # enter 'y' to complete the installation
        library('renv')
        renv::restore()
        ```
      
      or run the following commands in Bash:

        ```bash
        Rscript -e "install.packages('renv')" # enter 'y' to complete the installation
        Rscript -e "library('renv')"
        Rscript -e "renv::restore()"
        ```

3. Returning to Bash (you can quit R by calling the `q()` function), run the following:

    ```bash
    Rscript establish-template.R template/
    git submodule add --force -b gh-pages https://github.com/carpentries-incubator/YOUR-LESSON-NAME carpentries-incubator/YOUR-LESSON-NAME # replace YOUR-LESSON-NAME with the name of your lesson, and replace 'gh-pages' with 'main' if main is the default branch for your lesson
    ```

### 2. Create an Rscript for your lesson{#Rscript}
The transition tool requires an R script to exist for any lesson it migrates to the new infrastrucure. In the large-scale transition of Carpentries lessons, these R scripts were used to handle various edge cases, customisations to the standard Markdown syntax, etc that existed in every lesson but were unique to each.

The script is run on the version of the Workbench lesson created by the transition tool, as a kind of post-processing step before the changes made by the transition are committed. Any changes made by the script will appear as if carried out by the transition tool, thereby avoiding additional commits in your project history associated with "cleaning up" after the migration.

It is sufficient to create an empty file, named appropriately. This is available in the add-lesson.sh file, which will also provide hints about how the data can be transformed. 

::::::::::::::::::::::::::::::::::::::: caution

It is essential that you do not include a trailing `/` after YOUR-LESSON-NAME below.)

:::::::::::::::::::::::::::::::::::::::::::::::


```bash
bash add-lesson.sh carpentries-incubator/YOUR-LESSON-NAME
```

But you may wish to populate this script with some function calls to clean up various common artifacts produced by the transition, or to preserve any [custom workflows](#custom-workflows) you have added to your lesson repository. Look at the `.R` scripts in the [`carpentries-incubator/`](https://github.com/carpentries/lesson-transition/tree/main/carpentries-incubator), [`datacarpentry`](https://github.com/carpentries/lesson-transition/tree/main/datacarpentry), [`librarycarpentry`](https://github.com/carpentries/lesson-transition/tree/main/librarycarpentry), and [`swcarpentry`](https://github.com/carpentries/lesson-transition/tree/main/swcarpentry) directories of the `lesson-transition` repository for inspiration.

### 3. Run the transition tool{#transition}

#### Try this first

In Bash, run the release process via `make` to save yourself some work:

```bash
make release/carpentries-incubator/YOUR-LESSON-NAME.json
```

::: callout
Notes:

* the `YOUR-LESSON-NAME.json` file does not need to exist for these commands to run
* if you would like to run a test first, you can use `make sandpaper/carpentries-incubator/YOUR-LESSON-NAME.json`, which will create a 'beta test' version of the transitioned lesson in the `carpentries-incubator` folder.
:::

#### If that doesn't work...

Try running the process step-by-step:

1. In Bash, run:

    ```bash
    bash filter-and-transform.sh release/carpentries-incubator/YOUR-LESSON-NAME.json carpentries-incubator/YOUR-LESSON-NAME.R $(readlink -f ./filter-list.txt) 'return message'
    cd release/carpentries-incubator/YOUR-LESSON-NAME
    LESSONNAME=`pwd | rev | cut -d/ -f1 | rev`
    for FILENAME in commit-map ref-map suboptimal-issues
    do
        cp .git/filter-repo/$FILENAME ../$LESSONNAME-$FILENAME.hash
    done
    egrep ' 0{40}$' .git/filter-repo/commit-map | cut -d' ' -f1 | head -1 > ../$LESSONNAME-invalid.hash
    if [ ! -s ../$LESSONNAME-invalid.hash ]; then rm ../$LESSONNAME-invalid.hash;fi
    ```
2. Adjust lesson config file
    * **Option 1 (manual):** Using your favourite text editor, open the `config.yaml` file and remove the lines setting the `workbench-beta`, `analytics`, `lang`, and `url` parameters.
    * **Option 2 (using regular expressions):** In Bash, run:

        ```bash
        grep -v -E '^workbench-beta|^analytics|^lang|^url' config.yaml > config-filtered.yaml && mv config-filtered.yaml config.yaml
        ```
3. Set the correct address for your origin remote repository. In Bash, run:

    ```bash
    git remote set-url origin ADDRESS-OF-YOUR-REMOTE # replace ADDRESS-OF-YOUR-REMOTE to set origin to the correct address for your lesson repository on GitHub
    ```

::: callout

### Custom workflow files{#custom-workflows}
The contents of the `.github` folder are not preserved by the transition tool. If you had any custom workflow files in your lesson repository before migrating to the new infrastructure, you will need to add those back into `.github/workflows/` at this point then commit the changes. (You could also modify the Rscript for your lesson transition to do this for you, and repeat the transition process to include it.)

:::


#### Build and check your transitioned lesson
At this stage, the `release/carpentries-incubator/YOUR-LESSON-NAME/` directory should contain a transitioned version of your lesson. 
To check how things are looking, [install the Workbench tools for your system](index.html#installation), then open R in this directory and run `sandpaper::serve()`.

#### Optional: update your lesson's R script to produce a smoother transition
While previewing this transitioned lesson site, you might see some problems in the content of your lesson site that appeared during the migration. Liquid comments (delineated by `{% comment %}` and `{% endcomment %}` tags) are one commonly-encountered artifact. Another is broken links to the lesson setup instructions, which are found at `index.html#setup` in a Workbench site. These can be fixed by editing the lesson after transition, but for a cleaner commit history on your lesson you might wish to delete the transitioned lesson directory (inside the `release` folder), modify the R script for your lesson to handle those issues, and re-run the transition tool. (See [_Create an Rscript for your lesson_](#Rscript) above.)

#### If something goes wrong
To go back to the start and try again, delete the directory for your lesson within the `release/` directory, i.e. `rm -rf release/carpentries-incubator/YOUR-LESSON-NAME`.

If the transition tool ran successfully but your lesson build fails, this is usually due to customisations made to the lesson that fall outside what the transition tool expected to find.
If you run into problems, we recommend that you try to identify differences between yours and a typical lesson repository (the [Workbench Markdown template](https://github.com/carpentries/workbench-template-md) and [R Markdown template](https://github.com/carpentries/workbench-template-rmd) are good examples) and experiment to see if any of those are causing the site build to fail.

If something goes wrong and you cannot debug the problem on your own, post a message to the `#workbench` channel on The Carpentries Slack workspace, or reach out to the Curriculum Team by email (curriculum@carpentries.org). Try to provide as much information as you can, including any error messages and logging information that were produced when you ran the steps described above. We will do our best to help you but please note that the Core Team's capacity to provide support for transition of community lessons is severely limited.

### 4. Set up your GitHub repository to receive the transitioned lesson{#github}

::: callout
**We recommend that you try these steps out on a fork of your lesson first**, so that you can be certain everything works before making permanent changes to your main lesson repository.
:::

1. Adjust the `config.yaml`:
    - Record your lesson creation date in config.yaml: run `git log` and hit <kbd>Shift+G</kbd> to jump to end of file, note down the date when the first commit was made. Then, using your favourite text editor, open `config.yaml` and modify the `created` field by replacing `~` with this creation date in YYYY-MM-DD format.
    - Check the `source` URL specified in `config.yaml`: this may be set incorrectly during the transition process. Adjust it to the correct URL for your lesson source repository on GitHub.

3. Commit the changes you made to the lesson config file:

    ```bash
    git add config.yaml
    git commit -m 'complete configuration of Workbench lesson site'
    ```

4. Rename the branches of your project:
    - On your GitHub repository, rename the `gh-pages` branch to `legacy/gh-pages` (if `main` is your default branch, also rename that to `legacy/main`).
        - Branches can be renamed by going to the list of all branches on your repository (add `/branches/all` to the end of the URL for your GitHub repository e.g. <https://github.com/datacarpentry/image-processing/branches/all>) and selecting the pencil icon button next to the relevant branch in that listing.
5. In Bash on your local system (make sure you are working in the root of the `release/carpentries-incubator/YOUR-LESSON-NAME` directory), run the following commands (please read the comments that annotate these commands and note that **we strongly recommend that you execute these one-at-a-time!**):

    ```bash
    git remote -v # check the names and addresses of your remote repositories: if you are testing on a fork and it is not listed here, add it with 'git remote add' https://git-scm.com/docs/git-remote#Documentation/git-remote.txt-emaddem
    git fetch --prune origin # this assumes your remote is called origin - if you are testing on a fork, use the name of that remote here instead
    git checkout --orphan gh-pages # set up gh-pages branch
    # double-check that you are in the root of your lesson within the lesson-transition/release folder (e.g. if transitioning carpentries-incubator/docker-introduction, you should be in lesson-transition/release/carpentries-incubator/docker-introduction/)
    git rm -rf .
    mkdir -p .github/workflows/
    curl -o .github/workflows/close-pr.yaml https://raw.githubusercontent.com/carpentries/lesson-transition/main/close-pr.yaml # download the workflow that will auto-close invalid PRs to gh-pages
    git add .github/workflows/close-pr.yaml
    git commit --allow-empty -m 'Initialising gh-pages branch'
    git push --force origin HEAD:gh-pages
    ```

6. If everything has gone well up to this point, it is time to go back to the `main` branch and force push its contents to GitHub:

    ```bash
    git switch main
    git push --force --set-upstream origin main # force push the transitioned main branch to your GitHub repository
    ```

7. On your GitHub repository:
    - set the default branch to `main` (in Settings->General, click the button with two arrows next to the name of the default branch)
    - in Settings->Branches, add rules to protect the `main` branch (require pull requests) and lock `legacy/*`
    - make sure that your lesson site is being served with GitHub Pages from the root folder of the gh-pages branch (in Settings->Pages, under _Build and deployment_, ensure that `gh-pages` is selected with the dropdown under _Branch_ and that `/ (root)` is the folder selected, then hit the _Save_ button)

If all of the above worked, you should now have a Workbench version of your lesson.

### 5. Post-transition steps{#post-transition}

After you have transitioned your lesson, you should:

1. **Delete and re-create any forks and local clones** of your lesson project, to minimise the likelihood that you will accidentally push the old project history back to the GitHub repository. If you have any collaborators and fellow lesson developers/maintainers, ask them to do the same.
2. If your lesson is in The Carpentries Incubator, [**tell the Curriculum Team**](mailto:curriculum@carpentries.org) that you have completed the transition so that we can activate the automated creation of pull requests to update the Workbench infrastructure when new versions of the packages are released.
3. If your lesson is _not_ in the Incubator, **enable automated pull requests to keep your infrastructure updated** by adding a SANDPAPER_WORKFLOW token to your repository:
    * Navigate to <https://github.com/settings/tokens/new> and give your new token a name (e.g. "Sandpaper Token (YOUR-ORG-OR-USER-NAME/YOUR-LESSON-NAME)").
    * Check the box next to _workflow_.
    * Set an expiry date for the token.
    * Select _Generate token_.
    * Copy the token displayed on the screen.
    * On your GitHub repository:
        * Navigate to Settings->Secrets and variables->Actions->New repository secret
        * Set _Name_ to SANDPAPER_WORKFLOW, and paste your new token into the _Secret_ box.
        * Select Add secret
  
  The maintenance workflows that use this token are scheduled to run weekly. When The Carpentries releases new versions of the workflow files used to build and maintain lessons, a pull request will be opened automatically on any repository with the SANDPAPER_WORKFLOW token set to incorporate the relevant updates. If your lesson uses R Markdown source files, the same token will be used to keep the package dependencies for your lesson updated.
5. (Optional, but highly recommended) Open a pull request to https://github.com/carpentries/reactables/ to **add the invalid commit hash** (in the `invalid.hash` file created for your lesson during the transition (step 3 above)) to [the `workbench/invalid-hashes.json` file](https://github.com/carpentries/reactables/blob/main/workbench/invalid-hashes.json). This will include the hash in the data feed used by our infrastructure to support the GitHub Actions workflow that will automatically close any pull requests opened to your repository from a branch containing the old project history. To do this:
    * Make a fork of [the `carpentries/reactables` GitHub repository](https://github.com/carpentries/reactables/)
    * On a new branch of that fork, edit the `workbench/invalid-hashes.json` file, adding a new line before the final `}` line matching the format of the other lines containing hashes, i.e. 
      `"carpentries-incubator/YOUR-LESSON-NAME": "HASHASHASHASHASHASHASH"`
      where `HASHASHASHASHASHASHASH` is the hash contained in the `release/carpentries-incubator/YOUR-LESSON-NAME-invalid.hash` file created during the infrastructure transition. Make sure to add a comma `,` to the end of the preceding line to ensure the validity of the JSON file.
    * commit the change, then open a pull request back to `carpentries/reactables` to suggest that we merge your invalid hash into our data feed. A member of the Curriculum Team will review and merge your changes.
