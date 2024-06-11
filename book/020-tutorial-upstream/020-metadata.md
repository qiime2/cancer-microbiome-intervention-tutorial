# Exploring the tutorial metadata

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

## Access the study metadata

In this chapter we'll begin our work with QIIME 2 and the tutorial data. We'll
start by downloading the metadata, generating a summary of it, and exploring
that summary.

First, download the metadata.

```{usage}
def partial_metadata_factory():
    ## This function is identical to the filter.md metadata_factory function - should
    ## be able to call that once issue#1 is addressed.
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    sample_metadata_url = 'https://data.qiime2.org/2024.5/tutorials/liao/sample-metadata.tsv'
    data = requests.get(sample_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        sample_metadata = pd.read_csv(f.name, index_col='SampleID', sep='\t')
    patient_sample_counts = sample_metadata['PatientID'].value_counts()
    sample_metadata['patient-sample-counts'] = \
        patient_sample_counts[sample_metadata['PatientID']].values


    transplant_metadata_url = 'https://data.qiime2.org/2024.5/tutorials/liao/transplant-metadata.tsv'
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

    sample_metadata['categorical-time-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'],
               [-1000, -1, 5, 1000],
               labels=['pre', 'peri', 'post'])

    sample_metadata['week-relative-to-hct'] = \
        pd.cut(sample_metadata['DayRelativeToNearestHCT'],
               [-1000, -14, -7, 0, 7, 14, 21, 28, 35, 42, 1000],
               labels=[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6])

    sample_metadata = sample_metadata.astype(
            {'categorical-time-relative-to-hct': object,
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

    fmt_metadata_url = 'https://data.qiime2.org/2024.5/tutorials/liao/fmt-metadata.tsv'
    data = requests.get(fmt_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        f.flush()
        fmt_metadata = pd.read_csv(f.name, sep='\t')
    fmt_metadata = fmt_metadata.set_index('PatientID')

    # join the two metadata collections, dropping duplicate columns
    sample_metadata = sample_metadata.join(fmt_metadata.drop(['autoFmtPatientId'], axis=1), on='PatientID')

    # Create new column relating all samples to day relative to FMT treatment.
    # For patients in the "control" group, this will be the day they were
    # assigned to that group, which is when they would have received the FMT
    # (or one to two days before that) if they had been assigned to the
    # "treatment" group.
    fmt_day = sample_metadata['FMTDayRelativeToNearestHCT'].fillna(
                sample_metadata['RandomizationDayRelativeToNearestHCT'])
    day_relative_to_fmt = sample_metadata['DayRelativeToNearestHCT'] - fmt_day
    sample_metadata.insert(0, 'day-relative-to-fmt', day_relative_to_fmt, True)

    sample_metadata['week-relative-to-fmt'] = \
        pd.cut(sample_metadata['day-relative-to-fmt'],
               [-1000, -14, -7, 0, 7, 14, 21, 28, 35, 42, 1000],
               labels=[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6])

    sample_metadata['categorical-time-relative-to-fmt'] = \
        pd.cut(sample_metadata['day-relative-to-fmt'],
               [-1000, -1, 5, 1000],
               labels=['pre', 'peri', 'post'])

    sample_metadata = sample_metadata.astype(
            {'categorical-time-relative-to-fmt': object,
             'week-relative-to-fmt': float})

    return qiime2.Metadata(sample_metadata)

sample_metadata = use.init_metadata('sample_metadata', fmt_metadata_factory)
```

## View the metadata

Next, we'll get a view of the study metadata as QIIME 2 sees it. This
will allow you to assess whether the metadata that QIIME 2 is using is as you
expect. You can do this using the `tabulate` action in QIIME 2's `q2-metadata`
plugin as follows.

```{usage}
use.action(
    use.UsageAction(plugin_id='metadata', action_id='tabulate'),
    use.UsageInputs(input=sample_metadata),
    use.UsageOutputNames(visualization='metadata_summ_1')
)
```

Spend a few minutes now exploring the Galaxy environment on your own, and
exploring the metadata that we'll use in this tutorial. If you have questions
about how to use Galaxy or QIIME 2 View, this is a great time to ask those
questions.
