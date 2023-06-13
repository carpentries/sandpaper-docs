---
title: 'Style Guide'
---

A collection of guidelines to follow when writing
source (R) Markdown files for use with {sandpaper}.

## Fenced Divs

### Fence length

For increased legibility, we recommend an opening fence length of at least 20 colons
(approximately one third of the screen), 
with a single space between the last colon and the class keyword.
The length of closing fences should match the length of the opening fence plus keyword,
for example:

```markdown
:::::::::::::::::::: callout

### An example callout

This callout was opened with a fence of twenty colons.
The end of the closing fence aligns with
the last character in the 'callout' keyword.

::::::::::::::::::::::::::::
```

Where fenced divs are nested,
e.g. attaching a solution block to a challenge,
we recommend making the inner fences at least ten colons longer
than the outer fences.
E.g.

```markdown
:::::::::::::::::::: challenge

### An example challenge

This challenge was opened with a fence of 20 colons.

:::::::::::::::::::::::::::::::::: solution

The nested solution block was opened with 35 colons,
to make it stand out from the challenge.

:::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::
```

### Whitespace

For legibility and to avoid potentail formatting issues,
empty lines should flank the fences of a fenced div, e.g.

```markdown
:::::::::::::::::::: callout

### Good: whitespace either side of the fences

This will ensure Markdown content renders as intended.

::::::::::::::::::::::::::::

:::::::::::::::::::: callout
### Not recommended
Without empty lines flanking the opening and closing fences,
this callout is more difficult to read
and some Markdown content such as lists
may not render as intended.
::::::::::::::::::::::::::::
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

Source Markdown for figures can be difficult to read when confined to a single line,
especially if the image caption contains its own Markdown elements such as links. 

For comparison, here is the one-line equivalent to the example above:

```markdown
![The text in these square brackets provides a caption to images in [the Markdown syntax of The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/example.html#figures).](path/to/figure.svg){alt='Alternative text descriptions are defined here' width='33%'}
```

## Line Length

We recommend the use of [_Semantic Line Breaks_][sembr]
with a maximum line length of 100 characters.
As detailed in the Semantic Line Breaks specification,

> A line MAY exceed the maximum line length if necessary, such as to accommodate hyperlinks, code elements, or other markup.

[sembr]: https://sembr.org/
