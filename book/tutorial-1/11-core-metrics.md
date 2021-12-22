# Computing diversity metrics

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

The next step that we'll work through is computing a series of common diversity
metrics on our feature table. We'll do this using the `q2-diversity` plugin's 
`core-metrics-phylogenetic` action. This action is another QIIME 2 pipeline, 
this time combining over ten different actions into a single action. 

## Core phylogenetic diversity metrics

`core-metrics-phylogenetic` requires your feature table, your rooted
phylogenetic tree, and your sample metadata as input. It additionally requires
that you provide the sampling depth that this analysis will be performed at. 
Determining what value to provide for this parameter is often one of the most
confusing steps of an analysis for users, and we therefore have devoted 
time to discussing this in the lectures and in the previous chapter. In the 
interest of retaining as many of the samples as possible, we'll set our
sampling depth to 10,000 for this analysis. 

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
useful soon. 
