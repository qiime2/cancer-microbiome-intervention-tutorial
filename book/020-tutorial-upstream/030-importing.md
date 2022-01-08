# Importing demultiplexed sequence data

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

```{usage}
def casava_directory_factory():
    import tempfile
    import requests
    import shutil

    import qiime2
    from q2_types.per_sample_sequences import \
        CasavaOneEightSingleLanePerSampleDirFmt

    sequence_data_url = 'https://www.dropbox.com/s/wgygdy91hv76vba/fastq-casava.zip?dl=1'
    data = requests.get(sequence_data_url)
    with tempfile.NamedTemporaryFile(mode='w+b') as f:
        f.write(data.content)
        f.flush()

        dir_fmt = CasavaOneEightSingleLanePerSampleDirFmt()
        shutil.unpack_archive(f.name, str(dir_fmt), 'zip')

    return dir_fmt

data_to_import = use.init_format('data_to_import', casava_directory_factory)
```

```{usage}
from q2_types.per_sample_sequences import \
    CasavaOneEightSingleLanePerSampleDirFmt

demultiplexed_sequences = use.import_from_format(
    'demultiplexed_sequences',
    semantic_type='SampleData[PairedEndSequencesWithQuality]',
    variable=data_to_import,
    view_type=CasavaOneEightSingleLanePerSampleDirFmt)
```

```{usage}
use.action(
    use.UsageAction(plugin_id='demux', action_id='summarize'),
    use.UsageInputs(data=demultiplexed_sequences),
    use.UsageOutputNames(visualization='demultiplexed_sequences_summ'),
)
```











