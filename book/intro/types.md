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
  display_name: calysto_bash
  language: calysto_bash
  name: calysto_bash
---

# Semantic types

(getting-started:types)=
## Semantic types, data types, and file formats 

The next topic that should be briefly covered before you start using QIIME 2 is the notion of types in QIIME 2. The term _type_ is 
overloaded with a few different concepts, so I'll start by talking about two ways that it's commonly used, and then introduce a third way that it's used less frequently but which is important to QIIME 2 (and which could help other systems, in my opinion). By disambiguating this concept now I think we'll avoid confusion later, and you'll be in a better place to understand QIIME 2 help text and other documentation. 

````{margin}
```{admonition} Video
[This video](https://www.youtube.com/watch?v=PUsvtJgpNtE) on the QIIME 2 YouTube channel discusses semantic types.
```
````

The three kinds of types that are used in QIIME 2 are **file types (more frequently referred to file formats in QIIME 2)**, **data types**, and **semantic types**. File types (or formats) refer to what you probably think of when you hear that phrase: the format of a file used to store some data. For example, newick is a file type that is used for storing phylogenetic trees. Files are used most commonly for archiving data when it's not actively in use. Data types refer to how data is represented in a computer's memory (i.e., RAM) while it's actively in use. For example, if you are adding a root to an unrooted phylogenetic tree (a concept discussed in Part 2 of this book), you may use a tool like IQTree2. You would provide a path to the file containing the unrooted phylogenetic tree to IQTree2, and IQTree2 would load that tree into some _data structure_ in the computer's memory to work on it. The data structure or type, that IQTree2 uses internally to represent the phylogenetic tree will be a decision made by the developers of IQTree2. If it successfully completes the requested rooting operation, IQTree2 would write the new tree from an internal data type into a new newick-formatted file on the hard disk, and exit. As a software user, you shouldn't need to know or care about what data types are used internally by a program - you just care about what file types are used as input and output. Computer programmers care a lot about internal data types: choosing an appropriate one has huge impacts on the software. 

The third _type_ that is important in QIIME 2 is the semantic type of data. This is a representation of the _meaning_ of the data, which is not necessarily represented by either a file type or a data type. For example, two semantic types used in QIIME 2 are `Phylogeny[Rooted]` and `Phylogeny[Unrooted]`, which are used to represent rooted and unrooted trees, respectively. Both rooted and unrooted trees are commonly stored in newick files, and a computer program needs to parse (i.e., load data from a file into a in-memory data structure) to know if a tree is rooted or unrooted. For large trees, this can be a slow operation. There are some operations, such as rooting a tree, that only make sense to perform on unrooted trees. So, if you have a very large tree that you want to root, you may provide a newick file to a program that will perform that rooting. If you accidentally provide a rooted tree (say because you have tried rooting it with a few different approaches that you want to evaluate), it may take the program some time to parse the file (say 20 minutes) after which it may fail if it discovers that the tree is already rooted. That sort of delayed notification can be very frustrating as a user, since it's easily missed until a lot of time has passed. I often will start a long-running command on my university cluster computer just before the weekend. I'll typically check on the job for a few minutes, to make sure that it seems to be starting ok. I may then leave, in the hope that the job completes over the weekend and I'll have data to work with on Monday morning. It's very frustrating to come in Monday morning and find out that my job failed just a few minutes after I left on Friday for a reason that I could have quickly addressed had I known in time. 

```{warning}
There's actually a worse outcome than a delayed error from a computer program when inappropriate input is provided. When a program fails and provides an error message to the user, whether or not that error message helps the user solve the problem, the program has failed loudly. Something went wrong, and it told the user about it. The program could instead fail quietly. This might happen if the program doesn't realize the input the user provided is in appropriate (e.g., an already rooted tree is provided to a program that roots an unrooted phylogenetic tree), and it runs the rooted tree through its algorithm, misinterprets something because it was provided with the wrong input, and generates an incorrect rooted tree as a result. Quiet failures can be very difficult or impossible for a user to detect, because it looks like everything has worked as expected. Failing quietly is thus _much_ worse than failing loudly - it could waste many hours of your time, and could even lead to you publishing invalid findings.
```

QIIME 2 semantic types help with this, because they provide information on what the data in a QIIME 2 `.qza` file means without having to parse anything in the `data` directory. All QIIME 2 artifacts have a semantic type associated with them (it's one of the pieces of information stored in the `metadata.yaml` file), and QIIME 2 methods will describe what semantic types they take as input(s), and what semantic types they generate as output(s). For example, the `q2-phylogeny` plugin defines a method called `midpoint_root`. Call help on this method using the following command:

```{code-cell}
qiime phylogeny midpoint-root --help
```

You can see from the resulting help text that this method takes one input, an artifact of semantic type `Phylogeny[Unrooted]`. It also generates one output, an artifact of semantic type `Phylogeny[Rooted]`. This makes intuitive sense: an action that adds a root to a phylogenetic tree (as described in the help text for this method) takes an unrooted tree as input and generates a rooted tree as output. 

There is a many-to-many relationship between file types, data types, and semantic types. It's possible that a given semantic type could be represented on disk by different file types. That's well exemplified by the many different formats that are used to store demultiplexed sequence and sequence quality data. For example, this may be in one a few variants of the fastq format, or in the fasta/qual format. Additionally, data from multiple samples may be contained in one single file or split into per-sample files. Regardless of which of these file formats the data is stored in, QIIME 2 will assign the same semantic type (in this case, `SampleData[SequencesWithQuality]`. Similarly, the data type used in memory might differ depending on what operations are to be performed on the data, or based on the preference of the programmer. QIIME 2 use the semantic type `FeatureTable[Frequency]` to represent the idea of a feature table that contains counts of features (e.g., bacterial genera) on a per sample basis. Many different actions can be applied to `FeatureTable[Frequency]` artifacts in QIIME 2. When a plugin developer defines a new action that takes a `FeatureTable[Frequency]` as input, they can choose whether to load the table into a `pandas.DataFrame` or `biom.Table` object, which are two different data types.

```{note}
That last paragraph was a bit technical. Don't worry if you got lost in the details - just take away the idea that there is not a one-to-one relationship between file types, data types, and semantic types in QIIME 2. Each kind of type represents different information about the data.     

The motivation for creating QIIME 2's semantic type system was to avoid issues that can arise from providing inappropriate data to actions. The semantic type system also helps users and developers better understand the intent of QIIME 2 actions by assigning meaning to the input and output, and allows for the discovery of new potentially relevant QIIME 2 actions (more on this later). Throughout the next few chapters I'll point out semantic types of some inputs and outputs as we come across them. Again, there's more to know on this topic, but that learning can be deferred until its needed.      
```
