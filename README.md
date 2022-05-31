![My Image](network.jpeg)
MatriNet is a recently published database and analysis platform for the exploration of extracellular matrix (ECM) protein networks across tumors with interactive tools embedded into graphical user interfaces (available at www.matrinet.org).  This package is an open-source repository and a modular extension to MatriNet that enables local operations on the same data sources with enhanced customizations, previews features before their online implementation, and promotes collaborative efforts and community-driven solutions for the MatriNet ecosystem.




<!-- GETTING STARTED -->
## Install the package
The developmental version of MatriNet R package is freely available and can be installed as follows:
```r
require(devtools)
devtools::install_github("KontioJuho/matrinetR")
``` 

If you have any questions or suggestions, please feel free to contact us.

<!-- USAGE EXAMPLES -->
## Package structure

The most central object of matrinetR package and the analysis workflow is **matrigraph**. At first, all prior information about the genes/proteins (e.g.family/category)  and their underlying network structure (e.g., the edgelist from matrixDB) are stored into the *initial* matrigraph object. The matrinetR workflow is about updating the initial matrigraph  with properties estimated from the input data. This, in turn, requires gene/protein level input data, which must be given in a specific **matridata** form. The relationships between matrigraph, matridata, and provided functions can be summarized as follows:

| Function | Input | Output |
| --- | --- | --- |
| `matrinet_data` |  List of cancer specific data frames | Matridata: Prepared gene/protein data|
| `matrinet_graph` | Edgelist and Matridata | Matrigraph: Initial structure |
| `matrinet_estimate` | Matridata and Matrigraph | Matrigraph: Updated structure|

## Matrigraph

### Initial matrigraph structure
Matrigraph is the graph object that is created for each group and is consisting of two objects: **node.df** and **edge.df**.  All of the preceding network data, e.g. known interactions and prior weigths, are stored into a edge.df dataframe. By default, this is an edge-list with two colums, Gene1 and Gene2, representing experimentally verified matrisome interactions downloaded from matrixDB. Moreover, any number of gene-specific annotations could be added into a node.df dataframe as a new column. 

<details><summary>Click to see an example</summary>
<p>
  
|Gene1 | Gene2 | Family 1 | Family 2 |
| --- | --- | --- | --- |
| A2M | IL10 | ECM REGULATORS | SECRETED FACTORS|
| A2M | MFAP2 | ECM REGULATORS | ECM GLYCOPROTEINS|
| . . . | . . . | . . . |. . . |
| COCH | COL2A1 | ECM GLYCOPROTEINS | COLLAGENS|
  
  </p>
</details>

### Output matrigraph structure
While matrigraph objects are created before the actual estimation process,  it also serves for storing the results. The main network estimation function, matrinet_estimate, takes matrigraph as an input and updates edge.df object by adding new columnds representing estimated weights for each element in the matrigraph edgelist.
<details><summary>Click to see an example</summary>
<p>

|Gene1 | Gene2 | Family 1 | Family 2 |  Correlation | Mutual information | Jensen-Shannon Divergence | 
| --- | --- | --- |--- | --- | --- | --- |
| A2M | IL10 |ECM REGULATORS | SECRETED FACTORS | 0.03 | 0.4 | 0.11|
| A2M | MFAP2 | ECM REGULATORS | ECM GLYCOPROTEINS | 0.21 | 0.04 | 0.45|
| . . . | . . . | . . . |. . . | . . . | . . .| . . . |
| COCH | COL2A1 |ECM GLYCOPROTEINS | COLLAGENS | 0.25 | 0.17 | 0.16|
  
  </p>
</details>

## Matridata 
MatrinetR extends the original protein-level network analysis of MatriNet into a gene-level and provides pre-processed gene expression and clinical data for 23 tumor types from The Cancer Genome Atlas (TCGA) and corresponding normal (GTEx) tissues from the Genotype-Tissue Expression (GTEx) database. Since this provides an indidividual level expression data, a wide variety of different network estimation method can be applied. With gene-level data, matridata object is consisting of three separate dataframes of preprocessed mRNA data, that are used in different ways in the network estimation process: 



<img src="matridata.png" width="80%">





**Continuous:** For each sample group of interest, datasets of *continuous* type are consisting of the original input data given at continuous scale.log2-transformed gene/protein expression data with n (sample size) rows and p (number of genes) columns. For example, by using the built-in *matrisome_TCGA* dataset, the above values represent the batch effect normalized and log2(norm_value+1) transformed expression levels, downloaded from UCSC Xenahub platform's PanCancer Atlas https://xenabrowser.net/datapages/.



 
**Discrete:** Datasets of *discrete* type are the discretized gene/protein expression-level version of *continuous* datasets with n rows and p columns with values -1, 0, and 1. Discretization levels can be defined by users (see tutorial).  


  **Profile:** Frequency distributions of discretized gene/protein expression levels with 3 rows (low, medium, high) and p columns.

<details><summary>Continuous data example (click)</summary>
<p>

