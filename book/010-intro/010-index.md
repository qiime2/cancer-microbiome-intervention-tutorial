# Getting started with using QIIME 2

If you're new to QIIME 2, you may find it helpful to read [q2book](https://gregcaporaso.github.io/q2book/front-matter/preface.html)
, another QIIME 2 JupyterBook which introduces concepts of the QIIME 2
bioinformatics platform. This will help you understand why QIIME works the way
it does, discussing concepts including QIIME 2 archives (i.e., `.qza` and
`.qzv` files), semantic types, plugins, and importing.

It's not essential to have a complete grasp of all of the ideas in this
section to use QIIME 2. But the more of this that you know, the more QIIME 2
will make sense to you, and the more benefit you'll get out of learning and
using the system.

Please pose any questions you have, on the tutorials that follow in this book,
or on the ideas presented in q2book, on the QIIME 2 Forum

## QIIME 2 View

````{margin}
```{admonition} Video
[This video](https://t.co/eJbm03cnSa) on the QIIME 2 YouTube channel
illustrates how to use QIIME 2 View.
```
````

QIIME 2 View is a web-based viewer for `.qza` and `.qzv` files. If you've never
visited QIIME 2 View, take a minute to [go to the
site](https://view.qiime2.org) now. This site allows for you to view QIIME 2
results on computers that don't have QIIME 2 installed on them, and there are a
few examples that you can look at in the gallery on that page. I use QIIME 2
View daily, for a few different situations. First, if I'm running analyses on a
cluster computer than doesn't provide a graphical interface, it's a convenient
way to view those results without having to load QIIME 2 on another computer. If
I have a copy of a `.qza` or `.qzv` file on my local computer (e.g., if I copied
it over from the cluster) I can navigate to QIIME 2 View, and drag-and-drop the
file on the QIIME 2 View page to look at it. Another scenario where this is
helpful is if when I'm sharing interactive QIIME 2 results with someone who
doesn't have QIIME 2 installed, for example a collaborator. I can send them
`.qzv` files by email (or use the Dropbox sharing option on QIIME 2 View), and
they can load and interact with the results on their computer.

```{note}
When you're using QIIME 2 View, your data isn't uploaded to a server. Rather
the site acts as an application launcher that allows you to view local files.
This means that you don't need to be concerned about data privacy issues with
QIIME 2 View - the data never leaves your computer.
```
