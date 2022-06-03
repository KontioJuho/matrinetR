#' Plot neighborhood curves
#'
#' @param matrigraph_output  The matrigraph output
#' @param center_gene Name of the center gene
#' @param weights Weight type
#' @param prior_topology Prior network topology consisting of genes in the matrigraph_output
#'
#' @return Neighborhood curve plot
#' @export
#'
#' @examples print("1")
#' @importFrom ggplot2 ggplot
neighborhood_plot <- function(matrigraph_output, prior_topology =  matrixDB_adjacency[valid_genes, valid_genes],
                              center_gene = "SDC1",weights = "MI_D"){
  adjmats <- matrigraph_to_adjacency(matrigraph_output, weights_by = weights)

  Genes <- NULL

  t <- reduce(lapply(adjmats, function(data){

    refmat <- prior_topology
    data[names(which(refmat[,center_gene] != 0)), center_gene]



  }), cbind)

  colnames(t) <- names(adjmats)

  t <- data.frame(Genes = rownames(t), t)
  rownames(t) <- NULL
  t

  t %>%
    tidyr::pivot_longer(!Genes, names_to = "Dataset", values_to = "Value") %>%
    as.data.frame() -> dat

  dat %>%
    ggplot(aes(x = Genes, y = Value,
               color = Dataset, group = Dataset)) +

    # scale_color_brewer() +
    geom_smooth(se = FALSE, na.rm = TRUE) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7)) +
    xlab(paste("Neighborhood genes of", center_gene, sep = " ")) +
    ylab("Edge-weights")

}