| sampleID | ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| brca_0001 | 3.32 | 5.2 | 12.93 | 2.54 | 0 | 5.2 | 9.49 | 1.69 | 13.36 | 9.19 | 2.78|
| brca_0002 | 5.54 | 6.91 | 11.45 | 2.69 | 0 | 9.91 | 6.95 | 4.85 | 13.91 | 9.9 | 3.92|
| brca_0003 | 6.32 | 10.83 | 13.19 | 4.51 | 0 | 10.55 | 12.45 | 2.73 | 14.9 | 10.69 | 4.04|
| . . .  | . . .  | . . .  | . . . | . . .  | . . .  | . . .  | . . .  | . . . | . . .  | . . .  | . . . |
| brca_0931 | 5.23 | 6.75 | 13.31 | 4.21 | 0 | 7.06 | 10.48 | 3.61 | 14.42 | 10.66 | 4.3|
| brca_0932 | 5.18 | 4.78 | 13.33 | 4.43 | 0 | 5.8 | 8.24 | 6.47 | 14.79 | 10.31 | 4.87|

  </p>
</details>


<details><summary>Discretized data example (click)</summary>
<p>


 | sampleID |ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| brca_0001 | -1 | 0 | 1 | -1 | -1 | 0 | 0 | -1 | 1 | 0 | -1|
| brca_0002 | 0 | 0 | 1 | -1 | -1 | 0 | 0 | 0 | 1 | 0 | 0|
| brca_0003 | 0 | 1 | 1 | 0 | -1 | 1 | 1 | -1 | 1 | 1 | 0|
| . . .  | . . .  | . . .  | . . . | . . .  | . . .  | . . .  | . . .  | . . . | . . .  | . . .  | . . . |
| brca_0931 | 0 | 0 | 1 | 0 | -1 | 0 | 1 | 0 | 1 | 1 | 0|
| brca_0932 | 0 | 0 | 1 | 0 | -1 | 0 | 0 | 0 | 1 | 1 | 0|
    </p>
</details>



<details><summary>Profile data example (click)</summary>
<p>
  
|Level |ADAMTSL5 | ADIPOQ | AGRN | AMBP | AMELX | ANGPTL4 | AREG | BDNF | BGN | BMP1 | BMP2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |--- |
| Low | 0.1226 | 0.2206 | 0 | 0.5712 | 0.9975 | 0.0222 | 0.07 | 0.6815 | 0 | 0 | 0.1679|
| Medium | 0.8774 | 0.5062 | 0.0272 | 0.4247 | 0.0025 | 0.8568 | 0.7523 | 0.3177 | 0.0091 | 0.7407 | 0.8288|
| High | 0 | 0.2733 | 0.9728 | 0.0041 | 0 | 0.121 | 0.1778 | 0.0008 | 0.9909 | 0.2593 | 0.0033|
  
</p>
</details>

## Network estimation

The matrinet_estimate, takes matrigraph and matridata as an input and estimates network weights of different type for each element in the matrigraph edgelist. The default network weigts (that can be customized) are estimated from different data types as follows:

| Datatype | Default metric | matrisome_THPA | matrisome_TCGA |matrisome_GTEx |
  | --- | --- | --- | --- | --- |
  |  Continuous data | Correlation| Not available |Available |Available|
  | Discrete data | Mutual information|Not available |Available|Available|
  | Profile data | Jensen-Shannon Divergence |Available |Available|Available|


<details><summary>Click to see an output example</summary>
<p>

|Gene1 | Gene2 | Family 1 | Family 2 |  Correlation | Mutual information | Jensen-Shannon Divergence | 
| --- | --- | --- |--- | --- | --- | --- |
| A2M | IL10 |ECM REGULATORS | SECRETED FACTORS | 0.03 | 0.4 | 0.11|
| A2M | MFAP2 | ECM REGULATORS | ECM GLYCOPROTEINS | 0.21 | 0.04 | 0.45|
| . . . | . . . | . . . |. . . | . . . | . . .| . . . |
| COCH | COL2A1 |ECM GLYCOPROTEINS | COLLAGENS | 0.25 | 0.17 | 0.16|
  
  </p>
</details>

The weights are then added as new columns to the inital matrigraph edgelist (as shown above). This allows for a more thorough study of gene-gene interactions because all of them represent distinct types of pairwise dynamic between genes. Note that only Jensen-Shannon metric is available for the THPA data since only expression profile data is available.

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
discretization_levels <- c(log2(10+1), log2(1000+1))

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

## Visualization (PLACEHOLDER)

Given the estimated network structures, users could apply a wide range of existing package, such as igraph, qgraph, and visnetwork, to create visual representations of estimated network structures with the following conversion:

```r

library(igraph)
library(qgraph)
library(visnetwork)

g <- graph_from_data_frame(d = matrinet_TCGA$brca$edge_df,
                           vertices = matrinet_TCGA$brca$node_df)

visnet <- toVisNetworkData(g)

visnet$edges$value <- visnet$edges$JensenShannon_P

visNetwork(visnet$nodes, visnet$edges) %>%
  visIgraphLayout(randomSeed = 123) %>%
  visNodes(size = 10) %>%
  visOptions(highlightNearest = list(enabled = T, hover = T), 
             nodesIdSelection = T)


#Convert the output matrigraph objects to weighted adjacency matrices
weighted_adjmat <- matrigraph_to_adjacency(output_matrigraph = matrinet_TCGA)
  qgraph::qgraph(weighted_adjmat$prad, edge.color = "dodgerblue4", curve = -0.2, curveAll = TRUE)

```



_For more examples, please refer to the [Documentation]()_

<p align="right">(<a href="#top">back to top</a>)</p>
