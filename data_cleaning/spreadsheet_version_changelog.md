# Changelog
This file describes the changes made to clean the data in spreadsheet_version_dirty and generate spreadsheet_version_clean

## Data notes
It's important to note that this data is not a random sample of the population. It represents a subset of readers of a particular management blog. It also contains many more responses from the U.S. than from other countries, and has an uneven distribution of industries and races.

This version of the data was pulled from the source on November 3, 2023, and so may contain more data than earlier versions.

Version 1.0.0 (11-03-2023)
## New
- Added column "Total compensation" which sums Annual salary and Additional monetary compensation
- Added column "Total compensation USD" and converted incomes to USD

## Changes 
Data removals:

- Deleted "Job title - additional context" (not relevant to analysis)
- Deleted empty rows at end of dataset
- Deleted rows with nonsensical job titles (3 rows)
- Deleted where salary = 0 (1 row)
- Deleted row where city and state were not real (2 rows)
- Deleted where no accurate country could be determined (6 rows)
- Deleted where "Currency - other" indicated the income was not from a job (1 row)

Edits:

- In "How old are you?" column, changed "under 18" to "0-18" and "65 or over" to "65+" for sorting and formatting purposes
- Trimmed whitespace from Job title, Country, State, City columns
- Various typos fixed in City, State, Country columns
- Swapped salary and Additional Monetary Compensation where salary was 0 but substantial Additional compensation was present (2 rows)
- Where Country = United States and multiple states listed, chose a single state based on the City column. Removed state from City column where present.
- Edited Country on a case-by-case basis where a nonstandard value was listed. Deleted corresponding State and City when misaligned with Country. 
- Standardized Washington D.C., United States as City = "Washington" and State = "District of Columbia"
- Edited City on a case-by-case basis where a nonstandard value was listed. Where urban complexes were mentioned, altered to the major city of that complex. 
- Removed info in "Currency - other" where value not informative
- Manually calculated "Total compensation USD" where multiple currencies were involved (1 row)
- Standardized "Highest level of education" on a case-by-case basis to match provided categories, and created categories "Less than high school" and "Unknown" (for when I could not determine another category)

Inserts:

- Manually entered state where Country = United States, State was blank, and state could be inferred from City column (32 rows). Removed state from City column if present for these rows.

## Fixes
- None at this time (no functionality present)

# TODO

Fix the job titles!
one race / gender per cell?
sort it?
plot to check for outliers

when done, verification