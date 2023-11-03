# Changelog
This file describes the changes made to clean the data in spreadsheet_version_dirty and generate spreadsheet_version_clean

## Data notes
It's important to note that this data is not a random sample of the population. It represents a subset of readers of a particular management blog. It also contains many more responses from the U.S. than from other countries, and has an uneven distribution of industries and races.

This version of the data was pulled from the source on November 3, 2023, and so may contain more data than earlier versions.

Version 1.0.0 (11-03-2023)
## New
- Added column "Total compensation" which sums Annual salary and Additional monetary compensation

## Changes 
Data removals:

- Deleted empty rows at end of dataset
- Deleted 3 rows with nonsensical job titles ("8325305674", "x", "[Project role]")
- Deleted where salary = 0 (1 row)
- Deleted row where city and state were not real (1 row)
- Deleted where no accurate country could be determined (6 rows)

Edits:

- Trimmed whitespace from Job title, Country, State, City columns
- Various typos fixed in City, State, Country columns
- Swapped salary and Additional Monetary Compensation where salary was 0 but substantial Additional compensation was present (2 rows)
- Where Country = United States and multiple states listed, chose a single state based on the City column. Removed state from City column where present.
- Edited Country on a case-by-case basis where a nonstandard value was listed. Deleted corresponding State and City when misaligned with Country. 
- Standardized City to "Washington" where State = "District of Columbia"
- Edited City on a case-by-case basis where a nonstandard value was listed. Where urban complexes were mentioned, altered to the major city of that complex. 

Inserts:

- Manually entered state where Country = United States, State was blank, and state could be inferred from City column (32 rows). Removed state from City column if present for these rows.

## Fixes
- None at this time (no functionality present)

# TODO
Edit cities D+
Convert all to USD

*duplicates
nulls
inaccuracies ? like that city not existing
misspellings/typos
formatting
extra whitespace
values in wrong field
data type
data range, like less than 0
one race / gender per cell
sort it?
plot to check for outliers

when done, verification*