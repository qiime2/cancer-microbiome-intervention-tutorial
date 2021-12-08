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

# Filtering feature tables (currently includes additional content)
 
We'll next obtain a much larger feature table representing all of the samples included in the ({cite:t}`liao-data-2021`) dataset. These would take too much time to denoise in this course, so we'll start with the feature table and sequences provided by the authors and filter to samples that we'll use for our analyses. If you'd like to perform other experiments with this feature table, you can do that using the full feature table or a subset that you define by filtering. 
 
```{usage-selector}
```

## Access the data

First, download the full feature table. 

```{usage}
feature_table_url = 'https://www.dropbox.com/s/6k4lefll507r56x/table.qza?dl=1'

def artifact_from_url(url):
    def factory():
        import tempfile
        import requests
        import qiime2

        data = requests.get(url)

        with tempfile.NamedTemporaryFile() as f:
            f.write(data.content)
            f.flush()
            result = qiime2.Artifact.load(f.name)

        return result
    return factory

feature_table = use.init_artifact(
        'feature-table', 
        artifact_from_url(feature_table_url))
```

Next, download the ASV sequences. 

```{usage}
seqs_url = 'https://www.dropbox.com/s/f8xe9h1b2puo2nn/rep-seqs.qza?dl=1' 

feature_sequences = use.init_artifact(
    'rep-seqs',
    artifact_from_url(seqs_url))
```

Finally, download the metadata. 

```{usage}
def metadata_factory():
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    sample_metadata_url = 'https://www.dropbox.com/s/jouupm7o737pzxs/tblASVsamples.csv?dl=1'
    data = requests.get(sample_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        sample_metadata = pd.read_csv(f.name, index_col='SampleID')    
    patient_sample_counts = sample_metadata['PatientID'].value_counts()
    sample_metadata['patient-sample-counts'] = \
        patient_sample_counts[sample_metadata['PatientID']].values


    transplant_metadata_url = 'https://www.dropbox.com/s/5jicj5mqaqc4ig9/tblhctmeta.csv?dl=1'
    data = requests.get(transplant_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        transplant_metadata = pd.read_csv(f.name)
    # If a patient received multiple HCTs, keep data only on the most recent.
    # This is useful for simplifying downstream workflows. 
    transplant_metadata = transplant_metadata.sort_values('TimepointOfTransplant')
    most_recent_transplant_metadata = transplant_metadata.drop_duplicates(subset=['PatientID'], keep='last')
    most_recent_transplant_metadata = most_recent_transplant_metadata.set_index('PatientID')


    autoFmtControlIds = {'C%d' % i for i in range(1,12)}
    autoFmtTreatmentIds = {'T%d' % i for i in range(1,15)}
    new_column = {}
    for ptid, aptid in most_recent_transplant_metadata['autoFmtPatientId'].items():
        if aptid in autoFmtControlIds:
            value = 'control'
        elif aptid in autoFmtTreatmentIds:
            value = 'treatment'
        else:
            value = np.nan
        new_column[ptid] = value
    most_recent_transplant_metadata['autoFmtGroup'] = pd.Series(new_column)

    sample_metadata = sample_metadata.join(most_recent_transplant_metadata, on='PatientID')

    # this selects the patients who were randomized to receive autoFMT or not
    # TODO: it's probably better to do this with QIIME 2 so users can see it - otherwise there's not 
    # much point in starting with the full feature table
    #pd_metadata_samples = pd_metadata_samples[pd_metadata_samples['autoFmtGroup'].notna()]

    sample_metadata['categorical-time-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'], 
               [-1000, -1, 5, 1000],
               labels=['pre', 'peri', 'post'])
    
    sample_metadata['week-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'], 
               [-1000, -14, -7, 0, 7, 14, 21, 28, 35, 42, 1000], 
               labels=[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6])
    
    sample_metadata = sample_metadata.astype({'categorical-time-relative-to-hct': object,
                                              'week-relative-to-hct': float})

    return qiime2.Metadata(sample_metadata)

sample_metadata = use.init_metadata('sample-metadata', metadata_factory)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ')
)
```

## Generate summaries of full table and sequence data

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=feature_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='table'),
)

use.action(
    use.UsageAction(plugin_id='feature_table', action_id='tabulate_seqs'),
    use.UsageInputs(data=feature_sequences),
    use.UsageOutputNames(visualization='rep_seqs'),
)
```

## Filter the feature table to the autoFMT study samples

```{usage}
autofmt_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=feature_table, metadata=sample_metadata, 
                    where="autoFmtGroup IS NOT NULL"),
    use.UsageOutputNames(filtered_table='autofmt_table')
)

use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```


## Perform additional filtering steps on feature table

```{usage}
filtered_table_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=autofmt_table, metadata=sample_metadata),
    use.UsageOutputNames(filtered_table='filtered_table_1')
    )
