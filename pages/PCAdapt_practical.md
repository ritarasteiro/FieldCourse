---
layout: page
title: Practical pcadapt
---

All the data needed for this practical can be found in [pcadapt_practicals.zip](../data/pcadapt_practicals.zip)


## Instructions for analysing wolf genomic data using the pcadapt package


### To install the pcadapt package.

Install **pcadapt** in **R** (These instructions are based on version 4.1.0).

```R
install.packages("pcadapt")
```
Then wait quite a long time while many packages get downloaded and installed.


### To obtain the wolf data from Dryad

The file we are going to work with can be found by clicking [here](https://datadryad.org/resource/doi:10.5061/dryad.c9b25)
which gives some context.
You can either download the vcf file from here, but I have already done this in ``wolf.vcf``
You will also need some individual descriptor information which is available in the file ``AllSamples_n107_EnvData_wLatLong_toUpload.csv`` (converted to .csv from the relevant file in Dryad).


### Reading vcf data into pcadapt

```R
library(pcadapt)
```
Then do the following:

```R
fname <- read.pcadapt("wolf.vcf",type="vcf")
```
You should read in 107 individuals and 13092 SNPs.

Additionally, this function makes a new file in your current folder called ``positions.txt``, which has the nucleotide position of each SNP that is kept (i.e. 13092 positions in this example).
Read this file in:

```R
pcadapt.position <- scan("positions.txt")
```
>
----------------------------------------------------------
**NOTE**

Unfortunately, if you are interested in the identity of particular SNPs, this is not very informative because it throws out chromosome or scaffold information that is useful for consulting genebank


So you can use **plink** (many options). I just use the option below (but many other alternatives available – see the plink 1.9 manual online).

```
./plink --vcf wolf.vcf --chr-set 38 --recode --out plinkfile
```


<br/>

Then you can read in **R**

```R
position.details = read.table("plinkfile.map")
```

where
```R
chrom = position.detail[,1]
```
and
```R
chrom.pos = position.detail[,4]
```
-----------------------------------------------------------

<br/>

A tutorial for running **pcadapt** is to be found using
```R
vignette(“pcadapt”)
```
<br/>

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
test1 = pcadapt(fname,K=10)
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
descript = read.csv("AllSamples_n107_EnvData_wLatLong_toUpload.csv", as.is = T)
poplist.names = descript[,4] #fourth column contains the population names

plot(test1,option="scores",pop=poplist.names)
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

