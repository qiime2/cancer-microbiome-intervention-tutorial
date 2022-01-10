# Hematopoietic cell transplantation data

This tutorial focuses on data reused from [Liao et al (2021) _Compilation of
longitudinal microbiota data and hospitalome from hematopoietic cell
transplantation patients_](https://www.nature.com/articles/s41597-021-00860-8)
({cite:t}`liao-data-2021`).

We thank the study participants for the contribution of their valuable samples
while undergoing cancer treatment, and we thank {cite:t}`liao-data-2021` for
their considerable efforts to make this data set accessible to the cancer
microbiome research community.

Any work that uses this data should cite {cite:t}`liao-data-2021`
**and** the original studies (which are all cited in
{cite:t}`liao-data-2021`). Our analyses will primarily focus on the samples
collected for [_Reconstitution of the gut microbiota of antibiotic-treated
patients by autologous fecal microbiota
transplant_](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6468978/)
({cite:t}`taur-autofmt-2018`).

## Structure of the workshop tutorials

The tutorial used in this workshop is split into two parts. First, the
*upstream* tutorial covers steps up to the generation of the feature table,
which tallys the frequency of amplicon sequence variants (ASV) on a per-sample
basis, and feature data which lists the sequence that defines each ASV in the
feature table.

Second, the *downstream* tutorial begins with a feature table and feature data
and constitutes the analysis and interpretation of that information. We'll
spend the majority of the week on the *downstream* tutorial.

The two parts of this tutorial are both dervived from the same data set
{cite:t}`liao-data-2021`. The *upstream* tutorial uses a relatively small
number of samples (n=41) and is designed to allow us to work through the most
computationally expensive steps of the analysis quickly, so you can get
experience running these steps during the workshop. By working with fewer
samples, these steps can be run in just a few minutes.

The *downstream* tutorial uses the complete feature table and feature data
published in FigShare by {cite:t}`liao-data-2021`. Since that data set
contains many more samples (n=12,546) and over 550,000,000 sequences, it
wouldn't be possible to run the
*upstream* steps on this data interactively during the workshop. We will show
how to load that data in QIIME 2, and do some filtering of the full data to
focus our work on specific samples of interest. In our case, we'll work with
the {cite:t}`taur-autofmt-2018` samples. However, the full dataset will be
available for you to filter in other ways, and to experiment with during or
after this workshop. As the authors note: _These microbiota data, combined
with the curated clinical metadata presented here, can serve as powerful
hypothesis generators for microbiome studies._

```{admonition} Jargon: feature table, feature data
:class: jargon
If terms like *feature table* and *feature data* aren't clear
right now, don't worry! They will be clear by the end of the week.
```