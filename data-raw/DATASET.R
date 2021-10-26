## code to prepare `DATASET` dataset goes here

library(readxl)
library(dplyr)
library(stringr)
library(magrittr)

raw_dictionary <-
  read_excel("inst/exdata/raw_dictionary.xlsx",
             sheet = "DemoApp") %>%
  select(question_id, label, option_labels, option_values,
         type)

usethis::use_data(raw_dictionary, overwrite = TRUE,
                  compress = "xz")


clean_dictionary <- raw_dictionary |>
  filter(!stringr::str_detect(question_id, "Module|MODULE")) |>
  filter(!type %in%
                  c("Trigger", "Group", "Repeat", "FieldList")) |>
  mutate(option_labels = str_replace(option_labels, " \\s*\\([^\\)]+\\)", "")) |>
  mutate(option_labels = str_replace_all(option_labels, "\\n", "#")) |>
  mutate(option_labels = str_replace_all(option_labels, "\\r", "")) |>
  mutate(option_labels = stringr::str_remove_all(option_labels, ",")) |>
  mutate(option_labels = stringr::str_replace_all(option_labels, "#", ","),
                label = stringr::str_replace(label, " \\s*\\([^\\)]+\\)", "")) |>
  dplyr::mutate(question_id = tolower(question_id),
                question_id = stringr:: str_extract(question_id, "[^\\/]*$")) |>
  dplyr::mutate(label = ifelse(label == "[Unknown]", question_id, label))




usethis::use_data(clean_dictionary, overwrite = TRUE,
                  compress = "xz")


sample_data <- read_excel("inst/exdata/sample_data.xlsx",
                          na = "---")

clean_header <- function(data) {
  header <-  names(data)
  header_cleaned <- regmatches(header, regexpr("[^\\.]*$", header))
  header_cleaned<-str_replace_all(header_cleaned, "\\|","_")
  header_cleaned<-make.unique(header_cleaned)
  names(data) <- c(header_cleaned)
  names(data) %<>% str_replace_all("\\s","")
  names(data) <-  tolower(names(data))
  names(data)
}



names(sample_data) <- clean_header(sample_data)

# Convert the data.frame to tibble
sample_data <- as_tibble(sample_data)

sample_data <- sample_data %>%
  select(str_subset(names(sample_data), ".\\d"))


usethis::use_data(sample_data, overwrite = TRUE,
                  compress = "xz")


