#' Clean the data dictionary
#'
#' Cleans the raw data dictionary
#' @param data Data dictionary to clean to clean
#'
#' @return tibble
#' @export
#'
#' @examples
#' dict_clean(data = datalabels::raw_dictionary)
dict_clean <- function(data){
  data |>
    dplyr::filter(!stringr::str_detect(question_id, "Module|MODULE")) |>
    dplyr::filter(!type %in%
                    c("Trigger", "Group", "Repeat", "FieldList")) |>
    dplyr::mutate(option_labels = stringr::str_replace(option_labels, " \\s*\\([^\\)]+\\)", "")) |>
    dplyr::mutate(option_labels = stringr::str_replace_all(option_labels, "\\n", "#")) |>
    dplyr::mutate(option_labels = stringr::str_remove_all(option_labels, ",")) |>
    dplyr::mutate(option_labels = stringr::str_replace_all(option_labels, "#", ","),
           label = stringr::str_replace(label, " \\s*\\([^\\)]+\\)", "")) |>
    dplyr::mutate(question_id = tolower(question_id),
                  question_id = stringr:: str_extract(question_id, "[^\\/]*$")) |>
    dplyr::mutate(label = ifelse(label == "[Unknown]", question_id, label))


}
