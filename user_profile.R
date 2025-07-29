# user_profile.R

# Install renv if missing
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Restore the environment
renv::restore(prompt = FALSE)

# Optional: print session info
cat("\nEnvironment ready. Loaded packages:\n")
print(sessionInfo())
