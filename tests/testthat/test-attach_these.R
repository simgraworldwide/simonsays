# test_that("attach_these() installs all defined packages (if available on CRAN)", {
#
#   # define packages
#   required_packages <- c("janitor", "httr2")
#
#   # call function
#   attach_these(required_packages)
#
#   # unload the installed and freshly loaded packages
#   for (i in length(required_packages)) {
#     unloadNamespace(required_packages[i])
#   }
#
#   # check if the packages are installed
#   testthat::expect_equal(
#     required_packages %in% installed.packages()[, "Package"],
#     rep(TRUE, length(required_packages))
#   )
#
# })


test_that("attach_these() prints error if the defined packages are not a character vector", {

  testthat::expect_error(attach_these(1))

})
