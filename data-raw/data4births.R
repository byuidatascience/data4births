### Data for baseball and US birthdays

pacman::p_load(tidyverse, glue, readxl, Lahman, rvest, lubridate)
pacman::p_load_gh("byuidss/DataPushR")
library(fs)

set.seed(20200313)

# US Population data
dat_94_03 <- read_csv("https://github.com/fivethirtyeight/data/raw/master/births/US_births_1994-2003_CDC_NCHS.csv")
dat_00_14 <- read_csv("https://github.com/fivethirtyeight/data/raw/master/births/US_births_2000-2014_SSA.csv")

counts_us <- dat_94_03 %>%
  filter(year < 2000) %>%
  bind_rows(dat_00_14) %>% 
  group_by(month, date_of_month) %>%
  summarise(births = sum(births)) %>%
  ungroup() %>%
  mutate(day_of_year = 1:n()) %>%
  left_join(tibble(month = 1:12, month_name = month.name)) %>%
  select(month_number = month, month_name, day_of_month = date_of_month, day_of_year, births)

# baseball data
# https://www.billjamesonline.com/article1191/
baseball_births <- Lahman::People %>%
  select(nameGiven, playerID, birthMonth, birthDay, birthCountry, birthDate, debut, finalGame) %>%
  rename_all("str_to_lower") %>%
  rename_all(.funs = funs(str_remove_all(.,"birth"))) %>%
  mutate(from = year(ymd(debut)), to = year(ymd(finalgame)), yrs = to - from) %>%
  select(player = namegiven, birthday = date, yrs, from, to, everything(), -playerid, -debut, -finalgame) %>%
  filter(!is.na(birthday))

# US football births

years <- 1900:1999

player_data_rip <- function(x) {
  print(x)
  read_html(str_c("https://www.pro-football-reference.com/years/", x, "/births.htm")) %>%
    html_nodes("table") %>% 
    html_table() %>%
    .[[1]] %>%
    .[,1:6] %>%
    as_tibble() %>%
    rename_all(str_to_lower)
}

dat_20th <- map(years, ~player_data_rip(.x))

football_births <- dat_20th %>%
  bind_rows() %>%
  mutate(birthdate = mdy(birthdate)) %>%
  select(player, birthday = birthdate, yrs, from, to, pos)
write_csv(football_births, "footbal.csv")

### Hockey Birthdays

month_days <- bind_rows(
  tibble(month = 1, days = 1:31),
  tibble(month = 2, days = 1:29),
  tibble(month = 3, days = 1:31),
  tibble(month = 4, days = 1:30),
  tibble(month = 5, days = 1:31),
  tibble(month = 6, days = 1:30),
  tibble(month = 7, days = 1:31),
  tibble(month = 8, days = 1:31),
  tibble(month = 9, days = 1:30),
  tibble(month = 10, days = 1:31),
  tibble(month = 11, days = 1:30),
  tibble(month = 12, days = 1:31),
)

hockey_date_rip <- function(m,d) {
  
 urlpath <- glue("https://www.hockey-reference.com/friv/birthdays.cgi?month={month}&day={day}", 
                  month = m, day = d)
  
 out <-  read_html(urlpath) %>%
    html_nodes("table") %>% 
    html_table() %>%
    .[[1]]
 
 col_names <- str_remove_all(out[1, 2:6], "\\(s\\)") %>% str_to_lower()
 
 out <- out %>% 
   .[-1, 2:6]
  
 colnames(out) <- col_names   
 
 print(str_c(m,"/", d))
 
 out %>%
   mutate(birthday = ymd(str_c(born,"-", m,"-", d))) %>%
   select(player, birthday, everything(),-born)

   
}

hockey_list <- map2(month_days$month, month_days$days, ~hockey_date_rip(.x, .y))

hockey_births <- hockey_list %>%
  bind_rows() %>%
  as_tibble() %>%
  mutate(from = as.integer(from), to = as.integer(to), yrs = to - from) %>%
  select(player, birthday, yrs, from, to, team)
  
#write_csv(hockey_births, "hockey.csv")

############  Basketball Births #######

