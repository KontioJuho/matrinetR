#' Adjacency matrix representation of the matrisome interaction data from matrixDB
#'
#' A dataset containing the edge list of matrisome interactions
#'  and additional annotations. The variables are defined as follows:
#'
#' @format A data frame with 967 rows and 6 variables:
#' \itemize{
#'   \item gene.x and gene.y: Each row-wise pair of gene.x and gene.y represents a known matrisome interaction
#'   \item family.x and family.y: The knowledge-based annotations of gene.x and gene.y specific families within the matrisome
#'   \item category.x and category.y: The MsigDB based matrisome categories for gene.x and gene.y
#' }
"matrixDB_adjacency"
