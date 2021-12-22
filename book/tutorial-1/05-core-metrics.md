# Core metrics

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

## Diversity analyses

The next step that we'll work through is computing a series of common diversity
metrics on our feature table. We'll do this using the `q2-diversity` plugin's 
`core-metrics-phylogenetic` action. This action is another QIIME 2 pipeline, 
this time combining over ten different actions into a single action. 

`core-metrics-phylogenetic` requires your feature table, your rooted
phylogenetic tree, and your sample metadata as input. It additionally requires
that you provide the sampling depth that this analysis will be performed at. 
Determining what value to provide for this parameter is often one of the most
confusing steps of an analysis for users, and we therefore will devote 
considerable time to discussing this in the lectures. In the interest of 
retaining as many of the samples as possible, we'll set our sampling depth to
10,000 for this analysis. 

```{usage}
core_metrics_results = use.action(
    use.UsageAction(plugin_id='diversity', action_id='core_metrics_phylogenetic'),
    use.UsageInputs(phylogeny=rooted_tree, table=filtered_table_5,
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

As you can see, this command generates many outputs including both QIIME 2 
artifacts and visualizations. Most of the outputs are data that we'll 
subsequently explore, but you can take a look at the visualizations that are 
generated now. These are PCoA plots generated for four diversity metrics: 
Jaccard, Bray-Curtis, unweighted UniFrac, and weighted UniFrac. Take a quick 
look, but we're next going to apply a few steps to make these plots more 
useful. 

umap is an ordination method that can be used in place of PCoA and has been 
shown to better resolve differences between microbiome samples in ordination 
plots. Like PCoA, umap operates on distance matrices. We'll compute this on our
weighted and unweighted UniFrac distance matrices. For the moment, there won't
be anything to visualize as a result of these steps: we'll come back to 
visualization of these results shortly. 

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
```

A useful feature of QIIME 2 is that you can integrate data that is computed per
sample as "metadata" in other visualizations. For example, alpha diversity 
values such as Faith's Phylogenetic Diversity, are computed on a per-sample 
basis and thus can be viewed or used as QIIME 2 sample metadata. Since beta 
diversity metrics such as UniFrac are computed on pairs of samples, they're not
as useful to view or use as metadata. However ordination values computed from 
distance matrices, for example a sample's PCoA or umap axis 1 and axis 2 
values, are computed per sample and so can be viewed or used as metadata. 

In the next few steps, we'll integrate our unweighted UniFrac umap axis 1 
values, and our Faith PD, evenness, and Shannon diversity values, as metadata
in visualizations. This will provide a few different ways of interpreting 
these values. 

```{usage}
uu_umap_as_metadata = use.view_as_metadata('uu_umap_as_metadata', uu_umap)
faith_pd_as_metadata = use.view_as_metadata('faith_pd_as_metadata', core_metrics_results.faith_pd_vector)
evenness_as_metadata = use.view_as_metadata('evenness_as_metadata', core_metrics_results.evenness_vector)
shannon_as_metadata = use.view_as_metadata('shannon_as_metadata', core_metrics_results.shannon_vector)


expanded_sample_metadata = use.merge_metadata('expanded_sample_metadata',
                                              sample_metadata,
                                              uu_umap_as_metadata,
                                              faith_pd_as_metadata,
                                              evenness_as_metadata,
                                              shannon_as_metadata)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=expanded_sample_metadata),
    use.UsageOutputNames(visualization='expanded_metadata_summ')
)
```

To see how this information can be used, let's generate another version of our
taxonomy barplots that includes these new metadata values.

```{usage}
use.action(
    use.UsageAction(plugin_id='taxa', action_id='barplot'),
    use.UsageInputs(table=filtered_table_5, taxonomy=taxonomy,
                    metadata=expanded_sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots_2'),
)
```

We'll start by integrating these values as metadata in our ordination plots. 
We'll also customize these plots in another way: in addition to plotting the 
ordination axes, we'll add an explicit time axis to these plots. This is often
useful for visualization patterns in ordination plots in time series studies. 
We'll add an axis for `week-relative-to-hct`. 

```{usage}
use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=uu_umap, metadata=expanded_sample_metadata, 
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='uu_umap_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=wu_umap, metadata=expanded_sample_metadata,
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='wu_umap_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=core_metrics_results.unweighted_unifrac_pcoa_results,
                    metadata=expanded_sample_metadata,
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='uu_pcoa_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=core_metrics_results.weighted_unifrac_pcoa_results,
                    metadata=expanded_sample_metadata,
                    custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='wu_pcoa_emperor_w_time')
)
```

You have now generated ordination plots all combinations of two different 
diversity metrics (weighted and unweighted UniFrac) and two different 
ordination techniques (PCoA and umap). View these plots and consider what is 
similar and different about each. 
