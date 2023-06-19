#! /bin/bash
# A script that fetches, modifies, and backs up data files that change every 3 months
# Run this script on the 30th of the relevant months with this crontable entry: 0 0 30 3,6,9,12 * get_license_data.sh

# Capture current location for navigation purposes
startdir=$(pwd)

# Build directory name with today's date
dirname="$(date +%b_%d_%Y)_license_info"

# Create & move into new directory
mkdir $dirname
cd $dirname

# Capture location path
destinationdir=$(pwd)

# Download CSV of recently approved liquor licenses
wget -O recently_approved_licenses_co.csv https://data.colorado.gov/api/views/htyp-tqzh/rows.csv?accessType=DOWNLOAD

# Select only hotel & restaurant type licenses into new file
grep "Hotel & Restaurant" recently_approved_licenses_co.csv > approved_licenses.csv

# Delete downloaded file
rm recently_approved_licenses_co.csv

# Download CSV of recently expired liquor licenses
wget -O recently_expired_licenses_co.csv https://data.colorado.gov/api/views/pwjb-9dd5/rows.csv?accessType=DOWNLOAD

# Select only hotel & restaurant type licenses into new file
grep "Hotel & Restaurant" recently_expired_licenses_co.csv > expired_licenses.csv

# Delete downloaded file
rm recently_expired_licenses_co.csv

# Return to original location
cd $startdir

# Archive and compress data
tar -czf $dirname.tar.gz $destinationdir

# Store archive in dedicated directory
mv $dirname.tar.gz /home/license_data/