![My Image](network.jpeg)
MatriNet is a recently published interactive database, available at [www.matrinet.org](),  designed for the analysis of extracellular matrix (ECM) protein networks across tumors.  The provided R package is an open-source repository and a modular extension of MatriNet (version 0.1) for creating an open-source methodological platform to promote collaborative efforts and community-driven solutions around the MatriNet program.


If you have any questions or suggestions, please feel free to contact us.

<!-- GETTING STARTED -->
## Install the package
The developmental version of MatriNet R package is freely available and can be installed as follows:
```r
require(devtools)
devtools::install_github("KontioJuho/matrinetR")
``` 


<!-- USAGE EXAMPLES -->
Matrinet network structures are built based on experimentally verified matrisome interactions present in the MatrixDB database (http://matrixdb.univ-lyon1.fr). These interactions are stored into *matrixDB* object available in data folder. 

```r
library(matrinetR)

?matrixDB

```

## MatrinetR for gene expression data 

MatrinetR contains pre-processed gene expression and clinical data for 23 tumor types from The Cancer Genome Atlas (TCGA) and corresponding normal (GTEx) tissues from the Genotype-Tissue Expression (GTEx) database, as well as immunohistochemistry staining profiles from The Human Protein Atlas (THPA).

```r
?matrisome_TCGA
?matrisome_GTEx
```


## Tutorial for new features

The MatrinetR workflow begins by defining the target genes and ensuring that they are accessible in the gene/protein data set. In this example, our target genes are all genes in the matrixDB interaction dataset and it seems that 363 of them are available in both GTEx and TCGA cohorts.

```r

matrisome_genes <- unique(c(matrixDB$gene.x, matrixDB$gene.y))
cancers <- c("brca", "ov", "prad")


valid_genes <- available_genes(matrisome_genes,
                               cancers = cancers,
                               TCGA = matrisome_TCGA, GTEx = matrisome_GTEx,
                               remove.allNA = TRUE)


```
The next step is to the specify matridata objects for each cohort which automatically extacts available variables and checks if they are valid for the network estimation process. A variable is selected if it is measured on 95% of all samples in each selected cancer type and cohort (i.e. almost complete cases only).  If the number of missing values is less than 5% of all observations, the default imputation method is to use a variable and group specific median. For this example, we will use all available variables in the dataset.

```r

init_TCGA <- matrinet_init(cancers = cancers, cohort = "TCGA",
              TCGA = matrisome_TCGA,
              subset_genes = valid_genes)

init_GTEx <- matrinet_init(cancers = cancers, cohort = "GTEx",
                           GTEx = matrisome_GTEx,
                           subset_genes = valid_genes)

```

```r


############### PROCESS mRNA DATA ################
#Step 1: Define quantiles for discretization
#Step 2: Get discretized mRNA data and corresponding mRNA-profile data

##################################################

discretization_levels <- c(log2(10+1), log2(1000+1))


#### STEP 1-2######

matridata_GTEx <- matrinet_data(datalist = matrisome_GTEx,
                                quantiles = discretization_levels,
                                genenams = valid_genes)


matridata_TCGA <- matrinet_data(datalist = matrisome_TCGA,
                                quantiles = discretization_levels,
                                genenams = valid_genes)



#### STEP 4 ######
############### Create network object ################



matrigraph_TCGA <- matrinet_graph(datalist = matrisome_TCGA,
                                  prior_topology = matrixDB_adjacency[valid_genes,
                                                                     valid_genes])

matrigraph_GTEx <- matrinet_graph(datalist = matrisome_GTEx,
                                  prior_topology = matrixDB_adjacency[valid_genes,
                                                                      valid_genes])


```

_For more examples, please refer to the [Documentation]()_

<p align="right">(<a href="#top">back to top</a>)</p>
