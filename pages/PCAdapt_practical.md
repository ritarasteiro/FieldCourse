---
layout: page
title: Practical pcadapt
---

<br/>

### Instructions for analysing wolf genomic data using the pcadapt package
All the data needed for this practical can be found in [pcadapt_practicals.zip](../data/pcadapt_practicals.zip)


<br/>
### To install the pcadapt package.

Install **pcadapt** in **R** (These instructions are based on version 4.1.0).

```R
install.packages("pcadapt")
```
Then wait quite a long time while many packages get downloaded and installed.


### To obtain the wolf data from Dryad

The vcf file we are going to work with can be found in [Dryad](https://datadryad.org/resource/doi:10.5061/dryad.c9b25)
which gives some context. You can either download the vcf file here or use the `wolf.vcf` on [pcadapt_practicals.zip](../data/pcadapt_practicals.zip). You will also need some individual descriptor information which is available in the file ``AllSamples_n107_EnvData_wLatLong_toUpload.csv`` (converted to .csv from the relevant file in Dryad). 
 

### Convert ``wolf.vcf`` to ``wolf.bed``
Login to your BluePebble account. Create a folder named ``pcadapt`` in your ``$WORK`` directory. Upload the `wolf.vcf` file to your ``$WORK/pcadapt/``

**pcadapt** no longer supports vcf files and its preferred format is ``.bed`` type files. We suggest that you use  **plink1.9** to convert the ``wolf.vcf`` to ``wolf.bed``.
Load  **plink1.9**

```sh
 module load apps/plink/1.90
```

TODO: By default **plink1.9** reads 23 pairs of chromosomes. However, wolves have 76 autosomes arraged in 38 pairs. We need to use the option `--allow-extra-chr` and set the chromosome number to 38.

```sh
plink --vcf wolf.vcf --allow-extra-chr --chr-set 38 --make-bed --out wolf
```

You should see an output similar to this:


```console
PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to wolf.log.
Options in effect:
  --allow-extra-chr
  --chr-set 38
  --make-bed
  --out wolf
  --vcf wolf.vcf

385421 MB RAM detected; reserving 192710 MB for main workspace.
--vcf: wolf-temporary.bed + wolf-temporary.bim + wolf-temporary.fam written.
13092 variants loaded from .bim file.
107 samples (0 males, 0 females, 107 ambiguous) loaded from .fam.
Ambiguous sex IDs written to wolf.nosex .
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 107 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate is 0.993061.
13092 variants and 107 samples pass filters and QC.
Note: No phenotypes present.
--make-bed to wolf.bed + wolf.bim + wolf.fam ... done.

```

In the end you will have three different **plink** files (```.bed```,```.bim```, ```.fam```). Check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) webpage for more details about the files. Finally, download these three files to your computer.


### Reading .bed data into pcadapt 
```R
library(pcadapt)
```

A tutorial for running **pcadapt** is to be found  [here](https://bcm-uga.github.io/pcadapt/articles/pcadapt.html) or using:
```R
vignette(“pcadapt”)
```
<br/>

Then do the following:

```R
fname <- read.pcadapt("wolf.bed",type="bed")
```
You should read in 107 individuals and 13092 SNPs.


TODOAdditionally, this function makes a new file in your current folder called ``positions.txt``, which has the nucleotide position of each SNP that is kept (i.e. 13092 positions in this example).
TODO: CHECK if this file is still created when using bed files

TODORead this file in:

```R
pcadapt.position <- scan("positions.txt")
```
>
----------------------------------------------------------
**NOTE**

Unfortunately, if you are interested in the identity of particular SNPs, this is not very informative because it throws out chromosome or scaffold information that is useful for consulting genebank or ensembl genome browser.


<br/>

The `wolf.bim` file has all this information. You can read it in **R**

```R
position.details = read.table("wolf.bim")
```

where
```R
chrom = position.details[,1]
```
and
```R
chrom.pos = position.details[,4]
```
-----------------------------------------------------------



If we use, say, *K=10*, we can get a scree plot, and then can revise value of K (make sure you use upper case *K*)
```R
test1 = pcadapt(fname,K=10)
```
The scree plot is obtained by
```R
plot(test1,option="screeplot")
```
This seems to have a bit of an elbow at 6, so let’s use 6.

```R
test1 = pcadapt(fname,K=6)
```
We can see the components of ``test1``:
```R
str(test1)
```
We can also get the raw data that **pcadapt** is using by
```R
raw.data= bed2matrix(fname)
```
so that
```R
dim(raw.data)
[1]   107 13092
```
This gives a PCA plot:
```R
plot(test1,option="scores")
```

### Displaying the population information

We can plot with points coloured by population of origin.

You can obtain the list of population names from the *csv* file as:
```R
descript = read.csv("AllSamples_n107_EnvData_wLatLong_toUpload.csv")
poplist.names = descript[,4] #fourth column contains the population names
```
or using the wolf.fam file as:
```R
descript = read.table("wolf.fam")
poplist.names = descript[,1] #first column contains the population names
```
Then this gives a PCA plot with population information:
```R
plot(test1,option="scores",pop=poplist.names)
```

By default, the projection is done onto the first two principal components. To plot other principal components, you need to specifie the values of *i* and *j*.

```R
plot(test1,option="scores", i=3, j=4, pop=poplist.names)
```


### Evidence of selection

The following shows a plot of the –log10 pvalues.
```R
plot(test1,option="manhattan")
```

To look at, for example, the  SNPs with –log10 p-values > 15 :
```R
signif = which(-log10(test1$pvalues) > 15)
position.details[signif,]
```
We can see what principal component they have the highest correlation with by:
```R
get.pc(test1,signif)
```

We can look at the distribution of the allele types on the PCA plot associated with this high scoring SNP.
For example the first SNP (position 10715 among the SNPs – note, not position in the genome) correlates with PC2. So we might hope to see some difference in the distribution of genotypes for this SNP in the PCA plot.

We can look at this from the raw pca data kept in the ``test1`` object, and the genotype info we have stored in raw.data:
```R
plot(test1$scores[,1],test1$scores[,2],col=raw.data[,10715]+1,pch=16)
```
We can then further investigate the details of this SNP using genebank. To do this, use a web browser to navigate to genebank, and then navigate to the dog genome (CanFam3.1), then search for the SNP position for the appropriate chromosome.

[Dog genome (CanFam3.1)](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/?context=genome&acc=GCF_000002285.3)

The link above will take you directly to the genome of the dog. Choose the chromosome you want, and then search for the nucleotide you want in the search window, and then find nearby genes.



<br/>

### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

