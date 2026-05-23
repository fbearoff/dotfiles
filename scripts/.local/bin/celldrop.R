readr::read_csv(
  list.files(pattern = ".csv"),
  skip = 1,
  show_col_types = FALSE,
  name_repair = "unique_quiet"
) |>
  dplyr::arrange(`Result ID`) |>
  dplyr::rename(
    sample_id = "Sample Name",
    "%viability" = "% Viability"
  ) |>
  tidyr::separate_wider_delim(
    sample_id,
    delim = "_",
    names = c("label", "process_date"),
    too_many = "drop",
    cols_remove = FALSE
  ) |>
  # Cells are counted in 2mL
  dplyr::mutate(
    cell_number = `Live Cells/mL` * 2,
    .before = "%viability"
  ) |>
  dplyr::select(c(label, process_date, cell_number, "%viability")) |>
  readr::write_csv("out.csv")
