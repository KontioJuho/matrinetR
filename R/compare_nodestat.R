
#' Compare gene-specific network statistics across cancers
#'
#' @param matrigraph_summary The output of the matrigraph_summary function
#' @param genes A character vector of genenames
#' @param nodestat_type With the default usage of matrigraph_summary, this argument  could be "Betweenness", "Closeness", "Strength", or "ExpectedInfluence".
#'
#' @return A grouped barplot
#' @export
#'
#' @examples print("compare_nodestats(matrigraph_summary, genes)")
#' @importFrom tidyr pivot_longer
#' @importFrom plotly plot_ly
compare_nodestats <- function(matrigraph_summary,
                              genes,
                              nodestat_type = "Strength"){

  Genes <- NULL
  Value <- NULL
  Dataset <- NULL

  sumdata <- matrigraph_summary[[nodestat_type]]


  sumdata %>%
    filter(.,Genes %in% genes) %>%
    tidyr::pivot_longer(!Genes, names_to = "Dataset", values_to = "Value") %>%
    as.data.frame() -> dat



  plotly::plot_ly(
    data = dat,
    x = ~Genes,
    y = ~Value,
    type = "bar",
    color= ~Dataset
  )
}
