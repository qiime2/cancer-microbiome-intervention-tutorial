```{usage-scope}
---
name: tutorial
---
```

# Core metrics

```{usage-selector}
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
```

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

```{usage}
use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=uu_umap, metadata=expanded_sample_metadata, custom_axes=['week-relative-to-hct']),
    use.UsageOutputNames(visualization='uu_umap_emperor_w_time')
)

use.action(
    use.UsageAction(plugin_id='emperor', action_id='plot'),
    use.UsageInputs(pcoa=wu_umap, metadata=expanded_sample_metadata, custom_axes=['week-relative-to-hct']),
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
