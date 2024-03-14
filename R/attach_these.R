#' Attach (and if necessary, install) packages
#'
#' @param required_packages A character vector listing all packages the user wants to attach.
#'
#' @return A character vector.
#' @export
#'
#' @examples
#' required_packages <- c("rlang", "devtools")
attach_these <- function(required_packages) {

  # check for packages
  if (!is.character(required_packages)) {

    stop("The defined packages must me a character vector.")

  } else {

    # install required packages that are not installed yet:
    new_packages <- required_packages[!(required_packages %in% utils::installed.packages()[,"Package"])]

    if(length(new_packages)) {

      utils::install.packages(new_packages, repos = getOption("repos")[[1]])

    }

    # load required packages:
    invisible(lapply(required_packages, library, character.only = T))

    # message
    message("Success: The following packages were attached successfully: ", paste(required_packages, collapse=", "))

  }

}
