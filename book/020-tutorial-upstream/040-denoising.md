# Denoising sequence data with DADA2

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

## Performing sequence quality control (i.e., denoising)

Next, we'll perform quality control or denoising of the sequence data with
DADA2 {cite:t}`callahan-dada2-2016`, which is accessible through the q2-dada2
plugin.
Since our reads are paired end, we'll use the `denoise_paired` action in the
q2-dada2 plugin. This performs quality filtering, chimera checking, and paired-
end read joining.

The `denoise_paired` action requires a few parameters that you'll set based
on the sequence quality score plots that you previously generated in the
summary of the demultiplex reads. You should review those plots and identify
where the quality begins to decrease, and use that information to set the
`trunc_len_*` parameters. You'll set that for both the forward and reverse
reads using the `trunc_len_f` and `trunc_len_r` parameters, respectively. If
you notice a region of lower quality in the beginning of the forward and/or
reverse reads, you can optionally trim bases from the beginning of the reads
using the `trim_left_f` and `trim_left_r` parameters for the forward and
reverse reads, respectively.

Spend a couple of minutes reviewing the quality score plots and think about
where you might want to truncate the forward and reverse reads, and if you'd
like to trim any bases from the beginnings.

````{margin}
```{admonition} Greg's guidance on choosing these values

I typically try to apply some objective criteria when selecting these values.
For example, in reviewing the quality score plots, I noticed that the
twenty-fifth percentile quality score drops below 30 at position 204 in the
forward reads and 205 in the reverse reads. I chose to use those values for
the required truncation lengths.

Since the first base of the reverse reads is
slightly lower than those that follow, I choose to trim that first base in the
reverse reads, but apply no trimming to the forward reads. This trimming is
probably unnecessary here, but is useful here for illustrating how this works.
```
````

```{usage}
asv_sequences_0, feature_table_0, dada2_stats = use.action(
    use.UsageAction(plugin_id='dada2', action_id='denoise_paired'),
    use.UsageInputs(demultiplexed_seqs=demultiplexed_sequences,
                    trunc_len_f=204,
                    trim_left_r=1, trunc_len_r=205,),
    use.UsageOutputNames(representative_sequences='asv_sequences_0',
                        table='feature_table_0',
                        denoising_stats='dada2_stats')
)
```

## Reviewing the DADA2 run statistics

The first output of DADA2 that we'll look at is the run statistics. You can
generate a viewable summary using the following command. This file will tell
you how many reads were filtered from each sample and why.

```{usage}
stats_as_md = use.view_as_metadata('stats_dada2_md', dada2_stats)

use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=stats_as_md),
    use.UsageOutputNames(visualization='dada2_stats_summ')
)
```

## Generating and reviewing summaries of the feature table and feature data

The next two outputs of DADA2 will form the basis of the majority of the
microbiome analyses that you'll run, in connection with your sample metadata.
This is the feature table and feature data. The feature table describes which
amplicon sequence variants (ASVs) were observed in which samples, and how many
times each ASV was observed in each sample. The feature data in this case is
the sequence that defines each ASV. Generate and explore the summaries of
each of these files.

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

```{note}
We've now reached the end of the **upstream** tutorial. When we begin working
on the **downstream** tutorial, we'll work with larger feature table and
feature data artifacts representing many more samples. The samples that we
worked with in this tutorial are a small subset of what we'll work with in the
**downstream** tutorial.
```
