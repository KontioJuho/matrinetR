
#' Matrinet network estimation function
#'
#' @param matrigraph Output object from the matrinet_graph function
#' @param matridata Output object from the matrinet_data function
#'
#' @examples print(c("matrinet_estimate(matrigraph, matridata)"))
#' @return Matrigraph object with added results from the estimated networks
#' @import infotheo
#' @import philentropy
#' @export

matrinet_estimate <- function(matrigraph,
                              matridata){




  for(cancer in names(matrigraph)){


    matridata_D <- matridata$discrete[[cancer]]
    matridata_C <- matridata$continuous[[cancer]]
    matridata_P <- matridata$profile[[cancer]]


    ########################## DISCRETE MODEL ######################################


    ################## EDGE-DATA ########################

    matrigraph[[cancer]]$edge_df$diff_D <- apply(matrigraph[[cancer]]$edge_df, 1, function(x){

      mean(abs(matridata_D[,x[1]] - matridata_D[,x[2]]))})



    matrigraph[[cancer]]$edge_df$prod_D <- apply(matrigraph[[cancer]]$edge_df, 1, function(x){

      mean(matridata_D[,x[1]]*matridata_D[,x[2]])})



    matrigraph[[cancer]]$edge_df$MI_D  <- apply(matrigraph[[cancer]]$edge_df, 1,function(x){

      infotheo::mutinformation(matridata_D[,x[1]],
                     matridata_D[,x[2]]) })


    ################## NODE-DATA ########################

    matrigraph[[cancer]]$node_df$updown_D <- apply(matrigraph[[cancer]]$node_df, 1, function(x){

      mean(abs(matridata_D[,x[1]]))})



    ################################################################################














    ############# CONTINUOUS MODEL ############


    matrigraph[[cancer]]$edge_df$cor_C <- apply(matrigraph[[cancer]]$edge_df, 1, function(x){

      if(stats::var(matridata_C[,x[1]], na.rm = TRUE) == 0 |
         stats::var(matridata_C[,x[2]], na.rm = TRUE) == 0 ){

        return(0)

      }else{
        stats::cor(matridata_C[,x[1]], matridata_C[,x[2]])}
    })





    ############# PROFILE MODEL ############


    matrigraph[[cancer]]$edge_df$JensenShannon_P <- apply(matrigraph[[cancer]]$edge_df, 1, function(x){

      gene1 <- as.vector(table(factor(matridata_D[,x[1]], levels = c(-1,0,1))))
      gene2 <- as.vector(table(factor(matridata_D[,x[2]], levels = c(-1,0,1))))

      a <- philentropy::JSD(rbind(gene1, gene2), unit = "log2")

      10/(10+a)



    })
  }
  return(matrigraph)
}