```

```{usage}
filtered_table_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_1, metadata=sample_metadata, 
                    where="DayRelativeToNearestHCT BETWEEN -10 AND 70"),
    use.UsageOutputNames(filtered_table='filtered_table_2')
)
```

```{usage}
filtered_table_3, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_features'),
    use.UsageInputs(table=filtered_table_2, min_samples=2),
    use.UsageOutputNames(filtered_table='filtered_table_3')
    )
```

## Filter features from sequence data to reduce runtime of feature annotation

```{usage}
filtered_sequences_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_3),
    use.UsageOutputNames(filtered_data='filtered_sequences_1')
    )
```

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

## Diversity analyses

```{usage}
core_metrics_results = use.action(
    use.UsageAction(plugin_id='diversity', action_id='core_metrics_phylogenetic'),
    use.UsageInputs(phylogeny=rooted_tree, table=filtered_table_4,
                    sampling_depth=10000, metadata=sample_metadata),
    use.UsageOutputNames(rarefied_table='rarefied_table',
                            faith_pd_vector='faith_pd_vector',
                            observed_features_vector='observed_features_vector',
                            shannon_vector='shannon_vector',
                            evenness_vector='evenness_vector',
                            unweighted_unifrac_distance_matrix='unweighted_unifrac_distance_matrix',
                            weighted_unifrac_distance_matrix='weighted_unifrac_distance_matrix',
                            jaccard_distance_matrix='jaccard_distance_matrix',
                            bray_curtis_distance_matrix='bray_curtis_distance_matrix',
                            unweighted_unifrac_pcoa_results='unweighted_unifrac_pcoa_results',
                            weighted_unifrac_pcoa_results='weighted_unifrac_pcoa_results',
                            jaccard_pcoa_results='jaccard_pcoa_results',
                            bray_curtis_pcoa_results='bray_curtis_pcoa_results',
                            unweighted_unifrac_emperor='unweighted_unifrac_emperor',
                            weighted_unifrac_emperor='weighted_unifrac_emperor',
                            jaccard_emperor='jaccard_emperor',
                            bray_curtis_emperor='bray_curtis_emperor'),
)
```

```{usage}
uu_umap, = use.action(
    use.UsageAction(plugin_id='diversity', action_id='umap'),
    use.UsageInputs(distance_matrix=core_metrics_results.unweighted_unifrac_distance_matrix),
    use.UsageOutputNames(umap='uu_umap')
)

wu_umap, = use.action(
    use.UsageAction(plugin_id='diversity', action_id='umap'),
    use.UsageInputs(distance_matrix=core_metrics_results.weighted_unifrac_distance_matrix),
    use.UsageOutputNames(umap='wu_umap')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=uu_umap, metadata=sample_metadata, custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='uu_umap_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=wu_umap, metadata=sample_metadata, custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='wu_umap_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=core_metrics_results.unweighted_unifrac_pcoa_results, 
                    metadata=sample_metadata,
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='uu_pcoa_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=core_metrics_results.weighted_unifrac_pcoa_results, 
                    metadata=sample_metadata,
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='wu_pcoa_emperor_w_time')
)
```

## Taxonomy barplots and differential abundance testing
```{usage}
filtered_table_for_da, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_4, min_frequency=10000),
    use.UsageOutputNames(filtered_table='filtered_table_for_da')
    )
```

```{usage}
use.action(
    use.UsageAction(plugin_id='taxa', action_id='barplot'),
    use.UsageInputs(table=filtered_table_4, taxonomy=taxonomy,
                    metadata=sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots'),
)
```

## Longitudinal analysis

TODO: Add evenness, faith PD, umap vectors, pcoa vectors to metadata for use with volability plots. 

```{usage}
genus_table, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='collapse'),
    use.UsageInputs(table=filtered_table_4, taxonomy=taxonomy, level=6),
    use.UsageOutputNames(collapsed_table='genus_table')
)

filtered_genus_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_features_conditionally'),
    use.UsageInputs(table=genus_table, prevalence=0.1, abundance=0.01),
    use.UsageOutputNames(filtered_table='filtered_genus_table')
)

genus_rf_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='relative_frequency'),
    use.UsageInputs(table=filtered_genus_table),
    use.UsageOutputNames(relative_frequency_table='genus_rf_table')
)
```

### Volatility

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='week-relative-to-hct',
                    metadata=sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_by_week'),
)
```

### Feature volatility

```{usage}
_, _, genus_volatility_plot, _, _ = use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='feature_volatility'),
    use.UsageInputs(table=filtered_genus_table, metadata=sample_metadata, 
                    state_column='week-relative-to-hct', individual_id_column='PatientID'),
    use.UsageOutputNames(filtered_table='important_genera_table', 
                         feature_importance='genus_importances',
                         volatility_plot='genus_volatility_plot',
                         accuracy_results='accuracy_results',
                         sample_estimator='sample_estimator')
)
```
