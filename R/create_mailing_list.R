#' Create Mailing List
#'
#' @param path Path to an xlsx file that contains email-addresses in multiple sheets. The output file will be written into the same directory as "mailverteiler_YYYY-MM-DD.xlsx".
#' @param sheets Index numbers or names of the sheets that contain email address data.
#' @param columns Name of the columns in the sheets that contain email address data.
#'
#' @return Creates a file "mailverteiler_YYYY-MM-DD.xlsx"
#' @export
#'
#' @examples
#' create_mailing_list <- function(path = "/home/file-server/09_WA/08_Div/01_Adressen/Adressen_Gemeinden_Parteien.xlsx", sheets = c(2, 3), columns = c("Email", "Email"))
create_mailing_list <- function(
    path = "/home/file-server/09_WA/08_Div/01_Adressen/Adressen_Gemeinden_Parteien.xlsx",
    sheets = c(2, 3),
    columns = c("Email", "Email")
    ) {

  # stop if the number of sheets and columns are not the same
  if (length(sheets) != length(columns)) {

    stop("The number of sheets is not equal to the number of columns.")

  }

  # create empty data frame
  emails_raw <- data.frame()

  # loop over the number of sheets
  for (i in 1:length(sheets)) {

    # define the email-addresses of the sheet
    additional_addresses <- openxlsx::read.xlsx(path, sheet = sheets[i])[columns[i]]

    # adjust column name to match
    colnames(additional_addresses) <- "email"

    # add the addresses to the data frame
    emails_raw <- rbind(emails_raw, additional_addresses)

  }

  # turn all addresses to lower case
  emails_raw$email <- tolower(emails_raw$email)

  # remove duplicates
  emails <- data.frame(email = unique(emails_raw$email))

  # write file into same folder as defined
  openxlsx::write.xlsx(emails, paste0(gsub("/[^/]*$", "/mailverteiler_", path), Sys.Date(), ".xlsx"), overwrite = TRUE)

}
