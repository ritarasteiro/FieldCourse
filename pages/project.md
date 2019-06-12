---
layout: page
title: PROJECT
---

## Looking for signatures of selection and adaptation across the goat genome


We will be using the AdaptMap goat dataset that can be found in [Dryad](https://datadryad.org/resource/doi:10.5061/dryad.v8g21pt). You will find three different **plink** files (.bed, .bim, .fam). These files have all the information needed for your analyses (check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) webpage for more details about the files).



The dataset has a very large amount of different breeds an populations. To be more feasible to work with, you need to trim the dataset to a smaller number of populations. Have a look at the original paper and think of a hypothesis for your project. Then choose the populations needed to test it and create file with their codes. You can check [pops_to_keep.txt](../data/pops_to_keep.txt) as an example. 

Use the following **plink** command to trim the original dataset (check [here](https://www.cog-genomics.org/plink/1.9/index) for more details about the plink functions). 

```
plink --bfile ADAPTmap_genotypeTOP_20160222_full  --keep-fam pops_to_keep.txt  --allow-extra-chr  --chr-set 31 --make-bed --out ADAPTmap_genotypeTOP_20160222_trim
```
In the bim file, the first column corresponds to the chromosomes. The new  genome assemby of the goat has 29 chromosomes. You will notice that you have chromosomes 30 and 0, that correspond to cromosome X and unplaced SNPs.  

The AdaptMap goat dataset was mapped to the most recent version of the goat genome ([ARS1](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/?acc=GCF_001704415.1&context=genome)).



<br/>

-----------------------------------------
**Notes**
A trimmed dataset is available [here](../data/goat_trim.zip).


----------------------------------------------------


## Reference
[Bertolini F, Servin B, Talenti A, Rochat E, Kim ES, Oget C, Palhière I, Crisà A, Catillo G, Steri R, Amills M, Colli L, Marras G, Milanesi M, Nicolazzi E, Rosen BD, Van Tassell CP, Guldbrandtsen B, Sonstegard TS, Tosser-Klopp G, Stella A, Rothschild MF, Joost S, Crepaldi P, AdaptMap Consortium (2018) Signatures of selection and environmental adaptation across the goat genome post-domestication. Genetics Selection Evolution 50(1): 57]( https://doi.org/10.1186/s12711-018-0421-y)

<br/>

### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

