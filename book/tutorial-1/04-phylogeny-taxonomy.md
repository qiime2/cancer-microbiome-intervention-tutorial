---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.12
    jupytext_version: 1.9.1
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

```{usage-selector}
```

```{usage-scope}
---
name: tutorial
---
```

# Building a phylogenetic tree and taxonomic annotation

## Taxonomy assignment

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

```{usage}
taxonomy, = use.action(
    use.UsageAction(plugin_id='feature_classifier', action_id='classify_sklearn'),
    use.UsageInputs(classifier=classifier, reads=filtered_sequences_1),
    use.UsageOutputNames(classification='taxonomy'),
)

taxonomy_as_md = use.view_as_metadata('taxonomy_as_md', taxonomy)

use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=taxonomy_as_md),
    use.UsageOutputNames(visualization='taxonomy'),
)
```

## More filtering!

Filter features with uninformative taxonomic annotations (they might be human reads, but note that there are also more specific tools for human read filtering).

```{usage}
filtered_table_4, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='filter_table'),
    use.UsageInputs(table=filtered_table_3, taxonomy=taxonomy, include='p__'),
    use.UsageOutputNames(filtered_table='filtered_table_4')
)

filtered_sequences_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_4),
    use.UsageOutputNames(filtered_data='filtered_sequences_2')
    )
```

## Phylogenetic tree construction

```{usage}
_, _, _, rooted_tree = use.action(
    use.UsageAction(plugin_id='phylogeny', action_id='align_to_tree_mafft_fasttree'),
    use.UsageInputs(sequences=filtered_sequences_2),
    use.UsageOutputNames(alignment='aligned_rep_seqs',
                            masked_alignment='masked_aligned_rep_seqs',
                            tree='unrooted_tree', rooted_tree='rooted_tree'),
)
```
