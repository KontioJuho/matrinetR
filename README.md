![My Image](network.jpeg)
MatriNet is a recently published database and analysis platform for the exploration of extracellular matrix (ECM) protein networks across tumors with interactive tools embedded into graphical user interfaces (available at www.matrinet.org).  This package is an open-source repository and a modular extension to MatriNet that enables local operations on the same data sources with enhanced customizations, previews features before their online implementation, and promotes collaborative efforts and community-driven solutions for the MatriNet ecosystem.

MatrinetR contains pre-processed gene expression and clinical data for 23 tumor types from The Cancer Genome Atlas (TCGA) and corresponding normal (GTEx) tissues from the Genotype-Tissue Expression (GTEx) database, as well as immunohistochemistry staining profiles from The Human Protein Atlas (THPA).



If you have any questions or suggestions, please feel free to contact us.

<!-- GETTING STARTED -->
## Install the package
The developmental version of MatriNet R package is freely available and can be installed as follows:
```r
require(devtools)
devtools::install_github("KontioJuho/matrinetR")
``` 


<!-- USAGE EXAMPLES -->
## Package structure
The MatrinetR library has two major objects, **matridata** and **matrigraph**, with the corresponding **matrinet_data** and **matrinet_graph** functions. 


| Function | Input | Output |
| --- | --- | --- |
| `matrinet_data` |  List of cancer specific data frames | Matridata: Prepared gene/protein data|
| `matrinet_graph` | Edgelist and Matridata | Matrigraph: Initial structure |
| `matrinet_estimate` | Matridata and Matrigraph | Matrigraph: Updated structure|

### Matrigraph: Initial structure
Matrigraph is the graph object that is created for each group and is consisting of two objects: **node.df** and **edge.df**.  All of the preceding network data, e.g. known interactions and prior weigths, are stored into a edge.df dataframe. By default, this is an edge-list with two colums, Gene1 and Gene2, representing experimentally verified matrisome interactions downloaded from matrixDB. Moreover, any number of gene-specific annotations could be added into a node.df dataframe as a new column. 

|Gene1 | Gene2 | Family 1 | Family 2 |
| --- | --- | --- | --- |
| A2M | IL10 | ECM REGULATORS | SECRETED FACTORS|
| A2M | MFAP2 | ECM REGULATORS | ECM GLYCOPROTEINS|
| . . . | . . . | . . . |. . . |
| COCH | COL2A1 | ECM GLYCOPROTEINS | COLLAGENS|

### Matrigraph: Updated structure after the network estimation
While matrigraph objects are created before the actual estimation process,  it also serves for storing the results. The main network estimation function, matrinet_estimate, takes matrigraph as an input and updates edge.df object by adding new columnds representing estimated weights for each element in the matrigraph edgelist.

|Gene1 | Gene2 | Family 1 | Family 2 |  Correlation | Mutual information | Jensen-Shannon Divergence | 
| --- | --- | --- |--- | --- | --- | --- |
| A2M | IL10 |ECM REGULATORS | SECRETED FACTORS | 0.03 | 0.4 | 0.11|
| A2M | MFAP2 | ECM REGULATORS | ECM GLYCOPROTEINS | 0.21 | 0.04 | 0.45|
| . . . | . . . | . . . |. . . | . . . | . . .| . . . |
| COCH | COL2A1 |ECM GLYCOPROTEINS | COLLAGENS | 0.25 | 0.17 | 0.16|

### Matridata 

is a list consisting an object for each sample group (e.g. by tumor). Then each group object, is consisting of three different preprocessed gene/protein dataframes that are used in different ways in the network estimation process: 

**CONTINUOUS** 

Log2-transformed gene/protein expression data with n (sample size) rows and p (number of genes) columns.
<details><summary>Click to see an example</summary>
<p>


|ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 3.32 | 5.2 | 12.93 | 2.54 | 0 | 5.2 | 9.49 | 1.69 | 13.36 | 9.19 | 2.78|
| 5.54 | 6.91 | 11.45 | 2.69 | 0 | 9.91 | 6.95 | 4.85 | 13.91 | 9.9 | 3.92|
| 6.32 | 10.83 | 13.19 | 4.51 | 0 | 10.55 | 12.45 | 2.73 | 14.9 | 10.69 | 4.04|
| 6.97 | 5.13 | 13.66 | 5.33 | 0 | 6.03 | 10.59 | 3.12 | 14.63 | 10.69 | 4.69|
| 5.23 | 6.75 | 13.31 | 4.21 | 0 | 7.06 | 10.48 | 3.61 | 14.42 | 10.66 | 4.3|
| 5.18 | 4.78 | 13.33 | 4.43 | 0 | 5.8 | 8.24 | 6.47 | 14.79 | 10.31 | 4.87|

  </p>
