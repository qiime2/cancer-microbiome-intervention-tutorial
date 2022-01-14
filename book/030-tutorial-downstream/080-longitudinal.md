# Longitudinal microbiome analysis

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

In this section of the tutorial we'll perform several analyses using QIIME 2's
q2-longitudinal plugin. These will allow us to track microbiome changes
across time on a per-subject basis - something that was harder to do in the
ordination plots that we viewed earlier in this tutorial.

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
patterns over time, we will perform even more filtering. This time we'll
apply prevalence and abudnance based filtering. Specifically, we'll require
that a genera's overall abundance is at least 1%, and that a genera is present
in at least 10% of the samples. This is fairly stringent filtering, and in your
own analyses (when you have more time to allow analyses to run and to explore
the results) you may want to experiment with relaxed settings of these
parameters.

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

The first plots we'll generate are control charts that are referred to as
called volatility plots. We'll generate these using two different time
variables. First, we'll plot based on  `week-relative-to-hct`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='week-relative-to-hct',
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_1'),
)
```

Next, we'll plot based on `day-relative-to-fmt`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='day-relative-to-fmt',
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_2'),
)
```

## Feature volatility

The next plots we'll generate result will come from a QIIME 2 pipeline called
`feature-volatility`. These use supervised regression to identify features
that are most associated with changes over time, and add plotting of those
features to a volatility control chart.

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

Next, we'll plot based on `day-relative-to-fmt`.

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='feature_volatility'),
    use.UsageInputs(table=filtered_genus_table, metadata=expanded_sample_metadata,
                    state_column='day-relative-to-fmt', individual_id_column='PatientID'),
    use.UsageOutputNames(filtered_table='important_genera_table_2',
                         feature_importance='genus_importances_2',
                         volatility_plot='genus_volatility_plot_2',
                         accuracy_results='accuracy_results_2',
                         sample_estimator='sample_estimator_2')
)
```
