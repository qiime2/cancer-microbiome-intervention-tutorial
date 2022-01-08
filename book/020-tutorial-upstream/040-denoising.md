# Denoising sequence data with DADA2

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

Twenty-fifth percentile quality score drops below 30 at position 204 in the
forward reads and 205 in the reverse reads.
Since first base of the reverse reads is slightly lower than those that follow,
we'll trim that first base. This is probably unnecessary,
but is useful here for illustrating how this works.

```{usage}
asv_sequences_0, feature_table_0, dada2_stats = use.action(
    use.UsageAction(plugin_id='dada2', action_id='denoise_paired'),
    use.UsageInputs(demultiplexed_seqs=demultiplexed_sequences,
                    trim_left_f=0, trunc_len_f=204,
                    trim_left_r=1, trunc_len_r=205,),
    use.UsageOutputNames(representative_sequences='asv_sequences_0',
                        table='feature_table_0',
                        denoising_stats='dada2_stats')
)
```

```{usage}
stats_as_md = use.view_as_metadata('stats_dada2_md', dada2_stats)

use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=stats_as_md),
    use.UsageOutputNames(visualization='dada2_stats_summ')
)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=feature_table_0, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='feature_table_0_summ'),
)

use.action(
    use.UsageAction(plugin_id='feature_table', action_id='tabulate_seqs'),
    use.UsageInputs(data=asv_sequences_0),
    use.UsageOutputNames(visualization='asv_sequences_0_summ'),
)
```
