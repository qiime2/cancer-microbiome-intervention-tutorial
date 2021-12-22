# Phylogenetic tree construction

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
```

In this chapter we'll continue our efforts to annotate the features we observed
in this study, this time by building a phylogenetic tree from the seqeunces.
This will provide information that we'll use later to approximately quantify
the evolutionary relationships between the feature sequences that we observed.

## Aligning sequences and building a phylogenetic tree

We'll build a phylogenetic tree from our ASV sequences
using the `q2-phylogeny` plugin's `align_to_tree_mafft_fasttree`
action. This action is a pipeline in QIIME 2, which means that it strings
together multiple simpler operations that are often performed together to 
reduce the number of steps that users have to take. Pipelines are used in the 
same way as other actions.

This particular pipeline performs four distinct steps steps:
    1. perform a multiple sequence alignment using mafft;
    2. filter highly variable positions from the alignment (these positions tend to introduce noise into the phylogenetic tree);
    3. build an unrooted phylogenetic tree;
    4. add a root to the unrooted tree. 

The final unrooted phylogenetic tree will be used for analyses that we perform
next - specifically for computing phylogenetically aware diversity metrics. 
While output artifacts will be available for each of these steps, we'll only 
use the rooted phylogenetic tree later. 

```{usage}
_, _, _, rooted_tree = use.action(
    use.UsageAction(plugin_id='phylogeny', action_id='align_to_tree_mafft_fasttree'),
    use.UsageInputs(sequences=filtered_sequences_2),
    use.UsageOutputNames(alignment='aligned_rep_seqs',
                         masked_alignment='masked_aligned_rep_seqs',
                         tree='unrooted_tree', rooted_tree='rooted_tree'),
)
```

**TODO**: add visualization with empress? I haven't used this a lot, but I'd 
love input from the instructor interested in this section on what would be 
cool to do here. 