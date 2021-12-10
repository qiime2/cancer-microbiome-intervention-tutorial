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

# Other approaches for exploring the impact of FMT on the microbiome

```{usage-selector}
```

```{usage}
def partial_metadata_factory():
    ## This function is identical to the filter.md metadata_factory function - should
    ## be able to call that once issue#1 is addressed. 
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    sample_metadata_url = 'https://www.dropbox.com/s/jouupm7o737pzxs/tblASVsamples.csv?dl=1'
    data = requests.get(sample_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        sample_metadata = pd.read_csv(f.name, index_col='SampleID')    
    patient_sample_counts = sample_metadata['PatientID'].value_counts()
    sample_metadata['patient-sample-counts'] = \
        patient_sample_counts[sample_metadata['PatientID']].values


    transplant_metadata_url = 'https://www.dropbox.com/s/5jicj5mqaqc4ig9/tblhctmeta.csv?dl=1'
    data = requests.get(transplant_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        transplant_metadata = pd.read_csv(f.name)
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
    
    fmt_metadata_url = 'https://www.dropbox.com/s/lc67zkze7i3eljp/tblautofmt.csv?dl=1'
    data = requests.get(fmt_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        f.flush()
        fmt_metadata = pd.read_csv(f.name)
    fmt_metadata = fmt_metadata.set_index('PatientID')

    # join the two metadata collections, dropping duplicate columns
    sample_metadata = sample_metadata.join(fmt_metadata.drop(['autoFmtPatientId'], axis=1), on='PatientID')

    # drop all samples not related to the autoFMT study
    sample_metadata = sample_metadata.dropna(subset=['autoFmtGroup'])

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