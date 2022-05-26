
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
## Gene-expression data across various tumor and normal tissue samples 

MatrinetR data repository contains pre-processed gene-expression and clinical data for each tumor from The Cancer Genome Atlas (TCGA) and corresponding normal (GTEx) tissues from the Genotype-Tissue Expression (GTEx) database. 

```r
library(matrinetR)

?matrisome_TCGA
?matrisome_GTEx
?matrixDB

```

_For more examples, please refer to the [Documentation]()_

<p align="right">(<a href="#top">back to top</a>)</p>
