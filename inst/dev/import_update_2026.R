# ############################################ #
# import current Statbel statistical sectors   #
# ############################################ #

library(sf)

# https://statbel.fgov.be/nl/open-data/statistische-sectoren-2026
# Lambert 2008, EPSG 3812

url <- paste0(
  "https://statbel.fgov.be/sites/default/files/files/opendata/",
  "Statistische%20sectoren/",
  "sh_statbel_statistical_sectors_3812_20260101.sqlite.zip"
)

fn <- file.path(tempdir(), basename(url))

if (!file.exists(fn)) {
  download.file(url, fn, mode = "wb")
}

files <- unzip(fn, exdir = tempdir())

sqlite <- files[grepl("\\.sqlite$", files)]

sectors_2026 <- st_read(sqlite, quiet = TRUE)
sectors_2026 <- st_zm(sectors_2026)

stopifnot(st_crs(sectors_2026)$epsg == 3812)

dim(sectors_2026)
names(sectors_2026)
