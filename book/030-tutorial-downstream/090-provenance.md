# Provenance in QIIME 2

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
---
default-interface: cli-usage
---
```

## Wrapping up: what did you do five days ago?

```{exercise}
:label: q6

We're now getting close to the end of our analysis. Over the course of the
tutorial we've applied multiple filtering steps to our feature table, and if
we were writing this work up for publication it would be essential to
accurately describe the filtering steps that we applied, the order in which we
applied them, and the parameters that were used for each filter.

Without referring back to the earlier sections of the tutorial, but rather
using your memory or information from the results that you've generated,
describe all filtering steps that were applied to the feature table in the
order that we applied them.
```

```{solution} q6
:label: q6-solution
:class: dropdown

This information is contained in the provenance of the artifacts
(`.qza` files) and visualizations (`.qzv` files) that were generated in this
tutorial. To get a comprehensive view of the analyses that we ran, you can load
one of the most recent visualizations that were created (e.g., a volatility or
feature volatility
plot from the last section of the tutorial) with QIIME 2 View, and then click
the Provenance tab in QIIME 2 View to review the steps that led to that
particular visualization.

We ran the following filtering steps in this tutorial:
1. `qiime2 feature-table filter-samples` was applied to remove samples that
were not assigned to an `autoFmtGroup`.
2. `qiime2 feature-table filter-samples` was applied to remove samples that
were collected outside the range of -10 through +70 days, relative to the
nearest HCT event.
3. `qiime2 feature-table filter-features` was applied to remove features that
were present in fewer than two samples.
4. `qiime2 taxa filter-table` was applied to remove features that were not
assigned to a named phylum and sequences with annotations that included the
word `Chloroplast` or `Mitochondria`.
5. `qiime2 feature-table filter-samples` was applied to remove samples that
had a total frequency of fewer than 10,000 sequences.
6. `qiime2 feature-table filter-features-conditionally` was applied to remove
features that were not present in at least 1% abundance in at least 10% of the
samples.

That's a lot of filtering! Thankfully QIIME 2's data provenance tracking
system keeps track of it all for us in case we forget.
```
