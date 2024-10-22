#' Create Mailing List
#'
#' @param path Path to an xlsx file that contains email-addresses in multiple sheets. The output file will be written into the same directory as "mailverteiler_YYYY-MM-DD.xlsx".
#' @param sheets Index numbers or names of the sheets that contain email address data.
#' @param columns Name of the columns in the sheets that contain email address data.
#' @param filter_cols Additional Columns to be exported that can be filtered manually after the export.
#'
#' @return Creates a file "mailverteiler_YYYY-MM-DD.xlsx"
#' @export
#'
#' @examples
#' create_mailing_list <- function(path = "/home/file-server/09_WA/08_Div/01_Adressen/Adressen_Gemeinden_Parteien.xlsx", sheets = c(2, 3), columns = c("Email", "Email"))
create_mailing_list <- function(
    path = "/home/file-server/09_WA/08_Div/01_Adressen/Adressen_Gemeinden_Parteien.xlsx",
    sheets = c(2, 3),
    columns = c("Email", "Email"),
    filter_cols = NULL
    ) {

  # stop if the number of sheets and columns are not the same
  if (length(sheets) != length(columns)) {
    stop("The number of sheets must be equal to the number of columns.")
  }

  # stop if the number of filter columns and sheets are not the same
  if (!is.null(filter_cols) & length(filter_cols) != length(sheets)) {
    stop("If you want to set a filter, the number of filter columns must be equal to the number of sheets.")
  }

  # create empty data frame
  emails_raw <- data.frame()

  # loop over the number of sheets
  for (i in 1:length(sheets)) {

    # read the sheet
    additional_addresses_raw <- openxlsx::read.xlsx(path, sheet = sheets[i])

    # check if the filter column (if defined) is in the sheet
    if (!is.null(filter_cols) & !filter_cols[i] %in% names(additional_addresses_raw)) {
      stop(paste0("The column ", filter_cols[i], " does not exist the ", i, ". sheet you defined."))
    }

    # drop irrelevant columns
    additional_addresses <- additional_addresses_raw |>
      subset(select = c(columns[i], filter_cols[i]))

    # adjust column name to match
    colnames(additional_addresses) <- c("email", "filter")[1:length(additional_addresses)]

    # add the addresses to the data frame
    emails_raw <- rbind(emails_raw, additional_addresses)
  }

  # turn all addresses to lower case
  emails_raw$email <- tolower(emails_raw$email)

  # remove duplicates
  emails <- unique(emails_raw)

  # write file into same folder as defined
  openxlsx::write.xlsx(emails, paste0(gsub("/[^/]*$", "/mailverteiler_", path), Sys.Date(), ".xlsx"), overwrite = TRUE)

}
