
#' Compare gene-specific network statistics across cancers
#'
#' @param matrigraph_summary The output of the matrigraph_summary function
#' @param genes A character vector of genenames
#' @param output oOutput type: either "ggplot" or "plotly"
#' @param nodestat_type With the default usage of matrigraph_summary, this argument  could be "Betweenness", "Closeness", "Strength", or "ExpectedInfluence".
#'
#' @return A grouped barplot
#' @export
#'
#' @examples print("compare_nodestats(matrigraph_summary, genes)")
#' @importFrom tidyr pivot_longer
#' @importFrom plotly plot_ly
#' @importFrom ggplot2 ggplot
#' @importFrom  ggplot2 scale_fill_brewer
#' @importFrom  ggplot2 geom_bar
#' @importFrom  ggplot2 theme
#' @importFrom  ggplot2 aes
#' @importFrom ggplot2 element_text
compare_nodestats <- function(matrigraph_summary,
                              genes,
                              nodestat_type = "Strength",
                              output = "plotly"){



  sumdata <- matrigraph_summary[[nodestat_type]]


  sumdata %>%
    filter(.,Genes %in% genes) %>%
    tidyr::pivot_longer(!Genes, names_to = "Dataset", values_to = "Value") %>%
    as.data.frame() -> dat

if(output == "ggplot"){



  ggplot2::ggplot(dat, ggplot2::aes(fill=Dataset, y=Value, x=Genes)) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1, size = 7)) +
    ggplot2::geom_bar(position="dodge", stat="identity") + theme_neighborhood + ggplot2::scale_fill_brewer(palette = "Paired")


  }else{

    plotly::plot_ly(
    data = dat,
    x = ~Genes,
    y = ~Value,
    type = "bar",
    color= ~Dataset
  )
}}
