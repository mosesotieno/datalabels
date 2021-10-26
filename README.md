
# datalabels

Creating factors for five or ten variables is not so much demanding.
Neither is labelling four variables an uphill task. The problem begins
when you have well written data dictionary with 1000+ variables and you
wish to use it to create the variable labels and create factors from it.
This is where this package comes in handy. Assumption is made that you
have a data dictionary that you wish to map to a dataset.

## Installation

You can install this package as so:

``` r
# install.packages("devtools")
devtools::install_github("mosesotieno/datalabels")
```

## Example

To create factors and label the variables proceed as follows

``` r
library(datalabels)
## Load the sample data

mydata <- datalabels::sample_data
mydata
#>   a1 a2 a3 a4 b1   b2   b3 b4 d1      d2
#> 1  2 65  2  3  1    3    2  1  2    <NA>
#> 2  2 42  2  1  2 <NA> <NA>  1  2    <NA>
#> 3  1 45  1  2  1    2    3  2  1 1 3 4 6
#> 4  1 25  2  3  2 <NA> <NA>  1  1   4 5 6
#> 5  1 52  3  2  1    2    1  1  2    <NA>

## Load the data dictionary
mydictionary <- datalabels::clean_dictionary
mydictionary[, 1:3]
#>    question_id                                      label
#> 1           a1                                     Gender
#> 2           a2                                        Age
#> 3           a3                 Highest level of education
#> 4           a4                             Marital status
#> 5           b1                          Are you employed?
#> 6           b2                Indicate type of employment
#> 7           b3 How satisfied are you with your employment
#> 8           b4                    Do you have a business?
#> 9           d1           Have you ever programmed before?
#> 10          d2    Which of these languages have you used?
#>                                                                option_labels
#> 1                                                                Male,Female
#> 2                                                                       <NA>
#> 3                                            Tertiary,Secondary,Primary,None
#> 4                                            Single,Married,Divorced,Widowed
#> 5                                                                     Yes,No
#> 6                          Self employed,Government employee,Employed by NGO
#> 7  Very Disatisfied,Disatified,Moderately satisfied,Satisfied,Very Satisfied
#> 8                                                                     Yes,No
#> 9                                                                     Yes,No
#> 10                                    R,Python,C++,Ruby,Julia,PHP,Javascript

## Create the factors

mydata <- create_factors(mydata, mydictionary)
str(mydata)
#> tibble [5 x 10] (S3: tbl_df/tbl/data.frame)
#>  $ a1: Factor w/ 2 levels "Male","Female": 2 2 1 1 1
#>  $ a2: chr [1:5] "65" "42" "45" "25" ...
#>  $ a3: Factor w/ 4 levels "Tertiary","Secondary",..: 2 2 1 2 3
#>  $ a4: Factor w/ 4 levels "Single","Married",..: 3 1 2 3 2
#>  $ b1: Factor w/ 2 levels "Yes","No": 1 2 1 2 1
#>  $ b2: Factor w/ 3 levels "Self employed",..: 3 NA 2 NA 2
#>  $ b3: Factor w/ 5 levels "Very Disatisfied",..: 2 NA 3 NA 1
#>  $ b4: Factor w/ 2 levels "Yes","No": 1 1 2 1 1
#>  $ d1: Factor w/ 2 levels "Yes","No": 2 2 1 1 2
#>  $ d2: chr [1:5] NA NA "1 3 4 6" "4 5 6" ...

## Label the variables 
mydata <- create_labels(mydata, mydictionary)
str(mydata)
#> tibble [5 x 10] (S3: tbl_df/tbl/data.frame)
#>  $ a1: Factor w/ 2 levels "Male","Female": 2 2 1 1 1
#>   ..- attr(*, "label")= chr "Gender"
#>  $ a2: chr [1:5] "65" "42" "45" "25" ...
#>   ..- attr(*, "label")= chr "Age"
#>  $ a3: Factor w/ 4 levels "Tertiary","Secondary",..: 2 2 1 2 3
#>   ..- attr(*, "label")= chr "Highest level of education"
#>  $ a4: Factor w/ 4 levels "Single","Married",..: 3 1 2 3 2
#>   ..- attr(*, "label")= chr "Marital status"
#>  $ b1: Factor w/ 2 levels "Yes","No": 1 2 1 2 1
#>   ..- attr(*, "label")= chr "Are you employed?"
#>  $ b2: Factor w/ 3 levels "Self employed",..: 3 NA 2 NA 2
#>   ..- attr(*, "label")= chr "Indicate type of employment"
#>  $ b3: Factor w/ 5 levels "Very Disatisfied",..: 2 NA 3 NA 1
#>   ..- attr(*, "label")= chr "How satisfied are you with your employment"
#>  $ b4: Factor w/ 2 levels "Yes","No": 1 1 2 1 1
#>   ..- attr(*, "label")= chr "Do you have a business?"
#>  $ d1: Factor w/ 2 levels "Yes","No": 2 2 1 1 2
#>   ..- attr(*, "label")= chr "Have you ever programmed before?"
#>  $ d2: chr [1:5] NA NA "1 3 4 6" "4 5 6" ...
#>   ..- attr(*, "label")= chr "Which of these languages have you used?"

## The dataset has been properly labelled
```
