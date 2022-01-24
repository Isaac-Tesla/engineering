#!/usr/bin/env python

import pandas as pd
import os
from nltk.corpus import stopwords
import re
from collections import Counter, defaultdict

import nltk
nltk.download('stopwords')

SEARCH_TERMS = ["cloud-architect"]
CSV_NAME = "SEEK_JOB_ADS"
DATA_DIR = "/".join(os.getcwd().split('/')[1:6]) + '/data'
DATA = pd.DataFrame(columns=['JOB_NAME','JOB_TEXT','URL','SALARY_LOW','SALARY_HIGH'])

for i in range(0, len(SEARCH_TERMS)):
    df = pd.read_csv(f"/{DATA_DIR}/{CSV_NAME}_{SEARCH_TERMS[i]}.csv")
    DATA = pd.concat([DATA, df])

DATA = DATA.apply(lambda x: x.astype(str).str.lower())
stop_words = set(stopwords.words('english'))
DATA["JOB_TEXT_no_stopwords"] = DATA["JOB_TEXT"].apply(lambda x: ' '.join([word for word in x.split() if word not in (stop_words)]))

def clean_string(strings):
    result = []
    for value in strings:
        value = value.strip()
        value = re.sub('([!#?\',.$])','', value)
        value = re.sub("\d+", "", value)
        result.append(value)
    return result

DATA["JOB_TEXT_no_stopwords"] = clean_string(DATA["JOB_TEXT_no_stopwords"])
DATA.reset_index(drop=True, inplace=True)

for i in range(0, len(DATA["JOB_TEXT_no_stopwords"])):
    STOPWORDS = ["please", "apply", "contact", "href", "true", "em", "amp", "mailto", "like", "com", 
        "au", "join", "x", "pm", "partners", "asia", "pacific", "chi", "australia", "skills", "experience",
        "working", "match", "month", "contract"]
    JOB_TEXT_CLEANER_SPLIT = DATA["JOB_TEXT_no_stopwords"][i].split()
    JOB_TEXT_CLEANER_RESULT = [word for word in JOB_TEXT_CLEANER_SPLIT if word.lower() not in STOPWORDS]
    DATA["JOB_TEXT_no_stopwords"][i] =  ' '.join(JOB_TEXT_CLEANER_RESULT)

bigram_list = []
for index, row in DATA.iterrows():
    bigram_list = bigram_list + [b for b in nltk.bigrams(row['JOB_TEXT_no_stopwords'].split())]

bigram_tf = Counter(bigram_list)
df = pd.DataFrame(str(bigram_tf).split(', (')[:50])
print(df)
