
#' Convert matrigraphs to weighted adjacency matrices
#'
#' @param output_matrigraph The output from the matrinet_estimate function.
#' @param weights_by Column name in the matrigraph edge.df by which the network weigts are defined.
#'
#' @return A list of weighted adjacency matrices
#' @export
#'
#' @examples print("matrigraph_to_adjacency(output_matrigraph = matrinet_TCGA)")
#' @importFrom igraph graph_from_data_frame
#' @importFrom igraph get.adjacency
matrigraph_to_adjacency <- function(output_matrigraph, weights_by = "MI_D"){

lapply(output_matrigraph, function(x){

g <- igraph::graph_from_data_frame(d = x$edge_df,
                           vertices = x$node_df, directed = FALSE)
        igraph::get.adjacency(g, sparse = FALSE, attr=weights_by)
})

}


