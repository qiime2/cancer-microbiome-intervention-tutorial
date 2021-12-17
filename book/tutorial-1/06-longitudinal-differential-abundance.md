# Longitudinal microbiome analysis and differential abundance testing

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

## Taxonomy barplots and differential abundance testing

Filter the feature table to only the IDs that were retained for core metrics
analysis. This can be achieved using the combined metadata.

```{usage}
filtered_table_5, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_4, metadata=expanded_sample_metadata),
    use.UsageOutputNames(filtered_table='filtered_table_5')
    )
```

```{usage}
use.action(
    use.UsageAction(plugin_id='taxa', action_id='barplot'),
    use.UsageInputs(table=filtered_table_5, taxonomy=taxonomy,
                    metadata=expanded_sample_metadata),
    use.UsageOutputNames(visualization='taxa_bar_plots'),
)
```

## Longitudinal analysis


```{usage}
genus_table, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='collapse'),
    use.UsageInputs(table=filtered_table_5, taxonomy=taxonomy, level=6),
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
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_1'),
)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='longitudinal', action_id='volatility'),
    use.UsageInputs(table=genus_rf_table, state_column='day-relative-to-fmt',
                    metadata=expanded_sample_metadata, individual_id_column='PatientID',
                    default_group_column='autoFmtGroup'),
    use.UsageOutputNames(visualization='volatility_plot_2'),
)
```

### Feature volatility

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
