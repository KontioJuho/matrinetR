

#' Identify available, matching and valid target genes from TCGA and GTEx cohorts
#'
#' @param genenames A character vector of target gene names
#' @param cancers A character vector of TCGA abbreviations (TCGA) to extract cancer datasets of interest.    
#' @param remove.allNA TRUE (default) or FALSE denoting if gene/proteins having all values as NA in any dataframe (e.g. cancer specific) should be removed. Default is TRUE and problematic gene/protein columns will be removed consistently from all dataframes. 
#' @param TCGA A list of TCGA dataframes
#' @param GTEx A list of GTEx dataframes
#' @param cohort  Available and valid genes could be checked from the built-in TCGA or GTEx cohorts individually ("TCGA" or "GTEx") or simultaneously (c("TCGA", "GTEx")).
#'
#'@examples print("available_genes(genenames = ECMgenenames)")
#' @return Gene or protein names available in both GTEx and TCGA cohorts for all cancers. If remove.allNA is true, also genes/proteins with all values as NA in any cancer dataframe is are removed.  
#' @import purrr
#' @export
#'
available_genes <- function(genenames,
                            TCGA,
                            GTEx,
                            cancers,
                            remove.allNA = TRUE,
                            cohort = c("TCGA", "GTEx")){
  
  
  cancer_set <- cancers
  if(all(cohort == c("TCGA", "GTEx"))){
    
    common_varnames <- intersect(reduce(lapply(GTEx[cancer_set], function(x) {colnames(x)}), intersect),
                                 reduce(lapply(TCGA[cancer_set], function(x) {colnames(x)}), intersect))
    
    common_genenames <- intersect(genenames,
                                  common_varnames)
    
    if(remove.allNA == TRUE){
      
      
      
      reduce(lapply(TCGA[cancer_set], function(data){
        
        data %>%
          dplyr::select(common_genenames) %>%
          purrr::keep(~all(is.na(.x))) %>%
          colnames() -> allNA.genes
        
        
      }), c) %>% unique() -> allNA.genes_TCGA
      
      reduce(lapply(GTEx[cancer_set], function(data){
        
        data %>%
          dplyr::select(common_genenames) %>%
          purrr::keep(~all(is.na(.x))) %>%
          colnames() -> allNA.genes
        
        
      }), c) %>% unique() -> allNA.genes_GTEx
      
      common_genenames_TCGA <- setdiff(common_genenames, allNA.genes_TCGA)
      common_genenames_GTEx <- setdiff(common_genenames, allNA.genes_GTEx)
      
      common_genenames <- intersect(common_genenames_TCGA, common_genenames_GTEx)
      
    }
    
    
    return(common_genenames)
    
    
  }
  
  if(cohort == "TCGA"){
    
    common_varnames <- reduce(lapply(TCGA[cancer_set], function(x) {colnames(x)}), intersect)
    
    common_genenames <- intersect(genenames,
                                  common_varnames)
    
    if(remove.allNA == TRUE){
      
      
      
      reduce(lapply(TCGA[cancer_set], function(data){
        
        data %>%
          dplyr::select(common_genenames) %>%
          purrr::keep(~all(is.na(.x))) %>%
          colnames() -> allNA.genes
        
        
      }), c) %>% unique() -> allNA.genes_TCGA
      
      
      
      common_genenames <- setdiff(common_genenames, allNA.genes_TCGA)
      
    }
    
    
    return(common_genenames)
    
  }
  
  
  if(cohort == "GTEx"){
    
    common_varnames <- reduce(lapply(GTEx[cancer_set], function(x) {colnames(x)}), intersect)
    
    common_genenames <- intersect(genenames,
                                  common_varnames)
    
    if(remove.allNA == TRUE){
      
      
      
      reduce(lapply(GTEx[cancer_set], function(data){
        
        data %>%
          dplyr::select(common_genenames) %>%
          purrr::keep(~all(is.na(.x))) %>%
          colnames() -> allNA.genes
        
        
      }), c) %>% unique() -> allNA.genes_GTEx
      
      
      
      common_genenames <- setdiff(common_genenames, allNA.genes_GTEx)
      
    }
    
    return(common_genenames)
    
  }
  
  
}