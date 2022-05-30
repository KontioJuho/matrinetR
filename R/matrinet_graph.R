


#' @title Create matrigraph object
#' @description Create the initial skeleton of matrigraph object for storing network data.
#' @param matridata The output from matrinet_data() function or any list of group (cancer) specific data-frames containing node covariates, e.g., gene or protein expression data. Extracted automatically from the dataframe by the column names of prior_topology object.
#' @param add_node_df A data-frame for custom node attributes that are common for each group (e.g. protein/gene family).
#' @param add_edge_df A data-frame for custom edge attributes that are common for each group (e.g. gene-gene interaction data source).
#' @param prior_topology An adjacency matrix providing a fixed skeleton for the network. The default structure is given by the matrixDB interaction data.
#'
#' @return Returns a list of group (cancer) specific matrigraph objects, with 1) node_df, 2) edge_df and 3) summary dataframes. Matrigraph object is meant for storing network estimation results and custom node/edge attributes.
#' @importFrom igraph graph_from_adjacency_matrix
#' @importFrom  igraph get.edgelist
#' @import dplyr
#' @examples print(c("matrinet_graph(matridata, prior_topology)"))
#' @export


matrinet_graph <- function(matridata, prior_topology, add_node_df = NULL, add_edge_df = NULL){
  #### STEP 1 #####
  network_object <- lapply(matridata[[1]], function(x){


    ### STEP 2 #####
    x <- vector(mode = "list", length = 3)
    names(x)<- c("node_df", "edge_df", "summary")


    ### STEP 3 #####
    igraph_object <- igraph::graph_from_adjacency_matrix(prior_topology,
                                mode = "undirected")
      matrisome_edgelist <- igraph::get.edgelist(igraph_object)
    colnames(matrisome_edgelist) <- c("Gene1", "Gene2")

    x$edge_df  <- as.data.frame(matrisome_edgelist)
    x$node_df <- as.data.frame("Genenames" = colnames(prior_topology))

    if(!(is.null(add_node_df))){

      x$node_df <- cbind(x$node_df, add_node_df)

    }

    if(!(is.null(add_edge_df))){

      x$edge_df <- cbind(x$edge_df, add_edge_df)

    }


    x
  })
}
