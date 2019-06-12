---
layout: page
title: PROJECT
---

## Looking for signatures of selection and adaptation across the goat genome


We will be using the AdaptMap goat dataset that can be found in [Dryad](https://datadryad.org/resource/doi:10.5061/dryad.v8g21pt). In addition, make sure that you follow the link to, and download a copy of, the paper that describes this dataset. The distribution contains three different **plink** files (.bed, .bim, .fam). These files potentially have all the information needed for your analyses (check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) webpage for more details about the files).


**However...** The dataset has a very large number of individuals sampled from different breeds (look at the paper). To make it more feasible to work with, it is necessary to trim the dataset to a smaller number of populations. An example trimmed dataset is available [here](../data/goat_trim.zip). This is based on data from the following populations: 

You may base your project purely on this dataset, in which case you do not need to download files from Dryad. Alternatively, you could have a look at the original paper and think of suitable hypotheses for your project. Then choose the populations needed to test the hypotheses. If you take this route, you will need to run the plink command in Doraemon, as you did on Wednesday. You can create a file with a list of the population codes, as in this example: [pops_to_keep.txt](../data/pops_to_keep.txt). 

Use the following **plink** command to trim the original dataset (check [here](https://www.cog-genomics.org/plink/1.9/index) for more details about the plink functions). 

```
plink --bfile ADAPTmap_genotypeTOP_20160222_full  --keep-fam pops_to_keep.txt  --allow-extra-chr  --chr-set 31 --make-bed --out ADAPTmap_genotypeTOP_20160222_trim
```
In the bim file, the first column corresponds to the chromosomes. The new  genome assemby of the goat has 29 chromosomes. You will notice that you have chromosomes 30 and 0, which respectively correspond to chromosome X and unplaced SNPs.  

The AdaptMap goat dataset was mapped to the most recent version of the goat genome ([ARS1](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/?acc=GCF_001704415.1&context=genome)). So, when you need to query any particular SNPs that you find you can link to this, and then follow the same procedure as you did with the wolves.

## Aims for the Project

It is probably best to conduct your project with a view to how you will write it up in a report.

When you write your report, you will need to provide an Introduction, for which the original paper will be helpful. The final paragraph of the Introduction will then outline the aims of your research. The Methods section will provide a brief overview of the methods you used (nothing too technical). The Results will provide an overview of what you found. For example, I expect it will contain a number of figures from a PCAdapt analysis - score plot and Manhattan plot, for example. It may also contain examples of the PCA distribution of alleles for SNPs that appear to be under selection. You can also summarise in the Results the gene descriptions for candidate SNPs in Genbank. The Discussion will then contrast the results with your initial aims and expectations, provide some critique of what you have found, and point to future research. 

<br/>



## Reference
[Bertolini F, Servin B, Talenti A, Rochat E, Kim ES, Oget C, Palhière I, Crisà A, Catillo G, Steri R, Amills M, Colli L, Marras G, Milanesi M, Nicolazzi E, Rosen BD, Van Tassell CP, Guldbrandtsen B, Sonstegard TS, Tosser-Klopp G, Stella A, Rothschild MF, Joost S, Crepaldi P, AdaptMap Consortium (2018) Signatures of selection and environmental adaptation across the goat genome post-domestication. Genetics Selection Evolution 50(1): 57]( https://doi.org/10.1186/s12711-018-0421-y)

<br/>

### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

