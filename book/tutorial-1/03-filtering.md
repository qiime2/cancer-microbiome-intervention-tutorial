---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.12
    jupytext_version: 1.9.1
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

```{usage-selector}
```

```{usage-scope}
---
name: tutorial
---
```

# Filtering feature tables

We'll next obtain a much larger feature table representing all of the samples included in the ({cite:t}`liao-data-2021`) dataset. These would take too much time to denoise in this course, so we'll start with the feature table and sequences provided by the authors and filter to samples that we'll use for our analyses. If you'd like to perform other experiments with this feature table, you can do that using the full feature table or a subset that you define by filtering.

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

Finally, download the metadata.

```{usage}
def partial_metadata_factory():
    ## This function is identical to the filter.md metadata_factory function - should
    ## be able to call that once issue#1 is addressed.
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    sample_metadata_url = 'https://data.qiime2.org/2022.2/tutorials/liao/sample-metadata.tsv'
    data = requests.get(sample_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        sample_metadata = pd.read_csv(f.name, index_col='SampleID', sep='\t')
    patient_sample_counts = sample_metadata['PatientID'].value_counts()
    sample_metadata['patient-sample-counts'] = \
        patient_sample_counts[sample_metadata['PatientID']].values


    transplant_metadata_url = 'https://data.qiime2.org/2022.2/tutorials/liao/transplant-metadata.tsv'
    data = requests.get(transplant_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        transplant_metadata = pd.read_csv(f.name, sep='\t')
    # If a patient received multiple HCTs, keep data only on the most recent.
    # This is useful for simplifying downstream workflows.
    transplant_metadata = transplant_metadata.sort_values('TimepointOfTransplant')
    most_recent_transplant_metadata = transplant_metadata.drop_duplicates(subset=['PatientID'], keep='last')
    most_recent_transplant_metadata = most_recent_transplant_metadata.set_index('PatientID')


    autoFmtControlIds = {'C%d' % i for i in range(1,12)}
    autoFmtTreatmentIds = {'T%d' % i for i in range(1,15)}
    new_column = {}
    for ptid, aptid in most_recent_transplant_metadata['autoFmtPatientId'].items():
        if aptid in autoFmtControlIds:
            value = 'control'
        elif aptid in autoFmtTreatmentIds:
            value = 'treatment'
        else:
            value = np.nan
        new_column[ptid] = value
    most_recent_transplant_metadata['autoFmtGroup'] = pd.Series(new_column)

    sample_metadata = sample_metadata.join(most_recent_transplant_metadata, on='PatientID')

    # this selects the patients who were randomized to receive autoFMT or not
    # TODO: it's probably better to do this with QIIME 2 so users can see it - otherwise there's not
    # much point in starting with the full feature table
    #pd_metadata_samples = pd_metadata_samples[pd_metadata_samples['autoFmtGroup'].notna()]

    sample_metadata['categorical-time-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'],
               [-1000, -1, 5, 1000],
               labels=['pre', 'peri', 'post'])

    sample_metadata['week-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'],
               [-1000, -14, -7, 0, 7, 14, 21, 28, 35, 42, 1000],
               labels=[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6])

    sample_metadata = sample_metadata.astype({'categorical-time-relative-to-hct': object,
                                              'week-relative-to-hct': float})

    return qiime2.Metadata(sample_metadata)

def fmt_metadata_factory():
    # obtain the metadata that we've been using so far
    sample_metadata = partial_metadata_factory().to_dataframe()

    # obtain the autoFMT-specific metadata
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    fmt_metadata_url = 'https://data.qiime2.org/2022.2/tutorials/liao/fmt-metadata.tsv'
    data = requests.get(fmt_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        f.flush()
        fmt_metadata = pd.read_csv(f.name, sep='\t')
    fmt_metadata = fmt_metadata.set_index('PatientID')

    # join the two metadata collections, dropping duplicate columns
    sample_metadata = sample_metadata.join(fmt_metadata.drop(['autoFmtPatientId'], axis=1), on='PatientID')

    # drop all samples not related to the autoFMT study
    #sample_metadata = sample_metadata.dropna(subset=['autoFmtGroup'])

    # Create new column relating all samples to day relative to FMT treatment.
    # For patients in the "control" group, this will be the day they were
    # assigned to that group, which is when they would have received the FMT
    # (or one to two days before that) if they had been assigned to the
    # "treatment" group.

    fmt_day = sample_metadata['FMTDayRelativeToNearestHCT'].fillna(
                sample_metadata['RandomizationDayRelativeToNearestHCT'])
    day_relative_to_fmt = sample_metadata['DayRelativeToNearestHCT'] - fmt_day
    sample_metadata.insert(0, 'day-relative-to-fmt', day_relative_to_fmt, True)

    return qiime2.Metadata(sample_metadata)

sample_metadata = use.init_metadata('sample_metadata', fmt_metadata_factory)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ')
)
```

## Generate summaries of full table and sequence data

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

## Filter the feature table to the autoFMT study samples

```{usage}
autofmt_table, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=feature_table, metadata=sample_metadata,
                    where="autoFmtGroup IS NOT NULL"),
    use.UsageOutputNames(filtered_table='autofmt_table')
)

use.action(
    use.UsageAction(plugin_id='feature_table', action_id='summarize'),
    use.UsageInputs(table=autofmt_table, sample_metadata=sample_metadata),
    use.UsageOutputNames(visualization='autofmt_table_summ'),
)
```


## Perform additional filtering steps on feature table

```{usage}
filtered_table_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=autofmt_table, metadata=sample_metadata),
    use.UsageOutputNames(filtered_table='filtered_table_1')
    )
```

```{usage}
filtered_table_2, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_1, metadata=sample_metadata,
                    where="DayRelativeToNearestHCT BETWEEN -10 AND 70"),
    use.UsageOutputNames(filtered_table='filtered_table_2')
)
```

```{usage}
filtered_table_3, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_features'),
    use.UsageInputs(table=filtered_table_2, min_samples=2),
    use.UsageOutputNames(filtered_table='filtered_table_3')
    )
```

## Filter features from sequence data to reduce runtime of feature annotation

```{usage}
filtered_sequences_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_seqs'),
    use.UsageInputs(data=feature_sequences, table=filtered_table_3),
    use.UsageOutputNames(filtered_data='filtered_sequences_1')
    )
```
