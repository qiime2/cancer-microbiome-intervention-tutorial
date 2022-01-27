# Beta diversity visualizations

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

## Generating and exploring ordination plots

umap is an ordination method that can be used in place of PCoA and has been
shown to better resolve differences between microbiome samples in ordination
plots {cite:p}`armstrong-umap-2021`. Like PCoA, umap operates on distance
matrices. We'll compute this on our
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

A useful feature of QIIME 2 is that you can integrate data that is
per-sample as "metadata" in other visualizations. For example, alpha diversity
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
    use.UsageInputs(table=filtered_table_4, taxonomy=taxonomy,
                    metadata=expanded_sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots_2'),
)
```

````{margin}
```{tip}
QIIME 2's [q2-diversity](https://docs.qiime2.org/2021.11/plugins/available/diversity/)
plugin provides visualizations for assessing whether
microbiome composition [differs across groups of independent
samples](https://docs.qiime2.org/2021.11/plugins/available/diversity/beta-group-significance/)
(for example, individuals with a certain disease state and healthy controls)
and for assessing whether [differences in microbiome composition are correlated
with differences in a continuous
variable](https://docs.qiime2.org/2021.11/plugins/available/diversity/beta-correlation/)
(for example, subjects' body mass index). These tools assume that all samples
are independent of one another,
and therefore aren't applicable to the data used in this tutorial where
multiple samples are obtained from the same individual. We therefore don't
illustrate the use of these visualizations on this data, but you can learn
about these approaches and view examples in the [_Moving Pictures_
tutorial](https://docs.qiime2.org/2021.11/tutorials/moving-pictures-usage/).
The Moving Pictures tutorial contains example data and commands, like this
tutorial does, so you can experiment with generating these visualizations on
your own.
```
````

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
