# A simple ETL process using demographic data from the City of New York, broken down by ZIP code
# https://catalog.data.gov/dataset/demographic-statistics-by-zip-code

import requests
import pandas as pd
from datetime import datetime

url = "https://data.cityofnewyork.us/api/views/kku6-nxdu/rows.csv?accessType=DOWNLOAD"

def extract(url):
    """ Fetch CSV file and load to a dataframe
        Returns dataframe """
    response = requests.get(url)
    content = response.content
    with open("extracted_demographics.csv", "wb") as file:
        file.write(content)
    df = pd.read_csv("extracted_demographics.csv")
    return df

def get_citizen_portion(percent):
    """ Helper function - Calculate text label based on percentage
        Returns string """
    if percent == 1:
        return "All"
    elif percent >= 0.7:
        return "Most"
    elif percent >= 0.5:
        return "Half"
    elif percent >= 0.3:
        return "Some"
    elif percent > 0:
        return "Few"
    else:
        return "None"

def transform(df, citizen_func):
    """ Drop unneeded data and transform citizen column
        Returns dataframe """
    cols_to_keep = ["JURISDICTION NAME", 
                    "COUNT PARTICIPANTS", 
                    "COUNT FEMALE", 
                    "COUNT MALE", 
                    "COUNT GENDER UNKNOWN", 
                    "PERCENT US CITIZEN", 
                    "COUNT RECEIVES PUBLIC ASSISTANCE", 
                    "COUNT NRECEIVES PUBLIC ASSISTANCE", 
                    "COUNT PUBLIC ASSISTANCE UNKNOWN"]
    df = df[cols_to_keep]                                                 # drop unneeded columns
    df = df[df["COUNT PARTICIPANTS"] != 0]                                # drop rows with no respondents
    df["PORTION CITIZENS"] = df["PERCENT US CITIZEN"].apply(citizen_func) # map % citizens to new text column
    df = df.drop("PERCENT US CITIZEN", axis=1)                            # drop now-unneeded % citizen column
    return df

def load(data, target_file):
    """ Loads dataframe to given file name
        No return value """
    data.to_csv(target_file)

def log(message):
    """ Writes log message to file, with timestamp
        No return value """
    time_format = "%Y-%h-%d-%H:%M:%S"
    now = datetime.now()
    timestamp = now.strftime(time_format)
    with open("logfile.txt", "a") as f:
        f.write(timestamp + "," + message + "\n")

if __name__ == "__main__":
    log("ETL job started")

    # Extract
    log("Extract started")
    data = extract(url)
    log("Extract finished")
    
    # Transform
    log("Transform started")
    transformed_data = transform(data, get_citizen_portion)
    log("Transform finished")
    
    # Load
    log("Load started")
    load(transformed_data, "transformed_demographics.csv")
    log("Load finished")
    
    log("ETL job finished")