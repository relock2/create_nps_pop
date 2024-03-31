#' Generate a simulated population of individuals with a given Net Promoter Score
#'
#' This function takes in a given Net Promoter Score (NPS) on a scale of -1 to 1 
#' and a desired population size and returns a population of that size as close 
#' as possible to the given NPS. If the NPS is not possible givne the population
#' size, the function will return a score slightly above or below it. If the 
#' desired NPS is 0, the function will always return a population with that NPS,
#' but the population might be slightly smaller than what was provided by the
#' user. 
#'
#' @param population: The desired population size. This will be the length of
#'                    the output vector.
#' @param nps: The desired Net Promoter Score on a scale of -1 to 1.
#' @param suppress_message: Accepts a TRUE or FALSE value. If TRUE, the function
#'                          will not print the summary statistics of the
#'                          simulated population
#'
#' @return A shuffled vector of 1 (promoter), 0 (passive), and (-1) detractor 
#'         that has the properties of the given nps and population size.
#'
#' @examples
#' example_nps_pop <- create_nps_pop(population = 500, nps = 0.77)
#' @export


create_nps_pop <- function(population = 10000, nps = 0.5, suppress_message = FALSE) {
  
  # Check data types
  if (round(population,0)!=population) stop("Argument `population` must be an integer")
  if (!is.numeric(nps)) stop("Argument `nps` must be numeric")
  if (!is.logical(suppress_message)) stop("Argument `suppress_message` must be either TRUE or FALSE")
  
  # Check for invalid inputs
  if (nps < -1 | nps > 1) stop("nps must be a value between -1 and 1")
  if (population < 2) stop('Population must be at least 2')

  
  generate_counts <- function(target_nps, n) {
    min_random_count <- floor(target_nps * n)
    
    # Limit number of randomly-generated scores to no more than half of all 
    # values after reaching the minimum threshold. That way the surplus
    # scores can be counteracted by opposing scores to keep the NPS at its
    # desired level.
    remaining_values_above_nps <- floor((1 - target_nps) / 2 * n)
    max_random_count <- ifelse(remaining_values_above_nps < 2, min_random_count, 
                             remaining_values_above_nps + min_random_count)
    
    # If the min and max promoter counts are the same, use that. Otherwise,
    # pick a random number within the range of the min and max.
    random_count <- ifelse(min_random_count == max_random_count, min_random_count, 
                         sample(min_random_count:max_random_count, 1))
    random_prop <- random_count / n
    
    # Calculate proportion of detractors needed for provided NPS
    opposing_prop <- ifelse(random_prop - target_nps < 0, 0, random_prop - target_nps)
    
    # Calculate number of detractors
    opposing_count <- round(opposing_prop * n)
    
    # Fill in remaining values with passives
    pas_count <- n - random_count - opposing_count
    
    return(list(random_var = random_count, opposing_var = opposing_count, pas_var = pas_count))
    
  }
  
  
  # Select starting values
  if (nps > 0) {
    orig_nps <- nps

    counts <- generate_counts(n = population, target_nps = nps)
    prom_count <- counts[[1]]
    det_count <- counts[[2]]
    pas_count <- counts[[3]]
    
  } else if (nps < 0) {
    
    # Preserve submitted nps for message
    orig_nps <- nps
    
    # Convert nps to its absolute value so we're working with
    # positive numbers
    nps <- abs(nps)
    
    counts <- generate_counts(n = population, target_nps = nps)
    prom_count <- counts[[2]]
    det_count <- counts[[1]]
    pas_count <- counts[[3]]
    
  } else {
    pas_count <- sample(1:(n-2), 1)
    
    prom_count <- (n - pas_count) / 2
    
    det_count <- n - pas_count - prom_count
  }
  
  
  ordered_vector <- c(rep(1, prom_count), rep(0, pas_count), rep(-1, det_count))
  shuffled_vector <- sample(ordered_vector)
  
  print(prom_count)
  
  if (! suppress_message) {
    
    cat('############### Simulated Net Promoter Population ###############', '\n')
    cat('##', '\n')
    cat('## Submitted NPS:', orig_nps, '\n')
    cat('## Submitted population:', population, '\n')
    cat('##', '\n')
    cat('## Population size:', length(shuffled_vector), '\n')
    cat('## Net Promoter Score:', mean(shuffled_vector), '\n')
    cat('##', '\n')
    cat('## Number of promoters:', prom_count, '\n')
    cat('## Number of passives:', pas_count, '\n')
    cat('## Number of detractors:', det_count, '\n')
    
  }
  
  return(shuffled_vector)
}