basketball_date_rip <- function(m,d) {
  
  urlpath <- glue("https://www.basketball-reference.com/friv/birthdays.fcgi?month={month}&day={day}", 
                  month = m, day = d)
  
  out <-  read_html(urlpath) %>%
    html_nodes("table") %>% 
    html_table() %>%
    .[[1]]
  
  col_names <- str_remove_all(out[1, 2:4], "\\(s\\)") %>% str_to_lower()
  
  out <- out %>% 
    .[-1, 2:4]
  
  colnames(out) <- col_names   
  
  print(str_c(m,"/", d))
  
  out %>%
    mutate(birthday = ymd(str_c(born,"-", m,"-", d))) %>%
    select(player, birthday, everything(),-born)
  
  
}


basketball_list <- map2(month_days$month, month_days$days, ~basketball_date_rip(.x, .y))

basketball_births <- basketball_list %>%
  bind_rows() %>%
  as_tibble() %>%
  mutate(yrs = as.integer(yrs))
write_csv(basketball_births, "basketball.csv")

### Counts by day

counts_baseball <- baseball_births %>%
  filter(country == "USA", year(birthday) > 1925, year(birthday) < 2015) %>%
  count(month, day, name = "births") %>%
  mutate(day_of_year = 1:n()) %>%
  left_join(tibble(month = 1:12, month_name = month.name)) %>%
  select(month_number = month, month_name, day_of_month = day, day_of_year, births)

counts_basketball <- basketball_births %>%
  mutate(month = month(birthday), day = mday(birthday)) %>%
  count(month, day, name = "births") %>%
  mutate(day_of_year = 1:n()) %>%
  left_join(tibble(month = 1:12, month_name = month.name)) %>%
  select(month_number = month, month_name, day_of_month = day, day_of_year, births)

counts_hockey <- hockey_births %>%
  mutate(month = month(birthday), day = mday(birthday)) %>%
  count(month, day, name = "births") %>%
  mutate(day_of_year = 1:n()) %>%
  left_join(tibble(month = 1:12, month_name = month.name)) %>%
  select(month_number = month, month_name, day_of_month = day, day_of_year, births)

counts_football <- football_births %>%
  mutate(month = month(birthday), day = mday(birthday)) %>%
  count(month, day, name = "births") %>%
  mutate(day_of_year = 1:n()) %>%
  left_join(tibble(month = 1:12, month_name = month.name)) %>%
  select(month_number = month, month_name, day_of_month = day, day_of_year, births)

counts_all <- bind_rows(
  mutate(counts_football, group = "football"),
  mutate(counts_baseball, group = "baseball"),
  mutate(counts_hockey, group = "hockey"),
  mutate(counts_basketball, group = "basketball"),
  mutate(counts_us, group = "us")
)

####  Table descriptions  ####

counts_description <- list(month_number = "The numeric month of the year", 
                         month_name ="The name of the month",
                         day_of_month = "The day number of the month 1-31",
                         day_of_year = "The day number of the year 1-366",
                         births = "The total count of births on that day over the period of the data")

counts_all_description <- c(counts_description, group = "The professional sport or US births")


basketball_description = list(player = "Player's name",
                              birthday = "Player's birthdate",
                              yrs = "Number of years played")

football_description = c(basketball_description, from = "Year started", to = "Year ended", pos = "Positions played")

hockey_description = c(basketball_description, from = "Year started", to = "Year ended", team = "Teams played with")

baseball_description = c(basketball_description, from = "Year started", to = "Year ended", 
                            month = "birth month", day = "birth_day", country = "birth country")

## Build package

package_name_text <- "data4births"
base_folder <- "../../byuidatascience/"
user <- "byuidatascience"
package_path <- str_c(base_folder, package_name_text)

####  Run to create repo locally and on GitHub.  ######

# github_info <- dpr_create_github(user, package_name_text)
#   
# package_path <- dpr_create_package(list_data = NULL, 
#                                      package_name = package_name_text, 
#                                      export_folder = base_folder, 
#                                      git_remote = github_info$clone_url)

##### dpr_delete_github(user, package_name_text) ####

####### End create section
github_info <- dpr_info_github(user, package_name_text)
usethis::proj_set(package_path)

