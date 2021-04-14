---
layout: page
title: PROJECT
---

## Looking for signatures of selection and adaptation across the pig and wild boar genome


We will be using a large pig and wild boar dataset that can be found in [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.30tk6). In addition, make sure that you follow the link that Dryad provide to the [paper](https://gsejournal.biomedcentral.com/articles/10.1186/s12711-017-0345-y) that describes this dataset. The distribution contains two different **plink** files (```.ped``` and ```.map```). These have been zipped separately. It also contains a useful excel sheet that describes the provenance of the samples (populations and GPS positions). Unzip them and put the files in the same  folder. Transfer **both** plink files together to the server (as in the practical). We will need to convert the ```.ped``` file to a ```.bed``` file. This conversion will also create some other files that will be useful.  These files potentially have all the information needed for your analyses (check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) webpage for more details about the files).

The ```plink``` command you will need is 
```sh
plink --file JWM_Final --chr 1-18 --make-bed --out allsamples
```
(you are free to call it something other than allsamples). You must ensure that the ```.ped``` and ```.map``` file are in the same folder.

**However...** The dataset has a very large number of individuals sampled from different breeds and wild boar populations (look at the paper). To make it more feasible to work with, it is necessary to trim the dataset to a smaller number of populations. An example text file with the population identifiers is available [here](../data/pop1.txt). This is based on data from the following populations:  
FIWB - Finnish wild boar <br/>
GRWB - Greek wild boar <br/>
HRWB - Croatian wild boar <br/>
IBWB - Iberian wild boar <br/>
ITWB1 - Italian wild boar <br/>
ITWB2 - Italian wild boar <br/>
PLWB - Polish wild boar <br/>
SBWB  - South Balkan wild boar <br/>


These have been chosen to reflect wild boar  diversity in Europe, with a sufficiently small number of populations that you can  still visually distinguish the groups in pcadapt PCA plots. You will find that Cattell's rule suggests working with K=2 or K=6.

This example is provided to get you started. You are welcome to base your project purely on this subset, which may allow you to frame hypotheses about adaptive selection between wild boar populations  and/or domestication. I suggest  that you start with this anyway, to familiarise  yourself. After which you can  frame your own hypotheses and create a new subset to allow you test them for your project.

Whatever subset you choose, you will need to use plink to trim down the  bed file. For the ```pop1.txt``` example you would use:
```sh
plink --bfile allsamples --keep-fam pop1.txt --make-bed --out final
```

Note that plink only works with the prefix names for the files, and then creates various suffixes. It is probably safest to make sure you transfer all  the files with the same prefix back to your computer. 

Note that the number of chromosomes of the domestic pig/boar is 18 autosomes, although there is  potentially some variation  in boars. The paper uses the following reference genome: SScrofa10.2. This has 18 autosomes pairs plus sex chromosomes. The map  file also  contains unplaced SNPs (chromosome 0), which do  not have map positions. The ```plink``` command at the beginning chooses only the 18 autosomes. The chip is described [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0006524). 

Remember the dataset was mapped to this version of the genome assembly:
[SScrofa10.2](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/genome/?id=GCF_000003025.5)

(You can also look at Ensemble version of [SScrofa10.2](https://may2017.archive.ensembl.org/Sus_scrofa/Info/Index) if you are interested.)


## Aims for the Project

It is probably best to conduct your project with a view to how you will write it up in a report.

When you write your report, you will need to provide an Introduction, for which the original paper will be helpful. The final paragraph of the Introduction will then outline the aims of your research. The Methods section will provide a brief overview of the methods you used (nothing too technical). The Results will provide an overview of what you found. For example, I expect it will contain a number of figures from a PCAdapt analysis - score plot and Manhattan plot, for example. It may also contain examples of the PCA distribution of alleles for SNPs that appear to be under selection. You can also summarise in the Results the gene descriptions for candidate SNPs in NCBI. The Discussion will then contrast the results with your initial aims and expectations, provide some critique of what you have found, and point to future research. 

<br/>



## Reference

[Yang, B., Cui, L., Perez-Enciso, M. et al. Genome-wide SNP data unveils the globalization of domesticated pigs. Genet Sel Evol 49, 71 (2017)]( https://doi.org/10.1186/s12711-017-0345-y )
<br/>

### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

