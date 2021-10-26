#' Create labels of variables
#'
#' Labels the variables from the data dictionary
#' @param data The dataset to create the factors
#' @param dictionary The data dictionary to pull variable labels
#'
#' @return tibble
#' @export
#'
#' @examples
#' create_labels(datalabels::sample_data, datalabels::clean_dictionary)

create_labels <- function(data, dictionary) {

  longvarlabels <- vector("list")

  myvars <- intersect(names(data), dictionary[['question_id']])

  for (var in myvars){

    varlbl <- dplyr::filter(dictionary, question_id== var) |>
      dplyr::select(label) |> dplyr::pull()

    if (length(varlbl) == 1){
      attr(data[[var]], "label") <- varlbl

    } else {

      longvarlabels[[var]] <- varlbl # list


    }

  }

  data

}
