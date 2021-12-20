# Plugins and actions

(getting-started:plugins)=
## Plugins and actions

People generally think of QIIME 2 as a microbiome bioinformatics system, but the truth is that it's a lot more general purpose than that. QIIME 2 is built using a plugin architecture. There is a core system, which we call the _QIIME 2 Framework_ or just _The Framework_. This handles a lot of the behind-the-scenes work, like tracking data provenance and building `.qza` and `.qzv` files. There is no microbiome-specific functionality (or even bioinformatics-specific functionality) in the QIIME 2 Framework. All of the analysis functionality comes in the form of plugins to the framework. There's only a few things that you need to know about this right now. First, your deployment of QIIME 2 will have some collection of plugins installed. Plugins define actions, which are steps in an analysis workflow. For example, the `q2-diversity` QIIME 2 plugin defines actions including `alpha-phylogenetic` and `beta-phylogenetic` which can apply phylogenetic alpha and beta diversity metrics, respectively, to your data. If you don't have the `q2-diversity` plugin installed, you won't have access to those actions. To find out what QIIME 2 plugins you currently have installed, you can run the following command:

```{code-cell}
qiime --help
```

If you want to see what actions are defined by a plugin, you can call `--help` on that plugin. For example, to see what actions are available from the `q2-diversity` plugin, you can run the following command:

```{code-cell}
qiime diversity --help
```

You should see `alpha-phylogenetic` and `beta-phylogenetic` in that list, among other actions. You could go one step further if you'd like to learn about how to use those actions by calling help on the action. For example:

```{code-cell}
qiime diversity alpha-phylogenetic --help
```

The output that you get from that might look a little mysterious right now. When you finish Part 1 of this book, you'll understand how to read that help text and use it learn how to use QIIME 2 actions you've never used before. 

Another thing to know about plugins is that anyone can create and distribute them. For example, if a graduate student develops some new analysis functionality that they want to use with QIIME 2, that can create their own QIIME 2 plugin. If they want others to be able to use it, they can distribute that plugin. The [QIIME 2 Library](https://library.qiime2.org) is a website developed by the QIIME 2 team to help with dissemination of plugins. It's a great site to visit if you want to discover new analysis functionality. Developing and disseminating plugins is covered in Part 3 of this book.

QIIME 2 actions come in three varieties, as of this writing. Methods are a type of QIIME 2 action that generate one or more `.qza` files as output. Since `.qza` files are intermediary results in QIIME 2 (as discussed in the previous section), Methods typically represent some sort of processing step in your analysis, such as taxonomic annotation of sequences. The `alpha-phylogenetic` and `beta-phylogenetic` actions described above are Methods. Visualizers are a type of QIIME 2 action that generate one or more `.qzv` files as output. You'll remember that `.qzv` files are terminal results in QIIME 2, so these are steps that terminal in a workflow. An example of a QIIME 2 visualizer is the `beta-group-significance` action in the `q2-diversity` plugin, which runs PERMANOVA, ANOSIM, or PERMDISP on your data, and reports the result of the statistical test. The third type of action in QIIME 2 is a Pipeline, which can generate one or more `.qza` and/or `.qzv` as output. `Pipelines` are special in that they're a type of action that can call other actions. They are often used by developers to define simplify common workflows so they can be run by users in a single step. For example, the `core-metrics-phylogenetic` action in the `q2-diversity` plugin is a Pipeline that runs both `alpha-phylogenetic` and `beta-phylogenetic`, as well as several other actions, in a single command. In total it runs about 20 different actions, so it saves a lot of typing to be able to do achieve that with a single command.     

There's more to know about plugins and actions in QIIME 2, but this will get you started. 
