---
title: "Lesson Deployment"
teaching: 5
exercises: 0
---

::::::::::::::::::::::::::::: questions

 - What is the two-step model of deployment?
 - How do we use the two-step model to provide PR audits?

:::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::: objectives

 - Understand the two-step model for lesson deployment
 - Understand the Pull Request Preview for generated lesson content

::::::::::::::::::::::::::::::::::::::::

## How we got here

Since 2016, [we have supported using RMarkdown in lessons][rmd-blog]. The 
benefits have been that authors no longer need to manually copy and paste 
output and graphs into their documents. We were even able to use continuous
integration to build the RMarkdown documents to markdown so that they would be
then deployed using Jekyll.

The downside to this model was that the maintainers would occasionally encounter
unexpected outputs from new contributions because there was either a syntax
error or [the R ecosystem had changed paradigms][r4-migration]. Moreover, people
would often edit the generated markdown file instead of the source RMarkdown
file, which would result in progress being lost because of a regenerated file.

## The two-step model of deployment

To alleviate the downsides of working with generated content, the new template
employs a two-step model of deployment when you run `sandpaper::build_lesson()`

1. Take any source files with content that needs to be interpreted (e.g. 
   RMarkdown and in the future Jupyter Notebooks) and **render them to markdown**
   in a staging area ignored by git. 
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

### Did you know?

When the lesson is pushed to GitHub, all of the generated content IS stored in
separate branches so that we can provide a way for you to audit changes from 
pull requests. 

::::::::::::::::::::::

## On GitHub

On GitHub, we store generated content in two orphan branches called
`md-outputs` and `gh-pages` for the generated markdown and html, respectively. 
We use [GitHub Actions Workflows][gh-workflows] to build, validate, and deploy
our lessons on GitHub pages. If you use pure markdown lessons, you should notice
no significant changes to your workflow. 

These workflows are the source of truth for the lessons and will keep your 
lesson up-to-date with the latest version of the HTML template. 

If you use RMarkdown lessons, you will notice that for every pull request, a
GitHub bot comments on your pull requests informing you about what content has
changed and gives you a link to the differences between the current state of
the `md-outputs` branch and the proposed changes.

The controls for these actions live in the `.github/workflows` folder of your 
repository and are currently maintained in {sandpaper}. 

::::::::::::: callout

### Risk Management

Accepting generated content into lessons from anyone runs the risk of a security
breach by exposing secrets. To mitigate this risk, GitHub limits the scope of
what is possible inside a pull request so that we can check and render the 
content without risk of exploitation. Through this, we render and check the 
lesson inside the pull request with no privileges, check that the pull request
is valid (not malicious), and then create a temporary branch for an exploratory
preview, allowing the maintainer to audit the generated content before it gets
adopted into the curriculum. 

If the PR is invalid (e.g. the contributor spoofed a separate, valid PR, or
modified one of the github actions files), then the maintainer is alerted that
the PR is potentially risky.


![The pull request cycle. Ellipse nodes (Pull Request and Maintainer Review) are the only places that require maintainer attention.](https://raw.githubusercontent.com/zkamvar/stunning-barnacle/main/img/pr-flow.dot.svg){alt="Workflow diagram from a pull request starting from Pull Request, and going to a path involving validation, artifact creation, maintainer review, and potential deployment."}

::::::::::::::::::::

## Updating Your Workflows

The workflows are the the only place in our lesson that needs to be kept
up-to-date with upstream changes from [{sandpaper}]. While we try as much as
possible to keep the functionality of [{sandpaper}] inside the package itself,
there are times when we need to update the GitHub workflows for security or
performance reasons. You can update your workflows in one of two ways: via 
GitHub or via [{sandpaper}].

### Via GitHub

To update your workflows in GitHub, go to 
`https://github.com/(ORGANISATION)/(REPOSITORY)/actions/workflows/update-workflows.yaml`

Once there, you will see a button that says "Run Workflow" in a blue field to
the right of your screen. Click on that Button and it will give you two options.
You can leave these as-is or replace them with your own values. You can now hit
the green "Run Workflow" button.

After ~10 seconds, your workflow will run and a pull request will be created 
from a GitHub bot (at the moment, this is @znk-machine) if your workflows are
in need of updating.

Check the changes and merge if they look okay to you. If they do not, contact
@zkamvar. 


### Via R

To update your workflows via [{sandpaper}], you can use the following command
in your lesson:

```r
sandpaper::update_github_workflows()
```

After that, you can add and commit your changes and then push them to GitHub.


:::::::::::::::::::::::::::::: keypoints

 - Lessons are built using a two-step process of caching markdown outputs and then building HTML from that cache
 - We use GitHub Actions to deploy and audit generated lesson content to their websites

::::::::::::::::::::::::::::::::::::::::


[rmd-blog]: https://software-carpentry.org/blog/2016/07/rmarkdown-new-template.html
[r4-migration]: https://carpentries.org/blog/2020/08/r-4-migration/
[gh-workflows]: https://docs.github.com/en/actions/ 
[{sandpaper}]: https://carpentries.github.io/sandpaper
