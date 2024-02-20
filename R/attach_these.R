attach_these <- function(required_packages) {

  # check for packages
  if (!is.character(required_packages)) {

    stop("The defined packages must me a character vector.")

  } else {

    # install required packages that are not installed yet:
    new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

    if(length(new_packages)) {

      install.packages(new_packages)

    }

    # load required packages:
    invisible(lapply(required_packages, library, character.only = T))

    # message
    message(paste0("Success: The following packages were attached successfully: ", required_packages))

  }

}
