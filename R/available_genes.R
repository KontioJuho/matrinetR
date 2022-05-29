

#' Identify available, matching and valid target genes from TCGA and GTEx cohorts
#'
#' @param target_genes A character vector of target gene names
#' @param data A dataframe of list of dataframes.
#
#'@examples print("available_genes(genenames = ECMgenenames)")
#' @return Gene or protein names available in both GTEx and TCGA cohorts for all cancers. If remove.allNA is true, also genes/proteins with all values as NA in any cancer dataframe is are removed.
#' @import purrr
#' @export
#'
available_genes <- function(target_genes,
                            data){

  if(is.list(data)){
    common_genenames_data <- purrr::reduce(lapply(data, function(x) {colnames(x)}), intersect)

    common_genenames <- intersect(common_genenames_data, target_genes)
    noncommon_genenames <- setdiff(target_genes, common_genenames)




    purrr::reduce(lapply(data, function(genes){

      genes %>%
        dplyr::select(common_genenames) -> genedata

      na_percentage <- colMeans(is.na(genedata))

      colnames(genedata)[which(na_percentage < 0.1)]


    }), intersect) %>% unique() -> valid_NA_0.1




    purrr::reduce(lapply(data, function(genes){

      genes %>%
        dplyr::select(common_genenames) -> genedata

      na_percentage <- colMeans(is.na(genedata))

      colnames(genedata)[which(na_percentage == 0)]


    }), intersect) %>% unique() -> valid_NA_complete





  }



  if(is.data.frame(data) | is.matrix(data)){


    common_genenames <- intersect(colnames(data), target_genes)
    noncommon_genenames <- setdiff(target_genes, common_genenames)


    data%>%
      dplyr::select(common_genenames) -> genedata

    na_percentage <- colMeans(is.na(genedata))

    valid_NA_complete <- colnames(genedata)[which(na_percentage == 0)]
    valid_NA_0.1 <- colnames(genedata)[which(na_percentage < 0.1)]





  }

  list("available_genes" = common_genenames,
       "missing_genes" = noncommon_genenames,
       "available_zero_NAs" = valid_NA_complete,
       "available_<10%_NAs" = valid_NA_0.1)









}
