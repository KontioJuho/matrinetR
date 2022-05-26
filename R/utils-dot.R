

#' Dot operator
#'
#'
#' @name %dot%
#' @rdname dot
#' @keywords internal
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs(.,rhs2)
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
#' @export

