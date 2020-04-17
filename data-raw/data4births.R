pacman::p_load(tidyverse, DataPushR, fs)

#https://www.who.int/tb/country/data/download/en/

tb_cases <- read_csv("https://extranet.who.int/tme/generateCSV.asp?ds=notifications")
tb_budget <- read_csv("https://extranet.who.int/tme/generateCSV.asp?ds=budget")
tb_utilization <- read_csv("https://extranet.who.int/tme/generateCSV.asp?ds=expenditure_utilisation")
tb_outcomes <- read_csv("https://extranet.who.int/tme/generateCSV.asp?ds=outcomes")
tb_dictionary <- read_csv("https://extranet.who.int/tme/generateCSV.asp?ds=dictionary")

tb_rfds <- tidyr::who

## Build package

package_name_text <- "data4tuberculosis"
base_folder <- "../../byuidatascience/"
user <- "byuidatascience"
package_path <- str_c(base_folder, package_name_text)


####  Run to create repo locally and on GitHub.  ######

# github_info <- dpr_create_github(user, package_name_text)
#    
# package_path <- dpr_create_package(list_data = NULL,
#                                       package_name = package_name_text,
#                                       export_folder = base_folder,
#                                        git_remote = github_info$clone_url)

##### dpr_delete_github(user, package_name_text) ####

####### End create section
github_info <- dpr_info_github(user, package_name_text)
usethis::proj_set(package_path)

usethis::use_data(tb_cases, tb_budget, tb_utilization, tb_outcomes, tb_rfds, tb_dictionary, overwrite = TRUE)

dpr_export(tb_cases, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(tb_budget, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(tb_utilization, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(tb_outcomes, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(tb_rfds, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(tb_dictionary, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_document(tb_cases, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_cases", 
             title = "Word Health Organization (WHO) Tuberculosis case notifications by country",
             description = "See source for description of the data. tb_dictionary describes the column names.",
             source = "https://www.who.int/tb/country/data/download/en/",
             var_details = list(nothing = "nothing"))

dpr_document(tb_budget, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_budget", 
             title = "Word Health Organization (WHO) Tuberculosis budgets by country",
             description = "See source for description of the data. tb_dictionary describes the column names.",
             source = "https://www.who.int/tb/country/data/download/en/",
             var_details = list(nothing = "nothing"))

dpr_document(tb_utilization, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_utilization", 
             title = "Word Health Organization (WHO) Tuberculosis expenditures and utilization by country",
             description = "See source for description of the data. tb_dictionary describes the column names.",
             source = "https://www.who.int/tb/country/data/download/en/",
             var_details = list(nothing = "nothing"))

dpr_document(tb_outcomes, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_outcomes", 
             title = "Word Health Organization (WHO) Tuberculosis treatment outcomes by country",
             description = "See source for description of the data. tb_dictionary describes the column names.",
             source = "https://www.who.int/tb/country/data/download/en/",
             var_details = list(nothing = "nothing"))

dpr_document(tb_dictionary, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_dictionary", 
             title = "Word Health Organization (WHO) Tuberculosis csv file column names",
             description = "File found at https://extranet.who.int/tme/generateCSV.asp?ds=dictionary",
             source = "https://www.who.int/tb/country/data/download/en/",
             var_details = list(nothing = "nothing"))

dpr_document(tb_rfds, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "tb_rfds", 
             title = "Word Health Organization (WHO) Tuberculosis as found in the R for Data Science Book",
             description = "See the tidy data chapter https://r4ds.had.co.nz/tidy-data.html",
             source = "https://tidyr.tidyverse.org/reference/who.html",
             var_details = list(nothing = "nothing"))

devtools::document(package_path)

dpr_readme(usethis::proj_get(), package_name_text, user)


dpr_write_script(folder_dir = package_path, r_read = "scripts/tuberculosis_package.R", 
                 r_folder_write = "data-raw", r_write = str_c(package_name_text, ".R"))
devtools::document(package_path)
dpr_push(folder_dir = package_path, message = "'documentation'", repo_url = NULL)




