% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/matrinet_data.R
\name{matrinet_data}
\alias{matrinet_data}
\title{Test title}
\usage{
matrinet_data(data, quantiles, genenames)
}
\arguments{
\item{data}{A dataframe or list of group (cancer) dataframes containing target gene variables as column vectors. Additional variables (e.g. sampleIDs) could be included, target genes/proteins are extracted automatically from the dataframe by the column names of prior_topology object}

\item{quantiles}{At simplest a numeric vector with two values to discretize gene expression levels. Can be also a list of different levels for each gene and cancer type.}

\item{genenames}{A character vector of target gene names}
}
\value{
A matridata object that can be used as an input for matrinet_estimate function.
}
\description{
Test title
}
\examples{
print("matrinet_data(datalist, quantiles, genenames)")
}
