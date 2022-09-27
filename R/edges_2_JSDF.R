#' Map an edgelist to a sample-level JS dataframe
#'
#' @param discreteDF A single discrete matridata object
#' @param edgelist Matridata edgelist with two columns 
#'
#' @return A dataframw with nrow(edgelist) columns and nrow(discreteDF) rows. 
#' @export 
#'
#' @examples NULL
edges_2_JSDF <- function(discreteDF =  scTHPA_matridata$discrete$`adipose tissue_fibroblasts`,
                         edgelist=  scTHPA_matrigraph$`adipose tissue_fibroblasts`$edge_df){
  
  
  
  data <- (discreteDF + abs(min(discreteDF, na.rm = TRUE)))/
    (max(discreteDF, na.rm = TRUE) + max(discreteDF, na.rm = TRUE))
  
  
  
  difference <- paste(paste("data$", edgelist[,1], sep = ""),
                      "-",
                      paste("data$", edgelist[,2], sep = ""), sep = "")
  
  colMaps <- paste("1 - abs(", difference, ")", sep = "")
  
  eval(str2expression(paste("dataframe <- data.frame(",
                            paste(colMaps, collapse = ", "), ")",  sep = "")))
  colnames(dataframe) <- gsub("data\\$", "", difference)
  
  return(dataframe)
  
}




