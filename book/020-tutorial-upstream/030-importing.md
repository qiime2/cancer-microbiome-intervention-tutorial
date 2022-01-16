# Importing demultiplexed sequence data

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

In this section of the tutorial, we'll import raw fastq data that is already
demultiplexed (i.e., separated into per-sample fastq files) into a QIIME 2
artifact.

## Importing

We'll begin with the data import.

```{usage}
def casava_directory_factory():
    import tempfile
    import requests
    import shutil

    import qiime2
    from q2_types.per_sample_sequences import \
        CasavaOneEightSingleLanePerSampleDirFmt

    sequence_data_url = 'https://data.qiime2.org/2022.2/tutorials/liao/fastq-casava.zip'
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

## Generating and viewing a summary of the imported data

After your import is complete, you can generate a summary of the imported
artifact. This summary contains several important pieces of information.

First, it tells you how many sequences were obtained for each of the samples.
The  expected number of sequences per sample will vary depending on the
sequencing technology that was applied and the the number of samples that were
multiplexed in your run. You should review this, and ensure that you are
getting the expected number of sequences on average.

Second, this summary provides interactive figures that illustrate sequence
quality. This will give you an overview of the quality of your sequencing run,
and you'll need to extract information from these plots to perform quality
control on the data in the next step of the tutorial.

```{usage}
use.action(
    use.UsageAction(plugin_id='demux', action_id='summarize'),
    use.UsageInputs(data=demultiplexed_sequences),
    use.UsageOutputNames(visualization='demultiplexed_sequences_summ'),
)
```
