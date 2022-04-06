---
layout: page
title: Practical pcadapt
---

<br/>

### Instructions for analysing wolf genomic data using the pcadapt package
All the data needed for this practical can be found in [pcadapt_practicals.zip](../data/pcadapt_practicals.zip)

<br/>

### To install the pcadapt package.

Install **pcadapt** in **R** (These instructions are based on version 4.3.3).

```R
install.packages("pcadapt")
```
Then wait quite a long time while many packages get downloaded and installed.

### Two common file formats and programs in population genomics
Genomic data is typically stored in one of two formats: **PLINK** and **vcf**. Programs can be used to interchange between the two.  These were originally text files, so can be viewed using a text editor, but there is no expectation that these should be edited manually. Typically, compressed binary versions of the text files are used. vcf files are highly structured and complex and typically end in `.vcf`. The binary variant ends with `.bcf`. PLINK files are simpler, with similar information to a vcf represented in two or three files, with endings `.ped` and `.map` for text versions and `.bed`, `.fam`, and `.bim` for compressed binary versions. The ped/bed files contain the genotype information, the fam file contains some of the information in the ped relating to individuals ids and phenotypes. The map file contains the location (chromosome, base position) of each variant. 

### To obtain the wolf data from Dryad
The vcf file we are going to work with can be found in [Dryad](https://datadryad.org/resource/doi:10.5061/dryad.c9b25)
which gives some context. You can either download the vcf file here or use the `wolf.vcf` on [pcadapt_practicals.zip](../data/pcadapt_practicals.zip). You will also need some individual descriptor information which is available in the file ``AllSamples_n107_EnvData_wLatLong_toUpload.csv`` (converted to .csv from the relevant file in Dryad). 
 

### Convert wolf.vcf to wolf.bed
**pcadapt** no longer supports vcf files and its preferred format is ``.bed`` type files. We suggest that you use  **plink1.9** to convert the ``wolf.vcf`` to ``wolf.bed``.

### Install PLINK1.9 

Go to the PLINK website: https://www.cog-genomics.org/plink/
Download the binary file appropriate to your operating system (Windows or Mac) (make sure you choose the stable 1.9 version).
This is in a zip folder which needs to be decompressed

To run the command for PLINK you will need to copy the binary file (`plink.exe` in Windows) into you working folder, which should also contain a copy of the wolf data.

In Windows you can use the powershell to run the executable. You need to make sure that you have changed folder to your working folder in powershell. An easy way to do this is to copy and paste the folder path in file explorer into the powershell windows:

```sh
cd "pathname"
```
You need to put the pathname in quotes (otherwise it will get confused by any spaces). Once you are in the correct folder, in Windows run:

```sh
.\plink --vcf wolf.vcf --allow-extra-chr --chr-set 38 --make-bed --out wolf
```
(Note the dot and backslash.)

For the Mac the process is similar but you will use the terminal window. In the Mac terminal the commands are unix commands (very similar to those you are using on the server). The powershell commands have some similarity to unix, but note the backslash for Windows, which should be forward-slash for unix/Mac (you will need to have the dot for both).

By default **plink1.9** reads 22 pairs of autosomes. However, wolves have 76 autosomes arraged in 38 pairs. We need to use the option `--allow-extra-chr` and set the chromosome number to 38.

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

In the end you will have three different **plink** files (```.bed```,```.bim```, ```.fam```). Check the [plink1.9](https://www.cog-genomics.org/plink/1.9/formats) webpage for more details about the files. 


### Reading .bed data into pcadapt 
Return to **R**  and load **pcadapt**:

```R
library(pcadapt)
```

A tutorial for running **pcadapt** is to be found  [here](https://bcm-uga.github.io/pcadapt/articles/pcadapt.html).
We will discuss this vignette in some detail because it is important for understanding some of the instructions below.
<br/>

Then do the following:

```R
fname <- read.pcadapt("wolf.bed",type="bed")
```
You should read in 107 individuals and 13092 SNPs. You can check this by using 
```R
str(fname)
```

>
----------------------------------------------------------


If you are interested in the identity of particular SNPs the `wolf.bim` file has chromosome or scaffold information that is useful for consulting genebank or the ensembl genome browser.

<br/>

 You can read the `wolf.bim` file  in **R**

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

Up to a constant, it corresponds to the eigenvalues in decreasing order. We are going to use the Cattell’s rule to choose the optimal number of K, i.e., we will keep PCs that correspond to eigenvalues to the left of the straight line. This seems to have a bit of an elbow at 6, so let’s use 5.

```R
test1 = pcadapt(fname,K=5)
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
will show that you have 107 rows (individuals) and 13092 columns (SNPs). The genotypes are coded in the ‘0’, ‘1’ or ‘2’ formats, depending on the number of copies of the reference allele an individual has.

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
Then this gives a PCA plot with population information:
```R
plot(test1,option="scores",pop=poplist.names)
```

By default, the projection is done onto the first two principal components. To plot other principal components, you need to specify the values of *i* and *j*.

```R
plot(test1,option="scores", i=1, j=4, pop=poplist.names)
```


### Evidence of selection

The following shows a plot of the –log10 pvalues.
```R
plot(test1,option="manhattan")
```

To look at, for example, the  SNPs with –log10 p-values > 15 :
```R
outliers = which(-log10(test1$pvalues) > 15)
position.details[outliers,]
```

You can type
```R
outliers
```
by itself to see the position in  your list of  SNPs. For example,  the first SNP is at position 3981, whereas ``` position.details  ``` gives the 'coordinates' of the SNP (the chromosome and base position) in the genome assembly. 

We can see what principal component they have the highest correlation with by:
```R
get.pc(test1,outliers)
```

We can look at the distribution of the allele types on the PCA plot associated with high scoring SNPs.
For example the first SNP (position 3981 among the SNPs – note, not position in the genome) correlates with PC4. So we might hope to see some difference in the distribution of genotypes for this SNP in the PCA plot.

First, we can remind ourselves of the geographic labels of the individuals: 
```R
plot(test1,option="scores", i=1, j=4, pop=poplist.names)
```
as before, which gives:

<img src="..\data\project1.png">

We can then look at the distribution of genotypes for SNP 3981, using the raw PCA data kept in the ``test1`` object, and the genotype info we have stored in raw.data:
```R
plot(test1$scores[,1],test1$scores[,4],col=raw.data[,3981]+1,pch=16)
```

<img src="..\data\project_selec.png"> 

You can see that this SNP seems to be strongly differentiated between the High Arctic population and the others. In this coding,  black signifies the (minor,minor) homozygote, red signifies the (minor,major) heterozygote, and green signifies the (major,major) homozygote. The distribution of genotypes within the areas seems broadly consistent with Hardy-Weinberg equilibrium.

We can then further investigate the details of this SNP using the NCBI genome browser. To do this, use a web browser to navigate to NCBI, and then navigate to the dog genome (CanFam3.1), then search for the SNP position for the appropriate chromosome.

[Dog genome (CanFam3.1)](https://www.ncbi.nlm.nih.gov/genome/gdv/browser/?context=genome&acc=GCF_000002285.3)

The link above will take you directly to the genome of the dog. Choose the chromosome you want, and then search for the nucleotide you want in the search window, and then find nearby genes.

For example:

<img src="..\data\ncbi_pic.png"> 

<br/>

### Choosing a p-value cutoff

In the example above we arbitrarily chose –log10 p-values > 15 as a cutoff.
There are several methods to choose a cutoff more formally for outlier detection. Below is the Bonferroni correction, which is more conservative: 
```R
padj <- p.adjust(test1$pvalues,method="bonferroni")
alpha <- 0.01 #significance level
outliers <- which(padj < alpha)
length(outliers)
position.details[outliers,]
get.pc(test1,outliers)
```

### Using g:Profiler

A further method for finding functional roles for the genes that we identify is to make use of the gene ontology information associated with the genes. As you will find in this practical, this approach is not particularly helpful for the wolf data. However it may be useful for your project on wild boar and pigs. 

The g:profiler website contains a number of tools for determining the functional relevance of a collection of genes:https://biit.cs.ut.ee/gprofiler/gost

The paper describing the site in more detail is given [here](https://doi.org/10.1093/nar/gkz369).

We will work only with the g:GOSt tool
We need to give it a set of genes in the query box. 
The easiest way to do this is to provide gene ranges. The tool knows the genomes for a number of organisms (including dog and pig), so if we provide some genome coordinates it can identify the genes within those regions. A potential problem which we will ignore is that if the g:profiler is up to date then the genome assemblies that we use may have slightly altered map positions for the nucleotides that we identify. However, it is likely that this effect is quite small, and we can carry out post-hoc checks on the genes that it identifies to see if they are in reasonable positions.

To facilitate providing the ranges to the g:GOSt tool I have written a short [R function](../src/R/for_gprofiler.R) that takes the significant nucleotide positions that we have identified from pcadapt and outputs a file ``gprofiler_query.txt``. 
Look at the source code for this function to be clear about the arguments that are used, and the output. You will need to download the function into your working folder and ```source``` it.
Because the wolves do not give particularly strong results, in this example we use the false discovery rate with a cutoff at 0.05. The argument ``focus`` specifies the range above and below the target nucleotide position. The example below is for 10,000 bases above and below. Linkage disequilibrium due to selection may not extend far beyond this, so it is probably not worthwhile to extend too far, but you could try 20,000, or go down to e.g. 1000. 
```R
alpha = 0.05
padj <- p.adjust(test1$pvalues,method="fdr")
outliers <- which(padj < alpha)
query = for.gprofiler(position.details[outliers,c(1,4)],focus=10000)
```
You can open the file ``gprofiler_query.txt`` in a text editor and cut and paste the contents into the query box. You will also need to choose ``Dog`` for the organism (*Canis lupus familiaris*). In the case of the wolves, because the results are so weak, you need to click on  Advanced Options and choose 0.1 for the user threshold (you can also choose to tick All Results to see everything that has been found). This is the significance threshold used for displaying results (the p-values themselves are corrected for multiple comparisons).
There are different tabs for displaying results. The Detailed Results tab gives the option of downloading in a spreadsheet. This will also give the individual genes used (and their ENSEMBL codes). 
 
<img src="..\data\GO_detailed_res.png"> 


**How does g:profiler work?**

The tool looks through the list of Gene Ontology terms. For each GO term (call it our ``target``) there will be a number of genes, *m*, associated with it. There are many, say *N*, (typically more than 15,000) genes that have a GO term in the entire database. So *m* is a subset of *N*. We have, say, *k* genes in our query list that have at least one GO term (so this is also a subset of N). Finally, we have *x* genes that are associated with the target query GO term. So the p-value that is returned is related to the probability of a random sample of *x* genes out of *k* having a GO term that is represented *m* times out of *N* in the entire database. If natural selection is favouring a particular function across all genes then this should be give a bias in the distribution of GO terms in the outlier genes from pcadapt. 



### Back

Back to [pcadapt](./PCadapt.md).   
Back to [first page](../index.md).

