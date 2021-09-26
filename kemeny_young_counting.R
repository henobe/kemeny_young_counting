#!/usr/bin/env Rscript
library(votesys)

# Assumptions:
# - ballot contains only numbers as candidate names
# - Preference levels are deliminated by "-"
# - Candidate numbers start at one
# - No number is "jumped"
# - No more than 9 candidates
make_preference_matrix_from_ballot <- function(ballot, n_candidates) {
  # prepare data
  candidate_vector <- seq(1:n_candidates)
  summary_matrix <- matrix(rep(0, n_candidates^2),  nrow = n_candidates)
  splitted_preference_string <- strsplit(ballot, "-") |> unlist()
  
  ranking_table <- data.frame(
    candidates = candidate_vector,
    rank = sapply(as.character(candidate_vector),
                  FUN = grep,
                  splitted_preference_string)
  )
  
  for(candidate in candidate_vector) {
    own_rank <- ranking_table[candidate, "rank"]
    preferred_over <- ranking_table[ranking_table$rank > own_rank,]$candidates
    summary_matrix[candidate, preferred_over] <- 1
  }
  
  summary_matrix
}

args = commandArgs(trailingOnly=TRUE)
votefile <- args[[1]]
n_candidates <- as.numeric(args[[2]])

summary_matrix <- votefile |>
  readLines() |>
  as.list() |>
  lapply(make_preference_matrix_from_ballot, n_candidates) |>
  Reduce(f = `+`)

colnames(summary_matrix) <- seq(1:n_candidates)
rownames(summary_matrix) <- seq(1:n_candidates)

# Votesys implements counting with a limit of 8 candidates
result <- votesys::cdc_kemenyyoung(summary_matrix)
paste("Winner is", result$winner)
