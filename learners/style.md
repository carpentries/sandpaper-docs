---
title: 'Style Guide'
---

A collection of guidelines to follow when writing
source (R) Markdown files for use with {sandpaper}.
The Carpentries also provides a [general Style Guide](https://docs.carpentries.org/topic_folders/communications/resources/style-guide.html)
for written content e.g. blog posts, website and lesson content, etc.

- [Fenced Divs](#fenced-divs)
  - [Fence Length](#fence-length)
  - [Whitespace](#whitespace)
- [Figures](#figures)
- [Line Length](#line-length)

## Fenced Divs

### Fence Length

The following recommendations are made to improve legibility
and make it easier to distinguish between blocks of content
in source files.

#### First-level fenced divs

For increased legibility, we recommend an opening fence length of around 50 characters
(half to two-thirds of the screen), 
with a single space between the last colon and the class keyword.
The length of closing fences should match the length of the opening fence plus keyword,
for example:

```markdown
:::::::::::::::::::::::::::::::::::::::::: callout

### An example callout

This callout was opened with a fence of 50 characters.
The end of the closing fence aligns with
the last character in the 'callout' keyword.

::::::::::::::::::::::::::::::::::::::::::::::::::
```

#### Nested fenced divs (e.g. challenge solutions)

Where fenced divs are nested,
e.g. attaching a solution block to a challenge,
we recommend making the inner fences noticably shorter
than the outer fences, e.g. 25 characters (one quarter to one third of the screen).
E.g.

```markdown
:::::::::::::::::::::::::::::::::::::::: challenge

### An example challenge

This challenge was opened with a fence of 50 characters.

:::::::::::::::: solution

The nested solution block was opened with 25 characters,
to make it stand out from the challenge.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
```

#### Instructor Notes

Content written into divs with the 'instructor' class will only appear
in the Instructor View of the lesson website.
To help distinguish these blocks from the rest of the page content,
we recommend a longer fence length (80 characters) for 'instructor' blocks:

```markdown
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

## Stay hydrated

Rememeber to pause and drink some water.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
```

### Whitespace

For legibility and to avoid 
[potential formatting issues](https://github.com/carpentries/sandpaper/issues/355),
empty lines should flank the fences of a fenced div, e.g.

```markdown
:::::::::::::::::::::::::::::::::::::::::: callout

### Good: whitespace either side of the fences

This will ensure Markdown content renders as intended.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::: callout
### Not recommended
Without empty lines flanking the opening and closing fences,
this callout is more difficult to read
and some Markdown content such as lists may not render as intended.
::::::::::::::::::::::::::::::::::::::::::::::::::
```

## Figures

We recommend splitting Markdown image elements across multiple lines,
to enhance readability:

```markdown
![
The text in these square brackets provides a caption to images in 
[the Markdown syntax of The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/example.html#figures).
](path/to/figure.svg){
alt='Alternative text descriptions are defined here'
width='33%'
}
```

![
The text in these square brackets provides a caption to images in 
[the Markdown syntax of The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/example.html#figures).
](https://placekitten.com/300/300){
alt='A random picture of a cute kitten'
width='33%'
}

Source Markdown for figures can be difficult to read when confined to a single line,
especially if the image caption contains its own Markdown elements such as links. 

For comparison, here is the one-line equivalent to the example above:

```markdown
![The text in these square brackets provides a caption to images in [the Markdown syntax of The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/example.html#figures).](path/to/figure.svg){alt='Alternative text descriptions are defined here' width='33%'}
```

## Line Length

We recommend writing one complete sentence per line in source (R) Markdown files.
Although this can result in some long lines, keeping complete sentences in a single line makes it easier to internationalise lessons via machine-assisted translation.

Most text editors can be configured to display long lines "wrapped" to the width of the screen, or to a maximum length specified by the user.
This is sometimes referred to as "word wrap", "soft wrap", or "visual wrap", and can aid readability when working on lessons in your local environment.
Below are links to guidance for activating line wrapping in several popular text editors/integrated development environments:

* [Emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Visual-Line-Mode.html)
* [Notepad++](https://www.technipages.com/how-to-enable-word-wrap-in-notepad/)
* [RStudio](https://support.posit.co/hc/en-us/articles/200549016-Customizing-the-RStudio-IDE#editing)
* [Vim](https://stackoverflow.com/questions/36950231/auto-wrap-lines-in-vim-without-inserting-newlines)
* [VS Code](https://stackoverflow.com/questions/31025502/how-can-i-switch-word-wrap-on-and-off-in-visual-studio-code)

