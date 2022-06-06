options(browser = "firefox")
local({
  n <- parallel::detectCores() # Detect number of CPU cores
  options(Ncpus = n) # Parallel package installation in install.packages()
  options(mc.cores = n) # Parallel apply-type functions via 'parallel' package
})

## Set CRAN Mirror:
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org/"
  options(repos = r)
})

require(colorout, quietly = TRUE)
colorout::setOutputColors(
  index = "\x1b[38;2;215;153;33m",
  normal = "\x1b[38;2;235;219;178m",
  number = "\x1b[38;2;211;134;155m",
  negnum = "\x1b[38;2;104;157;106m",
  zero = "\x1b[38;2;69;133;136m", zero.limit = 0.01,
  infinite = "\x1b[38;2;250;189;47m",
  string = "\x1b[38;2;184;187;38m",
  date = "\x1b[38;2;254;128;25m",
  const = "\x1b[38;2;250;189;47m",
  true = "\x1b[38;2;142;192;124m",
  false = "\x1b[38;2;251;73;52m",
  warn = "\x1b[38;2;250;189;47m",
  stderror = "\x1b[38;2;204;36;29m",
  error = "\x1b[38;2;204;36;29m",
  verbose = FALSE
)

options(menu.graphics = FALSE)

# vim:ft=r
