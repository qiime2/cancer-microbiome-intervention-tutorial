# QIIME 2 Cancer Microbiome Intervention Tutorial

This tutorial was originally developed for the 2022 NIH Foundation for
Advanced Education in the Sciences Microbiome Bioinformatics with QIIME 2
workshop, taught online January 31 - February 4, 2022. It is now being
publicly released with [corresponding video content](https://youtube.com/playlist?list=PLbVDKwGpb3XmvnTrU40zHRT7NZWWVNUpt)
on the [QIIME 2 YouTube channel](https://youtube.com/qiime2).

This tutorial is intended to be read like a book, from beginning to end.

This tutorial and the corresponding videos present many new features of QIIME 2
and our education and documentation ecosystem, including:

* The new QIIME 2 [Galaxy](https://usegalaxy.org/)-based graphical user
  interface;
* New tutorial data;
* Our new QIIME 2 documentation system, which illustrates how to use QIIME 2
  with different user interfaces, including Galaxy, the QIIME 2 command line
  interface, the QIIME 2 Python 3 API, and the R API (via reticulate). You can
  choose to use whichever of these interfaces you're most comfortable with, or
  use different interfaces for different steps;
* Our first [Jupyter Book](https://jupyterbook.org/intro.html)-based QIIME 2
  tutorial.

```{admonition} Important!
Please review the
[QIIME 2 Community Code of Conduct](https://forum.qiime2.org/t/qiime-2-community-code-of-conduct/9057)
. All workshop instructors agreed to abide by these community expectations and
we hope you will too and you become involved in the QIIME 2 community.
```

## Relevant links and protocols

* [Workshop video playlist](https://youtube.com/playlist?list=PLbVDKwGpb3XmvnTrU40zHRT7NZWWVNUpt)
* [Workshop slides](https://bit.ly/3GZaMjt)
* [Project homepage](https://qiime2.org)
* [Support and Discussion Forum](https://forum.qiime2.org) (go here for help)
* [YouTube channel](https://youtube.com/qiime2)
* [User Documentation](https://docs.qiime2.org)
* [Developer Documentation](https://dev.qiime2.org)
* [Library](https://library.qiime2.org)
* [@qiime2 on Twitter](https://twitter.com/qiime2) (project announcements)
* [Workshop announcements](https://workshops.qiime2.org)

## Recommended readings

The following readings will provide background information for this tutorial.
These are presented in priority order.

1. [_Reconstitution of the gut microbiota of antibiotic-treated patients by
    autologous fecal microbiota transplant_](
    https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6468978/)
    ({cite:t}`taur-autofmt-2018`)
1. [_Compilation of longitudinal microbiota data and hospitalome from
    hematopoietic cell transplantation patients_](
    https://www.nature.com/articles/s41597-021-00860-8)
   ({cite:t}`liao-data-2021`)
1. [_Reproducible, interactive, scalable and extensible microbiome data science
    using QIIME 2_](https://doi.org/10.1038/s41587-019-0209-9)
   ({cite:t}`bolyen-qiime2-2019`)
1. [_q2-longitudinal: Longitudinal and Paired-Sample Analyses of Microbiome
    Data_](http://dx.doi.org/10.1128/mSystems.00219-18)
   ({cite:t}`bokulich-q2long-2018`)
1. [Getting started with QIIME 2](https://gregcaporaso.github.io/q2book/using/getting-started.html)
1. [_Experiences and lessons learned from two virtual, hands-on microbiome
    bioinformatics workshops_](
    https://doi.org/10.1371/journal.pcbi.1009056)
   ({cite:t}`dillon-workshops-2021`)

## Thank you to our hosts and our instruction team

We thank our hosts, the [Foundation for Advanced Education in the Sciences
(FAES)](https://faes.org/) for their support of the initial workshop for which
these materials were developed.

We thank the many instructors who were involved in preparing this content,
including the data set and the written and video tutorials.

```{list-table}
:header-rows: 1

* - Name
  - Affiliation(s)
* - Aeriel Belk
  - Joint Institute for Food Safety and Applied Nutrition, United States Food
    and Drug Administration and the University of Maryland, USA
* - Nicholas A. Bokulich
  - Laboratory of Food Systems Biotechnology, Institute of Food, Nutrition,
    and Health, ETH Zürich, Switzerland
* - Evan Bolyen
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Emily Borsom
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - J. Gregory Caporaso
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Colin J. Brislawn
  - Contamination Source Identification / Independent Investigator, USA
* - Kalen Cantrell
  - University of California San Diego, USA
* - Justine Debelius
  - Department of Epidemiology, Johns Hopkins School of Public Health, USA;
    Centre for Translational Microbiome Research, Department of Microbiology,
    Tumor, and Cell Biology, Karolinska Institutet, Sweden
* - Matthew Dillon
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Mehrbod Estaki
  - International Microbiome Centre (IMC), University of Calgary
* - Keegan Evans
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Marcus Fedarko
  - Department of Computer Science and Engineering, University of California
    San Diego, USA
* - Lena Floerl
  - Laboratory of Food Systems Biotechnology, Institute of Food, Nutrition,
    and Health, ETH Zürich, Switzerland
* - Elizabeth Gehret
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Chloe Herman
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Ben Kaehler
  - School of Science, University of New South Wales, Canberra, Australia
* - Chris Keefe
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Lina Kim
  - Laboratory of Food Systems Biotechnology, Institute of Food, Nutrition,
    and Health, ETH Zürich, Switzerland
* - Luca Lenzi
  - Centre for Genomic Research, University of Liverpool, United Kingdom
* - Chen Liao
  - Program for Computational and Systems Biology, Memorial Sloan-Kettering
    Cancer Center, New York, NY, USA
* - Huang Lin
  - Biostatistics and Bioinformatics Branch, Eunice Kennedy Shriver National
    Institute of Child Health and Human Development (NICHD), USA
* - Jeff Meilander
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Michael S. Robeson II, Ph.D.
  - Department of Biomedical Informatics, University of Arkansas for Medical
    Sciences, USA
* - Anthony Simard
  - Center for Applied Microbiome Sciences, Pathogen and Microbiome Institute,
    Northern Arizona University, USA
* - Yoshiki Vazquez-Baeza
  - BiomeSense, USA
```

## Thank you to our funders

The QIIME 2 project is funded in part by:
* The National Cancer Institute:
  * [Informatics Technology for Cancer Research](https://itcr.cancer.gov/)
    (1U24CA248454-01) to JGC
  * [The Partnership for Native American Cancer
     Prevention](https://in.nau.edu/nacp/) (U54CA143925 and U54CA143924) to JGC
* Chan-Zuckerberg Initiative Essential Open Source Software for Science to JGC

[Jupyter Book](https://jupyterbook.org) is funded by the Alfred P. Sloan to JGC
Foundation.

The preparation and dissemination of the data used in this tutorial was funded
in part by the National Institutes of Health (NIH) grants U01 AI124275, R01
AI137269 and U54 CA209975 to Joao B. Xavier.

QIIME 2 was initially developed with support from the National Science
Foundation
([1565100](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1565100)) to JGC.
