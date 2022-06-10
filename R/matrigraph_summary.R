


#' Matrigraph summary by node.stat attribute
#'
#' @param output_matrigraph  The output of the matrinet_estimate function
#' @param metric A network weight type, i.e., one of the column names in matrigraph$edge.df
#'
#' @return A list of node summary specific dataframes where columns represents cancer specific statistics
#' @export
#'
#' @examples print(c("matrigraph_summary"))
#' @importFrom qgraph centrality_auto
matrigraph_summary <- function(output_matrigraph, metric){




  adjmat_list <-  matrigraph_to_adjacency(output_matrigraph, weights_by = metric)

  test <- lapply(adjmat_list, function(tumor){

    qgraph::centrality_auto(tumor)


  })


  by_nodestat <- vector(mode = "list", length = length(test[[1]]$node.centrality))
  names(by_nodestat) <- names(test[[1]]$node.centrality)


  for(nodestat_type in names(by_nodestat)){

    by_nodestat[[nodestat_type]] <- data.frame(Genes = rownames(test[[1]]$node.centrality))


    for(tumor in names(test)){


      by_nodestat[[nodestat_type]][tumor] <- test[[tumor]]$node.centrality[,nodestat_type]

    }

  }

  return(by_nodestat)





}


