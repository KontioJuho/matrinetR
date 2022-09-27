#' Plot neighborhood curves
#'
#' @param matrigraph_output  The matrigraph output
#' @param center_gene Name of the center gene
#' @param weights Weight type
#' @param smoothness Curve smoothness
#' @param prior_topology Prior network topology consisting of genes in the matrigraph_output
#'
#' @return Neighborhood curve plot
#' @export
#'
#' @examples print("1")
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 geom_smooth
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 element_line
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
neighborhood_plot <- function(matrigraph_output, prior_topology,
                              center_gene = "SDC1",weights = "MI_D",
                              smoothness = 0.5){
  adjmats <- matrigraph_to_adjacency(matrigraph_output, weights_by = weights)


  t <- reduce(lapply(adjmats, function(data){

    diag(data) <- 0
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


  theme_neighborhood <- ggplot2::theme(plot.background = ggplot2::element_rect(fill = "#DEE9EC"),
                              panel.background = ggplot2::element_rect(fill = "#F3F9FA"),
                              panel.grid.major=ggplot2::element_line(colour="#F2F2F2", size = 0.5),
                              plot.title = ggplot2::element_text(family = "Helvetica", size = (12)),
                              legend.title = ggplot2::element_blank(),
                              axis.text.x = ggplot2::element_text(size = 7),
                              legend.text =  ggplot2::element_text(face = "italic", colour = "steelblue4", family = "Helvetica"),
                              axis.title = ggplot2::element_text(face = "italic",family = "Helvetica", size = (10), colour = "steelblue4"),
                              axis.text = ggplot2::element_blank()
  )
  dat %>%
    ggplot2::ggplot(ggplot2::aes(x = Genes, y = Value,
               color = Dataset, group = Dataset)) +

    # scale_color_brewer() +
    ggplot2::geom_smooth(se = FALSE, na.rm = TRUE, span = smoothness) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1, size = 7)) +
    theme_neighborhood +
    ggplot2::xlab(paste("Neighborhood genes of", center_gene, sep = " ")) +
    ggplot2::ylab("Edge-weights")

}
