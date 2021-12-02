# Filtering feature tables

We'll next obtain a much larger feature table representing all of the samples including in the ({cite:t}`liao-hct-2021`) dataset. These would take too much time to denoise in this course, so we'll start with the feature table and sequences provided by the authors and filter to samples that we'll use for our analyses. If you'd like to perform other experiments with this feature table, you can do that using the full feature table or a subset that you define by filtering. 

```{usage-selector}
```

## Access the data

First, download the full feature table. 

```{usage}
def ft_factory():
    import tempfile
    import requests
    from qiime2 import Artifact

    url = 'https://www.dropbox.com/s/6k4lefll507r56x/table.qza?dl=1'

    data = requests.get(url)

    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        result = Artifact.load(f.name)

    return result

ft = use.init_artifact('feature-table', ft_factory)
```

Next, download the ASV sequences. 

```{usage}
def seqs_factory():
    import tempfile
    import requests
    from qiime2 import Artifact

    url = 'https://www.dropbox.com/s/f8xe9h1b2puo2nn/rep-seqs.qza?dl=1'

    data = requests.get(url)

    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        result = Artifact.load(f.name)
    
    return result

seqs = use.init_artifact('rep-seqs', seqs_factory)
```

Finally, download the metadata. 

```{usage}
def metadata_factory():
    import tempfile
    import requests
    import pandas as pd
    import numpy as np

    import qiime2

    sample_metadata_url = 'https://www.dropbox.com/s/jouupm7o737pzxs/tblASVsamples.csv?dl=1'
    data = requests.get(sample_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        pd_metadata_samples = pd.read_csv(f.name, index_col='SampleID')

    transplant_metadata_url = 'https://www.dropbox.com/s/5jicj5mqaqc4ig9/tblhctmeta.csv?dl=1'
    data = requests.get(transplant_metadata_url)
    with tempfile.NamedTemporaryFile() as f:
        f.write(data.content)
        pd_metadata_transplant = pd.read_csv(f.name, index_col='PatientID')

    patient_sample_counts = pd_metadata_samples['PatientID'].value_counts()
    pd_metadata_samples['patient-sample-counts'] = \
        patient_sample_counts[pd_metadata_samples['PatientID']].values

    
    autoFmtControlIds = {'C%d' % i for i in range(1,12)}
    autoFmtTreatmentIds = {'T%d' % i for i in range(1,15)}
    new_column = {}
    for ptid, aptid in pd_metadata_transplant['autoFmtPatientId'].items():
        if aptid in autoFmtControlIds:
            value = 'control'
        elif aptid in autoFmtTreatmentIds:
            value = 'treatment'
        else:
            value = np.nan
        new_column[ptid] = value
    pd_metadata_transplant['autoFmtGroup'] = pd.Series(new_column)

    pd_metadata_samples = pd_metadata_samples.join(pd_metadata_transplant, on='PatientID')

    # this selects the patients who were randomized to receive autoFMT or not
    # TODO: it's probably better to do this with QIIME 2 so users can see it - otherwise there's not 
    # much point in starting with the full feature table
    pd_metadata_samples = pd_metadata_samples[pd_metadata_samples['autoFmtGroup'].notna()]

    pd_metadata_samples['categorical-time-relative-to-hct'] = \
        pd.cut(pd_metadata_samples['DayRelativeToNearestHCT'], 
               [-1000, -1, 5, 1000],
               labels=['pre', 'peri', 'post'])
    
    pd_metadata_samples['week-relative-to-hct'] = \
        pd.cut(pd_metadata_samples['DayRelativeToNearestHCT'], 
               [-1000, -14, -7, 0, 7, 14, 21, 28, 35, 42, 1000], 
               labels=[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6])
    
    pd_metadata_samples = pd_metadata_samples.astype({'categorical-time-relative-to-hct': object,
                                                      'week-relative-to-hct': int})
    return qiime2.Metadata(pd_metadata_samples)

sample_metadata = use.init_metadata('sample-metadata', metadata_factory)
```


## Perform initial filtering steps on feature table

```{usage}
filtered_table_1, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=ft, metadata=sample_metadata),
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

TODO: Generate the taxonomy before this step so we can use it for filtering here! 

```
# I'm not a real usage example yet
filtered_table, = use.action(
    use.UsageAction(plugin_id='taxa', action_id='filter_table'),
    use.UsageInputs(table=filtered_table, taxonomy=taxonomy, include='p__'),
    use.UsageOutputNames(filtered_table='filtered_table')
)
```

```{usage}
filtered_table_4, = use.action(
    use.UsageAction(plugin_id='feature_table', action_id='filter_samples'),
    use.UsageInputs(table=filtered_table_3, min_frequency=10000),
    use.UsageOutputNames(filtered_table='filtered_table_4')
    )
```

