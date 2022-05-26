

#' Initializing input dataframes for the matrinetR package
#'
#' @param cancers A character vector of cancer abbreviations. The corresponding datasets are extracted from the TCGA and GTEx objects.
#' @param TCGA A list of cancer specific TCGA datasets named by the TCGA abbreviation standards (lowercase symbols).
#' @param GTEx A list of cancer specific GTEx datasets named by the TCGA abbreviation standards (lowercase symbols).
#' @param cohort Select a cohort
#' @param subset_genes A character vector representing the names of genes to be extracted
#'
#' @examples print("matrinet_init()")
#' @return Initialized data object to be used as an input for the matrinet_data function.
#' @export
#'
    matrinet_init <- function(cancers = c("laml", "ov", "prad", "brca"),
                              TCGA,
                              GTEx,
                              cohort = "TCGA",
                              subset_genes){
  
  
  if(cohort == "TCGA"){
    
    
      lapply(TCGA[cancers], function(datax) {
        
        datax %>%
          dplyr::select(subset_genes)
        
        
        
      }) -> output_data
    
    
    return(output_data)
  }
  
  if(cohort == "GTEx"){
    
    
      lapply(GTEx[cancers], function(datax) {
        
        datax %>%
          dplyr::select(subset_genes) -> dat
        
        dat
        
        
        
      }) -> output_data
    
    
    
    
    return(output_data)
    
  }
  
  
  
}