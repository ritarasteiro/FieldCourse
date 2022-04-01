---
layout: page
title: Plotting coalescent trees using R
---
### Setup
Decide on your working folder, start R, and navigate to this folder.

### In order to work the scripts require two packages:
* ape
* phyclust

If they are not installed you need to open R and

1. set Cran Mirror, and choose one e.g. Bristol
2. select repositories, and accept the default it suggests
3. select packages, choose *ape* and also choose *phyclust*

Or you can type:
```R
install.packages(c("phyclust", "ape"))
```

<br/>

### There are two scripts:
* [plot_ms_trees_single_pop.R](../src/R/plot_ms_trees_single_pop.R)
* [plot_ms_trees_mig.R](../src/R/plot_ms_trees_mig.R)

If you click on the links above you will be able to download the files. 
Put them in your working folder for R

Type:
```R
source("plot_ms_trees_single_pop.R")
```
This will import the function ```plot_ms_tree()```. This function has two parameters:
* The number of haploid samples
* The ms options for a single pop

You can run different scenarios:
* Standard stationary population.
```R
plot_ms_tree(10, "-T")
```
This is for a sample of 10 gene copies and the "-T" option indicates only to 
simulate a tree rather than sequence data.

* Population growth.
```R
plot_ms_tree(10, "-T -G 1000")
```
The "-G" flag specifies a scaled population growth rate (bigger values, faster growth)

* Population decrease.
```R
plot_ms_tree(100,"-T -G -2.119 -eG 2.5 0.0")
```
A bit more complicated to explain: the population size is increasing into the past (note
negative value), but then remains constant at a certain time. Details explained in the [ms documentation](../data/msdoc.pdf)


The second script allows you to simulate structured populations and works differently.

Type:
```R
source("plot_ms_trees_mig.R")
```
This will import the function ```plot_ms_tree_mig()```. This function has two parameters:
* The number of haploid samples per population
* scaled migration parameter *4Nm*



```R
plot_ms_tree_mig(c(10, 10), 10)
```

It should plot a tree with two colors corresponding to two populations. The ms command here is for 20 individuals, 2 demes with 10 samples from each, and symmetrical migration with 4*Nm* = 10. The colours correspond to the different demes from which the genes were sampled.

The **ms** command running behind the ```plot_ms_tree_mig()``` function is ```ms nsam nreps -T -I npop n1 n2 ... 4Nm```. In the example above it corresponds to ```ms 20 1 -T -I 2 10 10 10```.

Try change the migration rate for instance *4Nm*=0.1. You can also increase the number of populations and sample sizes.



<br/>

### Back

Back to [Coalescent](./coalescent.md).   
Back to [first page](../index.md).
