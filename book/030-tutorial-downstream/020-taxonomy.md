# Taxonomic annotation of observed sequences

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
---
default-interface: galaxy-usage
---
```

In this chapter we'll perform annotation of the features that were observed in
this study by performing taxonomic classification of the sequences. This allows
us to assess what organisms are represented by the ASV sequences that we
observed in this study.

## Taxonomy assignment

````{margin}
```{tip}
If you don't find a relevant classifier for your analysis, or you prefer to use
a  reference database that we currently do not provide taxonomy classifiers
for, it's also straightforward to train your own taxonomy classifiers. This is
covered in the QIIME 2 documentation
[here](https://docs.qiime2.org/2021.11/tutorials/feature-classifier/).

The [RESCRIPt QIIME 2 plugin](https://journals.plos.org/ploscompbiol/article/authors?id=10.1371/journal.pcbi.1009581)
{cite:p}`robeson-rescript-2021` provides functionality that can help you create
your own taxonomy reference resources.
```
````

````{margin}
```{tip}
Environment-aware taxonomy classifiers can help you obtain higher resolution
taxonomic assignments (for example, species-level where only genus-level
assignments were previously obtainable). To learn more, see the [q2-clawback
QIIME 2 plugin](https://library.qiime2.org/plugins/q2-clawback/7/)
{cite:p}`kaehler-clawback-2019`.
```
````

We'll start with taxonomic classification. In this step we'll use a pre-trained
Naive Bayes taxonomic classifier. This particular classifier was trained on the
Greengenes 13-8 database, where sequences were trimmed to represent only the
region between the 515F / 806R primers.

You can download pre-trained classifiers from the QIIME 2 documentation
[Data Resources](https://docs.qiime2.org/2021.11/data-resources/) page.

First, obtain the taxonomic classifier.

```{usage}
def classifier_factory():
    from urllib import request
    from qiime2 import Artifact
    fp, _ = request.urlretrieve(
        'https://data.qiime2.org/2021.11/common/gg-13-8-99-515-806-nb-classifier.qza',
    )

    return Artifact.load(fp)

classifier = use.init_artifact('gg-13-8-99-515-806-nb-classifier', classifier_factory)
```

Next, use that classifier to assign taxonomic information to the ASV sequences.

```{usage}
taxonomy, = use.action(
    use.UsageAction(plugin_id='feature_classifier', action_id='classify_sklearn'),
    use.UsageInputs(classifier=classifier, reads=filtered_sequences_1),
    use.UsageOutputNames(classification='taxonomy'),
)
```

Finally, generate a human-readable summary of the taxonomic annotations.

```{usage}
taxonomy_as_md = use.view_as_metadata('taxonomy_as_md', taxonomy)

use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=taxonomy_as_md),
    use.UsageOutputNames(visualization='taxonomy'),
)
```

## Filtering filters based on their taxonomy

Taxonomic annotations provide useful information that can also be used in
quality filtering of our data. A common step in 16S analysis is to remove
sequences from an analysis that aren't assigned to a phylum. In a human
microbiome study such as this, these may for example represent reads of human
genome sequence that were unintentionally sequences.

````{margin}
```{note}
If you need to filter human genome reads from your sequence data, for example
before depositing sequences into a public repository, you should use a filter
that specifically detects and removes human reads. This can be acheived in
QIIME 2 using the [`q2-quality-control` plugin's `exclude-seqs`
action](https://docs.qiime2.org/2021.11/plugins/available/quality-control/exclude-seqs/).
```
````

````{margin}
```{tip}
Depending on the reference taxonomy that you're using, it may be useful to
apply filters excluding other labels. For example, filtering `Eukaryota` is a
good idea if you're sequencing 16S data and annotating your sequences with
the Silva database (since eukaryotes contain the 18S rather than 16S variant
of the small subunit rRNA, you shouldn't expect to observe them in a 16S
survey). It can also be useful to filter uninformative taxonomic assignments,
such as `Unassigned` and `Unclassified`.
```
````

This filtering can be applied as follows by providing the feature table and the
taxonomic annotations that were just created. The `include` parameter here
specifies that an annotation must contain the text `p__`, which in the
Greengenes taxonomy is the prefix for all phylum-level taxonomy assignments.
Taxonomic labels that don't contain `p__` therefore were maximally assigned to
the domain (i.e., kingdom) level. This will also remove features that are
annotated with `p__;` (which means that no named phylum was assigned to the
feature), as well as annotations containing `Chloroplast` or `Mitochondria`
(i.e., organelle 16S sequences).

```{usage}
filtered_table_3, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='filter_table'),
    use.UsageInputs(table=filtered_table_2, taxonomy=taxonomy, mode='contains',
                    include='p__', exclude='p__;,Chloroplast,Mitochondria'),
    use.UsageOutputNames(filtered_table='filtered_table_3')
)
```

## Filtering samples with low sequence counts

````{margin}
```{note}
The threshold of 10,000 sequences applied here is not strongly evidence based.
Rather it's applied based on reviewing summaries of the feature tables that
have been generated to this point, and selecting a value that retains most of
the samples. We'll explore this threshold in more detail, including assessing
whether 10,000 sequences leads to stable summaries of the microbiome samples
used in this tutorial, later in the workshop.
```
````

You may have noticed when looking at feature table summaries earlier that some
of the samples contained very few ASV sequences. These often represent samples
which didn't amplify or sequence well, and when we start visualizing our data
low numbers of sequences can cause misleading results, because the
observed composition of the sample may not be reflective of the sample's
actual composition. For this reason it can be helpful to exclude samples with
low ASV sequence counts from our samples. Here, we'll filter out samples from
which we have obtained fewer than 10,000 sequences.

```{usage}
filtered_table_4, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_3, min_frequency=10000),
    use.UsageOutputNames(filtered_table='filtered_table_4')
    )
```

````{margin}
```{tip}
You can often find helpful tips for your analyses on the QIIME 2 Forum. For
example, [this forum post](https://forum.qiime2.org/t/phylogenetic-tree-effect-on-downstream-analysis/19127)
contains example commands for performing these filtering steps. Be sure to
make use of the (free!) [QIIME 2 Forum](https://forum.qiime2.org) - there are
loads of valuable information there that can help you improve your analysis.
```
````

After filtering ASVs that were not assigned a phylum, and filtering samples
with low ASV sequence counts, we can remove ASV sequences that are no longer
represented in our table from the collection of ASV sequences by filtering to
only the features that are contained in the feature table. This step isn't
required, but can help to speed up some downstream steps.

```{usage}
filtered_sequences_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_4),
    use.UsageOutputNames(filtered_data='filtered_sequences_2')
    )
```

```{exercise}
:label: q4

Try summarizing the feature table that was created by this round of filtering.
Expand this box if you need help.
```

````{solution} q4
:label: q4-solution
:class: dropdown

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=filtered_table_4, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='filtered_table_4_summ_exercise'),
)
```
````

## Generate taxonomic composition barplots

````{margin}
```{tip}
A third party plugin, [available on the QIIME 2
Library](https://library.qiime2.org/plugins/q2-krona/39/), allows users to
generated multi-taxonomic-level krona plots using QIIME 2. These are very
useful for generating interactive microbiome composition summaries on a per-
sample basis.
```
````

We'll now get one of our first views of our microbiome sample compositions
using a taxonomic barplot. This can be generated with the following command.

```{usage}
use.action(
    use.UsageAction(plugin_id='taxa', action_id='barplot'),
    use.UsageInputs(table=filtered_table_4, taxonomy=taxonomy,
                    metadata=sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots_1'),
)
```