dpr_export(counts_baseball, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(counts_basketball, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(counts_football, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(counts_hockey, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(counts_us, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(counts_all, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(baseball_births, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(basketball_births, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(football_births, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(hockey_births, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

usethis::use_data(counts_baseball, counts_basketball, counts_football, counts_hockey, 
                  counts_all, counts_us,
                  baseball_births, hockey_births, basketball_births, football_births, overwrite = TRUE)

dpr_document(counts_us, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_us", title = "The count of births in the United States from 1994-2014",
             description = "Data obtained from the CDC and Census parsed by FiveThirtyEight ",
             source = "https://github.com/fivethirtyeight/data/tree/master/births",
             var_details = counts_description)

dpr_document(counts_baseball, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_baseball", 
             title = "The count of births of MLB players for US born players from 1925 to 2015",
             description = "Data obtained from Lahman http://www.seanlahman.com/baseball-archive/statistics/",
             source = "https://github.com/cdalzell/Lahman",
             var_details = counts_description)

dpr_document(counts_basketball, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_basketball", 
             title = "The count of births of NBA/ABA players",
             description = "Data obtained from https://www.basketball-reference.com",
             source = "https://www.basketball-reference.com/friv/birthdays.fcgi?month=1&day=1",
             var_details = counts_description)

dpr_document(counts_football, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_football", 
             title = "The count of births of NFL players",
             description = "Data obtained from https://www.pro-football-reference.com",
             source = "https://www.pro-football-reference.com/years/1900/births.htm",
             var_details = counts_description)

dpr_document(counts_hockey, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_hockey", 
             title = "The count of births of NHL players",
             description = "Data obtained from https://www.hockey-reference.com",
             source = "https://www.hockey-reference.com/friv/birthdays.cgi?month=1&day=1",
             var_details = counts_description)

dpr_document(counts_all, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "counts_all", 
             title = "The count of births of all players and US by month.",
             description = "Data combined from others sources in package.",
             source = "https://github.com/byuidatascience/data4births",
             var_details = counts_all_description)

#### date details ####

dpr_document(baseball_births, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "baseball_births", 
             title = "The birth dates of MLB players",
             description = "Data obtained from Lahman http://www.seanlahman.com/baseball-archive/statistics/",
             source = "https://github.com/cdalzell/Lahman",
             var_details = baseball_description)

dpr_document(basketball_births, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "basketball_births", 
             title = "The birth dates of NBA/ABA players",
             description = "Data obtained from https://www.basketball-reference.com",
             source = "https://www.basketball-reference.com/friv/birthdays.fcgi?month=1&day=1",
             var_details = basketball_description)

dpr_document(football_births, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "football_births", 
             title = "The birth dates of NFL players",
             description = "Data obtained from https://www.pro-football-reference.com",
             source = "https://www.pro-football-reference.com/years/1900/births.htm",
             var_details = football_description)

dpr_document(hockey_births, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "hockey_births", 
             title = "The birth dates of NHL players",
             description = "Data obtained from https://www.hockey-reference.com",
             source = "https://www.hockey-reference.com/friv/birthdays.cgi?month=1&day=1",
             var_details = hockey_description)

dpr_readme(usethis::proj_get(), package_name_text, user)


dpr_write_script(folder_dir = package_path, r_read = "scripts/births_package.R", 
                 r_folder_write = "data-raw", r_write = str_c(package_name_text, ".R"))
devtools::document(package_path)
dpr_push(folder_dir = package_path, message = "'documentation'", repo_url = NULL)

#### Counts by Month Tables with totals

# 1. read in data from the website of counts_all
# 2. build monthly totals for each sport and the US
# 3. build totals for all groups.
# 
# group, month, count, year_total, 


### Plots to check
# 
# baseball_births %>%
#   ggplot(aes(x = month_number, y = births)) +
#   geom_boxplot(aes(group = month_number)) +
#   scale_x_continuous(breaks = 1:12)
# 
# us_births %>%
#   ggplot(aes(x = month_number, y = births)) +
#   geom_boxplot(aes(group = month_number)) +
#   scale_x_continuous(breaks = 1:12) +
#   coord_cartesian(ylim = c(200000, 260000))
