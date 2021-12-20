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

# Deploying QIIME 2

## Deploying QIIME 2

The first thing you may be wondering as you prepare to learn QIIME 2 is where and how you'll deploy it. QIIME 2 can be deployed on your personal computer (e.g., your laptop or desktop computer), a cluster computer such as one owned and maintained by your university, or on cloud computing resources such as the Amazon Web Services (AWS) Elastic Compute Cloud (EC2). In the following sections I describe these options for deploying QIIME 2, and I conclude with linking you to specific instructions on how to install QIIME 2. I recommend having a working deployment of QIIME 2 as you read this book so you can run the examples yourself.

### Using QIIME 2 on your personal computer

Using QIIME 2 on your personal computer is a very convenient option, but may be too slow for some steps of your analysis workflow. Steps such as sequence quality control and taxonomic assignment may require more CPU or memory resources than are available on your personal computer. This might make some of those steps impossible to run, or might render your personal computer useless for other tasks while you're waiting for a run to complete. That could take days or even weeks, depending on how powerful your personal computer is and how big the data set is that you're working with.

A related option is that you could have a dedicated computer for running QIIME 2 analyses. This could be a server that your team owns and maintains, and that everyone on your team has access to. Then, if you need to let a job run for a long time, that machine can run for days or weeks without disrupting other work that you need to do on your personal computer. If you go with this option, it's best to think about having that computer connected to a backup power supply in case of a power outage days into an analysis. 

QIIME 2 can be installed natively on macOS or Linux personal computers, and on Windows personal computers that support the Windows Subsystem for Linux. QIIME 2 can also be used on personal computers through virtual machines. Virtual machines are a useful option if QIIME 2 can't be installed natively on your computer, but should probably not be used otherwise as the overhead of running the virtual machine will reduce the CPU and memory resources that are available to QIIME 2. 

### Using QIIME 2 on a cluster computer

If you have access to a cluster computer, this is a great option for running QIIME 2. A cluster will typically have the resources needed to run QIIME 2 on large data sets. Typically you can reach out to your institution's high performance computing or research computing office, and let them know that you need to use QIIME 2. They will have a process for having it installed on the system and made available for you to use. 

One downside of using QIIME 2 on a cluster is that often you'll only have command line (i.e., terminal) access to the cluster - not a graphical interface. This means that to view QIIME 2 results you'll need to move them off that computer to your local machine for viewing. This isn't a problem - just a minor inconvenience that you'll need to get used to.  

### Using QIIME 2 on the Amazon cloud

If you do not have access to a cluster computer, AWS is a great option for running QIIME 2. With AWS, you rent computer resources from Amazon at an hourly rate. This is very similar to running on a cluster computer, except that Amazon owns and maintains the hardware (rather than you or your institution owning and maintaining it). If you expect to run QIIME 2 analyses fairly infrequently (e.g., monthly or less) this can be a very cost effective option. You may also qualify for [grants of cloud resource time from Amazon](https://aws.amazon.com/grants/). I received a couple of generous grants from AWS when I first started exploring it for running QIIME 2.

---

```{admonition} Tip: How I run QIIME 2
:class: tip
I personally find it convenient to use both a cluster computer and my personal computer for running QIIME 2. My university has a cluster computer that all researchers at the university have access to, and our high performance computing team keeps an up-to-date version of QIIME 2 installed on that computer. I typically run the long-running steps of my workflows on the cluster and download the results to my personal computer. Then, when I'm at a more iterative stage of my analysis (for example, when generating visualizations and running statistical tests), I'll run those commands locally so I can easily view the results. Most personal computers are powerful enough for these steps.  
```

### Installing QIIME 2

Because installation instructions for QIIME 2 will change slightly between versions, these instructions are better suited for the QIIME 2 website than for a book. To get the latest installation instructions, see the [QIIME 2 installation instructions web page](https://docs.qiime2.org/2020.8/install/native/). If you have trouble installing QIIME 2, or have questions related to where or how to deploy QIIME 2, post to the [QIIME 2 Forum](https://forum.qiime2.org).

I recommend taking some time now to get QIIME 2 installed on your personal computer, or finding another way to run it so you can follow along with the examples in this book. The data sets that we'll use as we work through the examples in this book are designed to run quickly on a personal computer, so you won't need cluster or cloud access to learn from this book. If you're preparing to run a bigger analysis soon, this is probably a good time to start figuring out what computer you'll use for that work as it can take some time to work with your high performance computing office to get QIIME 2 installed on their cluster, or to get approval from your institution to bill AWS expenses to them. 
