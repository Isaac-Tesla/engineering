#!/usr/bin/env python

from bs4 import BeautifulSoup
import requests
import csv # to open/close/append CSV
from datetime import datetime # to accuractley stamp the CSV file
import os # to check if file exists
import pandas as pd
from tqdm import tqdm
import re

# Webscrape all job ads in Seek.com.au based on a search query.

def _webscrape_seek():

    SEARCH_TERMS= "cloud architect".replace(" ", "-")

    SALARY_BUCKETS = [0, 30000, 40000, 50000, 60000, 70000, 80000, 100000, 120000, 150000, 200000, 999999]
    SALARY_LOW = SALARY_BUCKETS[9]
    SALARY_HIGH = SALARY_BUCKETS[11]

    PAGE = 1

    BASE_URL = f"https://www.seek.com.au/{SEARCH_TERMS}-jobs/in-All-Sydney-NSW?page={PAGE}&salaryrange={SALARY_LOW}-{SALARY_HIGH}&salarytype=annual"
    html = requests.get(BASE_URL).text
    text = BeautifulSoup(html,'html.parser')

    JOB_ADS_TOTAL = str(text.findAll('span', id="SearchSummary")[0].text).split(' ')[0].replace(',', '')
    JOB_HREFs = text.find_all('a', class_='CbjkqYz')
    PAGES_TOTAL = int(JOB_ADS_TOTAL) / len(JOB_HREFs)

    print(PAGES_TOTAL, JOB_ADS_TOTAL, len(JOB_HREFs))


    # missing a fraction of a page.
    for PAGE in tqdm(range(0, int(PAGES_TOTAL))):

        JOB_ADS_DF = pd.DataFrame()

        for i in range(0, len(JOB_HREFs)):

            JOB_TITLE = JOB_HREFs[i].text
            URL = "https://www.seek.com.au/" + JOB_HREFs[i]['href']
            JOB_PAGE = requests.get(URL).text
            JOB_PAGE_TEXT = BeautifulSoup(JOB_PAGE,'html.parser')
            JOB_TEXT = str(JOB_PAGE_TEXT.find_all('div', class_='yvsb870 _1v38w810'))

            JOB_TEXT_CLEANER = re.sub('\W+',' ', JOB_TEXT )

            STOPWORDS = ["div", "class", "p", "yvsb870", "_1v38w810", "li", "strong", "br", "ul"]
            JOB_TEXT_CLEANER_SPLIT = JOB_TEXT_CLEANER.split()
            JOB_TEXT_CLEANER_RESULT = [word for word in JOB_TEXT_CLEANER_SPLIT if word.lower() not in STOPWORDS]
            JOB_TEXT_CLEANED =  ' '.join(JOB_TEXT_CLEANER_RESULT)

            DETAILS = {
                'JOB_NAME' : [JOB_TITLE],
                'JOB_TEXT' : [JOB_TEXT_CLEANED],
                'URL' : [URL],
                'SALARY_LOW': [SALARY_LOW],
                'SALARY_HIGH': [SALARY_HIGH]
            }
            
            df = pd.DataFrame(DETAILS)
            JOB_ADS_DF = pd.concat([JOB_ADS_DF, df])

    print(JOB_ADS_DF.head())

    CSV_NAME = "SEEK_JOB_ADS"
    DATA_DIR = "/".join(os.getcwd().split('/')[1:6]) + '/data'
    JOB_ADS_DF.to_csv(f"/{DATA_DIR}/{CSV_NAME}_{SEARCH_TERMS}.csv")

_webscrape_seek()


