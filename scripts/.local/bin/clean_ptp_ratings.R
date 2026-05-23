#!/usr/bin/env Rscript
options(warn = -1)
suppressMessages(library(tidyverse))

# pull in filename
args <- commandArgs(trailingOnly = TRUE)

data <- read_csv(args, show_col_types = FALSE)

clean <- data |>
  rename(combined = "imdb_id;rating;title;year") |>
  mutate(
    imdb_id = case_when(str_ends(combined, ";") ~ combined),
    rating = case_when(str_ends(combined, "%") ~ combined),
    title = case_when(str_starts(combined, ";") ~ combined)
  ) |>
  select(!combined) |>
  mutate(
    imdb_id = as.numeric(str_remove(imdb_id, ";")),
    rating = str_sub(rating, -3),
    title = str_remove(title, "^;")
  ) |>
  separate_wider_delim(title, names = c("title", "year"), delim = ";") |>
  mutate(
    rating = lead(rating, 1),
    title = lead(title, 2),
    year = as.numeric(lead(year, 2))
  ) |>
  drop_na() |>
  arrange(desc(rating))

write_csv(clean, "imdb_ratings.csv")
