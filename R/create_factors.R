#' Create factors from dictionary
#'
#'Creates a factor variables from the data dictionary
#' @param data The dataset to create the factors
#' @param dictionary The data dictionary to pull value labels and levels
#'
#' @return tibble
#' @export
#'
#' @examples
#' create_factors(datalabels::sample_data, datalabels::clean_dictionary)
create_factors <- function(data, dictionary){

  factor_vars <- dictionary |>
    dplyr::filter(type %in% c("Select")) |>
    dplyr::select(question_id) |> dplyr::pull()


  unmatched <-  vector("list") # Capture factors with fewer levels compared
  # to the labels


  factor_var <- intersect(factor_vars, names(data))

  for (var in factor_var){

    # Extract levels of factor variable

    var_levels <-  dictionary |> dplyr::filter(question_id == var) |>
      dplyr::select(option_values) |> dplyr::pull()

    var_levels <- stringr::str_trim(unlist(strsplit(var_levels, split = ",")))

    # Extract the labels of factor variable

    var_labels <-  dictionary |> dplyr::filter(question_id == var) |>
      dplyr::select(option_labels ) |> dplyr::pull()

    var_labels <- unlist(strsplit(var_labels, split = ","))


    # Check whether the number of values and value labels match

    if (length(var_levels) != length(var_labels)){
      unmatched[[var]] <<- var_levels

    } else {
      data[[var]] <- factor(data[[var]],
                            levels = var_levels,
                            labels = var_labels)

    }


  }

  data

}
