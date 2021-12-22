# Building a phylogenetic tree and taxonomic annotation

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

In this chapter we'll perform annotation of the features that were observed in
this study by performing taxonomic classification of the sequences. This allows
us to assess what organisms are represented by the ASV sequences that we
observed in this study.

## Taxonomy assignment

We'll start with taxonomic classification. In this step we'll use a pre-trained
Naive Bayes taxonomic classifier. This particular classifier was trained on the
Greengenes 13-8 database, where sequences were trimmed to represent only the 
region between the 515F / 806R primers. 

You can download pre-trained classifiers from the QIIME 2 documentation 
[Data Resources](https://docs.qiime2.org/2021.11/data-resources/) page. 

```{tip}
If you don't find a relevant classifier for your analysis, or you prefer to use 
a  reference database that we currently do not provide taxonomy classifiers 
for, it's also straight-forward to train your own taxonomy classifiers. This is 
covered in the QIIME 2 documentation 
[here](https://docs.qiime2.org/2021.11/tutorials/feature-classifier/).

The [RESCRIPt QIIME 2 plugin](https://journals.plos.org/ploscompbiol/article/authors?id=10.1371/journal.pcbi.1009581)
provides functionality that can help you create your own taxonomy reference 
resources.
```

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

## More filtering

Taxonomic annotations provide useful information that can also be used in 
quality filtering of our data. A common step in 16S analysis is to remove 
sequences from an analysis that aren't assigned to a phylum. In a human 
microbiome study such as this, these may for example represent reads of human
genome sequence that were unintentionally sequences. 

````{margin}
```{note}
If you need to filter human genome reads from your sequence data, for example 
before depositing sequences into a public repository, you should use a filter
that specifically detects and removes human reads. This can be acheived in QIIME 2 using
the [`q2-quality-control` plugin's `exclude-seqs` action](https://docs.qiime2.org/2021.11/plugins/available/quality-control/exclude-seqs/). 
```
````

This filtering can be applied as follows by providing the feature table and the
taxonomic annotations that were just created. The `include` parameter here 
specifies that an annotation must contain the text `p__`, which in the 
Greengenes taxonomy is the prefix for all phylum-level taxonomy assignments. 
Taxonomic labels that don't contain `p__` therefore don't have an assigned 
phylum. 

```{usage}
filtered_table_4, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='filter_table'),
    use.UsageInputs(table=filtered_table_3, taxonomy=taxonomy, include='p__'),
    use.UsageOutputNames(filtered_table='filtered_table_4')
)
```

You may have noticed when looking at feature table summaries earlier that some
of the samples contained very few ASV sequences. These often represent samples
which didn't amplify or sequence well, and when we start visualizing our data
low numbers of sequences can cause misleading results, because the the 
observed composition of the sample may not be reflective of the sample's 
actual composition. For this reason it can be helpful to exclude samples with
low ASV sequence counts from our samples. Here, we'll filter out samples from
which we have obtained fewer than 10,000 sequences. 

**TODO** discuss the 10k threshold. 

```{usage}
filtered_table_5, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_4, min_frequency=10000),
    use.UsageOutputNames(filtered_table='filtered_table_5')
    )
```

After filtering ASVs that were not assigned a phylum, and filtering samples 
with low ASV sequence counts, we can remove ASV sequences that are no longer
represented in our table from the collection of ASV sequences by filtering to
only the features that are contained in the feature table. This step isn't
required, but can help to speed up some downstream steps.

```{usage}
filtered_sequences_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_5),
    use.UsageOutputNames(filtered_data='filtered_sequences_2')
    )
```

````{admonition} Try summarizing the feature table that was created by this round of filtering. Expand this box if you need help. 
:class: question, dropdown

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=filtered_table_5, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='filtered_table_5_summ'),
)
```
````

## Generate taxonomic composition barplots

We'll now get one of our first views of our microbiome sample compositions
using a taxonomic barplot. This can be generated with the following command.

```{usage}
use.action(
    use.UsageAction(plugin_id='taxa', action_id='barplot'),
    use.UsageInputs(table=filtered_table_5, taxonomy=taxonomy,
                    metadata=sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots_1'),
)
```

**TODO** plug the q2-krona plugin
