#' TCGA matrisome gene expression and clinical data
#'
#' A list of cancer specific datasets containing clinical, molecular subtype, and matrisome gene-expression data downloaded from UCSC Xenahub platform's PanCancer Atlas \url{https://xenabrowser.net/datapages/} 
#'  
#'
#' @format A list of 24 cancer-specific dataframes each of which consisting of  394 variables (columns):
#' \itemize{
#'   \item Curated clinical data. Xenahub dataset ID: Survival_SupplementalTable_S1_20171025_xena_sp
#'   \item Molecular subtype data (): Xenahub dataset ID: TCGASubtype.20170308.tsv
#'   \item Batch effect normalized and log2(norm_value+1) transformed matrisome mRNA data: Xenahub dataset ID: EB++AdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.xena
#' }
"matrisome_TCGA"