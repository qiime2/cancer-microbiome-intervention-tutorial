# Longitudinal microbiome analysis

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

In this section of the tutorial we'll perform several analyses using QIIME 2's
`q2-longitudinal` {cite:p}`bokulich-q2long-2018` plugin. These will allow us
to track microbiome changes across time on a per-subject basis - something
that was harder to do in the ordination plots that we viewed earlier in this
tutorial.

## Preparing our feature table for longitudinal analysis

Before applying these analyses, we're going to perform some additional
operations on the feature table that will make these analyses run quicker and
make the results more interpretable.

First, we're going to use the taxonomic information that we generated earlier
to redefine our features as microbial genera. To do this, we group (or
collapse) ASV features based on their taxonomic assignments through the genus
level. This is achieved using the `q2-taxa` plugin's `collapse` action.

```{usage}
genus_table, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='collapse'),
    use.UsageInputs(table=filtered_table_4, taxonomy=taxonomy, level=6),
    use.UsageOutputNames(collapsed_table='genus_table')
)
```

Then, to focus on the genera that are likely to display the most interesting
patterns over time (and to reduce the runtime of the steps that come next), we
will perform even more filtering. This time we'll apply prevalence and
abudnance based filtering. Specifically, we'll require that a genus's abundance
is at least 1% in at least 10% of the samples.

````{margin}
```{note}
The prevalence-based filtering applied here is fairly stringent. In your
own analyses you may want to experiment with relaxed settings of these
parameters. Because we need the commands below to run quickly, stringent
filtering is helpful for the workshop.
```
````

```{usage}
filtered_genus_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_features_conditionally'),
    use.UsageInputs(table=genus_table, prevalence=0.1, abundance=0.01),
    use.UsageOutputNames(filtered_table='filtered_genus_table')
)
```

Finally, we'll convert the counts in our feature table to relative frequencies.
This is required for some of the analyses that we're about to perform.

```{usage}
genus_rf_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='relative_frequency'),
    use.UsageInputs(table=filtered_genus_table),
    use.UsageOutputNames(relative_frequency_table='genus_rf_table')
)
```

## Volatility plots

The first plots we'll generate are volatility plots. We'll generate these using
two different time variables. First, we'll plot based on
`week-relative-to-hct`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='week-relative-to-hct',
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_1'),
)
```

Next, we'll plot based on `week-relative-to-fmt`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='week-relative-to-fmt',
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_2'),
)
```

## Feature volatility

The last plots we'll generate in this section will come from a QIIME 2 pipeline
called `feature-volatility`. These use supervised regression to identify
features that are most associated with changes over time, and add plotting of
those features to a volatility control chart.

Again, we'll generate the same plots but using two different time variables on
the x-axes. First, we'll plot based on  `week-relative-to-hct`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='feature_volatility'),
    use.UsageInputs(table=filtered_genus_table, metadata=expanded_sample_metadata,
                    state_column='week-relative-to-hct', individual_id_column='PatientID'),
    use.UsageOutputNames(filtered_table='important_genera_table_1',
                         feature_importance='genus_importances_1',
                         volatility_plot='genus_volatility_plot_1',
                         accuracy_results='accuracy_results_1',
                         sample_estimator='sample_estimator_1')
)
```

Next, we'll plot based on `week-relative-to-fmt`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='feature_volatility'),
    use.UsageInputs(table=filtered_genus_table, metadata=expanded_sample_metadata,
                    state_column='week-relative-to-fmt', individual_id_column='PatientID'),
    use.UsageOutputNames(filtered_table='important_genera_table_2',
                         feature_importance='genus_importances_2',
                         volatility_plot='genus_volatility_plot_2',
                         accuracy_results='accuracy_results_2',
                         sample_estimator='sample_estimator_2')
)
```

## Wrapping up: what did you do five days ago?

```{exercise}
:label: q6

We're now getting close to the end of our analysis. Over the course of the
tutorial we've applied multiple filtering steps to our feature table, and if
we were writing this work up for publication it would be essential to
accurately describe the filtering steps that we applied, the order in which we
applied them, and the parameters that were used for each filter.

Without referring back to the earlier sections of the tutorial, but rather
using your memory or information from the results that you've generated,
describe all filtering steps that were applied to the feature table in the
order that we applied them.
```

```{solution} q6
:label: q6-solution
:class: dropdown

This information is contained in the provenance of the artifacts
(`.qza` files) and visualizations (`.qzv` files) that were generated in this
tutorial. To get a comprehensive view of the analyses that we ran, you can load
one of the most recent visualizations that were created (e.g., a volatility or
feature volatility
plot from the last section of the tutorial) with QIIME 2 View, and then click
the Provenance tab in QIIME 2 View to review the steps that led to that
particular visualization.

We ran the following filtering steps in this tutorial:
1. `qiime2 feature-table filter-samples` was applied to remove samples that
were not assigned to an `autoFmtGroup`.
2. `qiime2 feature-table filter-samples` was applied to remove samples that
were collected outside the range of -10 through +70 days, relative to the
nearest HCT event.
3. `qiime2 feature-table filter-features` was applied to remove features that
were present in fewer than two samples.
4. `qiime2 taxa filter-table` was applied to remove features that were not
assigned to a named phylum and sequences with annotations that included the
word `Chloroplast` or `Mitochondria`.
5. `qiime2 feature-table filter-samples` was applied to remove samples that
had a total frequency of fewer than 10,000 sequences.
6. `qiime2 feature-table filter-features-conditionally` was applied to remove
features that were not present in at least 1% abundance in at least 10% of the
samples.

That's a lot of filtering! Thankfully QIIME 2's data provenance tracking
system keeps track of it all for us in case we forget.
```
