---
layout: page
title: PROJECT
---

## Looking for signatures of selection and adaptation across the goat genome


 The data for the project can be found also in [Dryad](https://datadryad.org/resource/doi:10.5061/dryad.v8g21pt). You will find three different **plink** files (.bed, .bim, .fam). These files have all the information needed for your analyses (check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) page for more details about the files).

The genomic data was analysed using the most recent version of the goat genome ([ARS1](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/?acc=GCF_001704415.1&context=genome)).



The dataset has a very large amount of different breeds an populations. To be more feasible to work with, you need to trim the dataset to a smaller number of populations. Check the original paper and choose the populations and create a text file with their 
codes. You can check [pops_to_keep.txt](../data/pops_to_keep.txt) as an example. Then use the following **plink** command

```
plink1.9 --bfile ADAPTmap_genotypeTOP_20160222_full  --keep-fam pops_to_keep.txt  --allow-extra-chr  --chr-set 31 --make-bed --out ADAPTmap_genotypeTOP_20160222_trim
```
In the bim file the first column correspond to the chromosomes. The new  genome assemby of the goat has 29 chromosomes. You will notice that you have chromosome 30 and 0, that corresponds to cromosome X and unplaced SNPs.  



<br/>

-----------------------------------------
**Notes**
A trimmed dataset is available [here](../data/goat_trim.zip)


----------------------------------------------------
<br/>

### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

