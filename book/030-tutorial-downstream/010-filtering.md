# Filtering feature tables

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

We'll next obtain a much larger feature table representing all of the samples
included in the ({cite}`liao-data-2021`) dataset. These would take too much
time to denoise in this course, so we'll start with the feature table,
sequences, and metadata provided by the authors and filter to samples that
we'll use for our analyses. If you'd like to perform other experiments with
this feature table, you can do that using the full feature table or a subset
that you define by filtering.

## Access the data

First, download the full feature table.

```{usage}
feature_table_url = 'https://data.qiime2.org/2022.2/tutorials/liao/full-feature-table.qza'

def artifact_from_url(url):
    def factory():
        import tempfile
        import requests
        import qiime2

        data = requests.get(url)

        with tempfile.NamedTemporaryFile() as f:
            f.write(data.content)
            f.flush()
            result = qiime2.Artifact.load(f.name)

        return result
    return factory

feature_table = use.init_artifact(
        'feature-table',
        artifact_from_url(feature_table_url))
```

Next, download the ASV sequences.

```{usage}
seqs_url = 'https://data.qiime2.org/2022.2/tutorials/liao/rep-seqs.qza'

feature_sequences = use.init_artifact(
    'rep-seqs',
    artifact_from_url(seqs_url))
```

## View the metadata

We'll again take a quick look at the study metadata as QIIME 2 sees it to
refresh ourselves. Either review the summary that you previously generated, or
generate another one.

````{admonition} Expand this box for help generating a metadata summary.
:class: dropdown

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ')
)
```
````


## Generate summaries of full table and sequence data

Next, it's useful to generate summaries of the feature table and sequence data.
We did this after running DADA2 previously, but since we're now working with a
new feature table and new sequence data, we should look at a summary of this
table as well.

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=feature_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='table'),
)

use.action(
    use.UsageAction(plugin_id='feature_table', action_id='tabulate_seqs'),
    use.UsageInputs(data=feature_sequences),
    use.UsageOutputNames(visualization='rep_seqs'),
)
```

```{admonition} Which column or columns in the metadata could be used to
:class: question, dropdown
identify samples that were included in the autoFMT study?

Several columns contain this information, such as autoFmtGroup which contains
the value "treatment" if the subject was in the treatment group, "control" if
the subject was in the control group, and no value if the patient was not
enrolled in this particular study.
```

## Filter the feature table to the autoFMT study samples

In this tutorial, we're going to work specifically with samples that were
included in the autoFMT randomized trial. We'll now begin a series of filtering
steps applied to both the feature table and the sequences to select only
features and samples that are relevant to that study.

First, we'll remove samples that are not part of the autoFMT study from the
feature table. We identify these samples using the metadata: specifically,
samples that do not contain a value in the autoFmtGroup column in the metadata
are filtered with this step.

```{usage}
autofmt_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=feature_table, metadata=sample_metadata,
                    where="autoFmtGroup IS NOT NULL"),
    use.UsageOutputNames(filtered_table='autofmt_table')
)
```

We can now summarize the feature table again to observe how it changed as a
result of this filtering.

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```

```{admonition} How many samples and features are in this feature table after
filtering? How does that compare to the feature table prior to filtering?
:class: question, dropdown
**TODO**: Fill this in!
```

## Perform additional filtering steps on feature table

Before we proceed with the analysis, we'll apply a few more filtering steps.

First, we're going to focus in on a specific window of timely - mainly the
period of ten days prior to the patients cell transplant through seventy days
following the transplant. Some of the subjects in this study have very long
term microbiota data, but since many don't it helps to just focus our analysis
on the temporal range that is most relevant to this analysis.

```{usage}
filtered_table_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=autofmt_table, metadata=sample_metadata,
                    where="DayRelativeToNearestHCT BETWEEN -10 AND 70"),
    use.UsageOutputNames(filtered_table='filtered_table_1')
)
```

Finally, we'll filter features from the feature table if they don't occur in at
least two samples. This filter is used here primarily to reduce the runtime of
some of the downstream steps for the purpose of this tutorial. This filter
isn't necessary to run in your own analyses.


```{usage}
filtered_table_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_features'),
    use.UsageInputs(table=filtered_table_1, min_samples=2),
    use.UsageOutputNames(filtered_table='filtered_table_2')
    )
```

We can then generate and review another feature table summary.

```{usage}
use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=filtered_table_2, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='filtered_table_2_summ'),
)
```

```{admonition} How many samples and features are in the feature table after
this latest filtering? How does that compare to the prior feature tables?
:class: question, dropdown

**TODO**: Fill this in!
```

## Filter features from sequence data to reduce runtime of feature annotation

At this point, we have filtered features from our feature table, but those
features are still present in our sequence data. In the next section we'll be
performing some computationally expensive operations on these sequences, so to
make those go quicker we'll next filter all features that are no longer in our
feature table from our collection of feature sequences.

```{usage}
filtered_sequences_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_2),
    use.UsageOutputNames(filtered_data='filtered_sequences_1')
    )
```
