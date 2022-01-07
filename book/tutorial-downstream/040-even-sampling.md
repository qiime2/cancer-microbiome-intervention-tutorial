# Identifying an even sampling depth for use in diversity metrics

As we begin performing more analyses of the samples in our faeture table, an
important parameter that needs to be define is the even sampling (i.e.
rarefaction) depth that diversity metrics need to be computed at. Because most
diversity metrics are sensitive to different sampling depths across different
samples, it is common to randomly subsample the counts from each sample to a
specific value. For example, if you define your sampling depth as 500 sequences
per sample, the counts in each sample will be subsampled without replacement so
that each sample in the resulting table has a total count of 500. If the total
count for any sample(s) are smaller than this value, those samples will be
dropped from the downstream analyses. Choosing this value is tricky. We
recommend making your choice by reviewing the information presented in the
feature table summary file. Choose a value that is as high as possible (so you
retain more sequences per sample) while excluding as few samples as possible.

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

## Generate a feature table summary

First, let's create and view a summary of the most recent feature table that
was created.

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=filtered_table_5, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='filtered_table_5_summ'),
)
```

## Alpha rarefaction plots

After choosing an even sampling depth, it's also helpful to see if your
diversity metrics appear to have stabilizes at that depth of coverage. You can
do this for alpha diversity using an alpha rarefaction plot.

```{usage}
use.action(
    use.UsageAction(plugin_id='diversity', action_id='alpha_rarefaction'),
    use.UsageInputs(table=filtered_table_5, metrics={'shannon'},
                    metadata=sample_metadata, max_depth=33000),
    use.UsageOutputNames(visualization='shannon_rarefaction_plot'))
```

## Beta rarefaction plots

Similarly, you can evaluate whether your beta diversity metrics appear stable
at the depth you have selected.

```{usage}
use.action(
    use.UsageAction(plugin_id='diversity', action_id='beta_rarefaction'),
    use.UsageInputs(table=filtered_table_5, metric='braycurtis',
                    clustering_method='nj', sampling_depth=10000,
                    metadata=sample_metadata),
    use.UsageOutputNames(visualization='braycurtis_rarefaction_plot'))
```

**TODO**: Should we plug q2-srs? has anyone used this yet?