</details>

 **DISCRETE** 
 
 Discretized gene/protein expression data (up/down regulation) with n rows and p columns.


<details><summary>Click to see an example</summary>
<p>


  |ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| -1 | 0 | 1 | -1 | -1 | 0 | 0 | -1 | 1 | 0 | -1|
| 0 | 0 | 1 | -1 | -1 | 0 | 0 | 0 | 1 | 0 | 0|
| 0 | 1 | 1 | 0 | -1 | 1 | 1 | -1 | 1 | 1 | 0|
| 0 | 0 | 1 | 0 | -1 | 0 | 1 | -1 | 1 | 1 | 0|
| 0 | 0 | 1 | 0 | -1 | 0 | 1 | 0 | 1 | 1 | 0|
| 0 | 0 | 1 | 0 | -1 | 0 | 0 | 0 | 1 | 1 | 0|
    </p>
</details>

**PROFILE** 

  Frequency distributions of discretized gene/protein expression levels with 3 rows (low, medium, high) and p columns.

<details><summary>Click to see an example</summary>
<p>
  
  |ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0.1226 | 0.2206 | 0 | 0.5712 | 0.9975 | 0.0222 | 0.07 | 0.6815 | 0 | 0 | 0.1679|
| 0.8774 | 0.5062 | 0.0272 | 0.4247 | 0.0025 | 0.8568 | 0.7523 | 0.3177 | 0.0091 | 0.7407 | 0.8288|
| 0 | 0.2733 | 0.9728 | 0.0041 | 0 | 0.121 | 0.1778 | 0.0008 | 0.9909 | 0.2593 | 0.0033|
  
</p>
</details>


## Tutorial

### Step 1: Check gene availability and validity
The matrinetR workflow begins by specifying the target genes of interest to check if they are accessible in the gene/protein data set. Furthermore, the input datasets are considered to be valid for the network estimation process only with complete observations, i.e.,  without any missing values.  Both gene availability and validity can be checked automatically with the provided "available_genes"  functions with two arguments: a character vector of target genes and the input data. 

```r

matrisome_genes <- unique(c(matrixDB$gene.x, matrixDB$gene.y))
cancers <- c("brca", "ov", "prad")


valid_genesTCGA <- available_genes(target_genes = matrisome_genes,
                                   data = matrisome_TCGA[cancers])
                                   
valid_genesGTEx <- available_genes(target_genes = matrisome_genes, 
                                   data = matrisome_GTEx[cancers])


valid_genes <- intersect(valid_genesTCGA$available_zero_NAs,
                         valid_genesGTEx$available_zero_NAs)



```
It returns 1) available genenames, 2) missing genenames, 3) available genes without missing values, and 4) available genes with  less than 5% of missing values over samples in any group. Note that the option IV requires an additional missing-value imputation method to be employed.

### Step 2: Create the input matridata 
The next step is to the specify matridata objects for each cohort which automatically extacts available variables and checks if they are valid for the network estimation process. A variable is selected if it is measured on 95% of all samples in each selected cancer type and cohort (i.e. almost complete cases only).  If the number of missing values is less than 5% of all observations, the default imputation method is to use a variable and group specific median. 

```r

matridata_GTEx <- matrinet_data(data = matrisome_GTEx[cancers],
                                quantiles = discretization_levels,
                                genenames = valid_genes)


matridata_TCGA <- matrinet_data(data = matrisome_TCGA[cancers],
                                quantiles = discretization_levels,
                                genenames = valid_genes)

```

### Step 3: Initialize the matrigraph structure

The next step is to create initial matrigraph objects from the matrixDB data for all selected cancer groups in both cohorts:

```r

matrigraph_TCGA <- matrinet_graph(matridata = matridata_TCGA,
                                  prior_topology = matrixDB_adjacency[valid_genes,
                                                                      valid_genes])

matrigraph_GTEx <- matrinet_graph(matridata = matridata_GTEx ,
                                  prior_topology = matrixDB_adjacency[valid_genes,
                                                                      valid_genes])



```
### Step 4: Estimate the networks and update matrigraph objects


The network estimation can be done simply from the above matridata and matrigraph objects with the matrinet_estimate function as follows:

```r

matrinet_TCGA <- matrinet_estimate(matrigraph = matrigraph_TCGA,
                                   matridata = matridata_TCGA)

matrinet_GTEx <- matrinet_estimate(matrigraph = matrigraph_GTEx,
                                   matridata = matridata_GTEx)

```
_For more examples, please refer to the [Documentation]()_

<p align="right">(<a href="#top">back to top</a>)</p>
