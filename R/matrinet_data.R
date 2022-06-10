#' @title Test title
#' @param data	 A dataframe or list of group (cancer) dataframes containing target gene variables as column vectors. Additional variables (e.g. sampleIDs) could be included, target genes/proteins are extracted automatically from the dataframe by the column names of prior_topology object
#' @param quantiles At simplest a numeric vector with two values to discretize gene expression levels. Can be also a list of different levels for each gene and cancer type.
#' @param genenames A character vector of target gene names
#'
#' @examples print("matrinet_data(datalist, quantiles, genenames)")
#' @return A matridata object that can be used as an input for matrinet_estimate function.
#' @export


matrinet_data <- function(data, quantiles, genenames){




    lapply(data, function(datax) {

      datax %>%
        dplyr::select(genenames)



    }) -> datalist



if(is.list(quantiles)){

  continuous_data <- lapply(datalist, function(datalist_tumor){
    datalist_tumor %>%
      dplyr::select(genenames)
  })

  discrete_data <- continuous_data
  for(i in 1:length(discrete_data)){
    for(j in colnames(discrete_data[[i]])){

      discrete_data[[i]][,j] <- as.numeric(cut(datalist[[i]][,j],
                                               breaks = c(-Inf, as.vector(quantiles[[i]][,j]), Inf))) - 2


    }}
  profile_data <- discrete_data

  values <- c(-1,0,1)
  for(i in 1:length(discrete_data)){
    profile_data[[i]] <- matrix(0, ncol = ncol(discrete_data[[i]]), nrow = 3)
    colnames(profile_data[[i]]) <- colnames(discrete_data[[i]])
    rownames(profile_data[[i]]) <- c("low", "medium", "high")


    for(m in colnames(profile_data[[i]])){

      for(k in 1:3){

        profile_data[[i]][k,m] <- length(which(discrete_data[[i]][,m] == values[k]))/nrow(discrete_data[[i]])

      }

    }
  }
}

  if(is.atomic(quantiles)){


    continuous_data <- lapply(datalist, function(datalist_tumor){
      datalist_tumor %>%
        dplyr::select(genenames)
    })

    discrete_data <- continuous_data
    for(i in 1:length(discrete_data)){
      for(j in colnames(discrete_data[[i]])){

        discrete_data[[i]][,j] <- as.numeric(cut(datalist[[i]][,j],
                                                 breaks = c(-Inf, quantiles, Inf))) - 2


      }}
    profile_data <- discrete_data

    values <- c(-1,0,1)
    for(i in 1:length(discrete_data)){
      profile_data[[i]] <- matrix(0, ncol = ncol(discrete_data[[i]]), nrow = 3)
      colnames(profile_data[[i]]) <- colnames(discrete_data[[i]])
      rownames(profile_data[[i]]) <- c("low", "medium", "high")


      for(m in colnames(profile_data[[i]])){

        for(k in 1:3){

          profile_data[[i]][k,m] <- length(which(discrete_data[[i]][,m] == values[k]))/nrow(discrete_data[[i]])

        }

      }
    }


  }

  list("continuous" = continuous_data,
       "discrete" = discrete_data,
       "profile" = profile_data)
}
