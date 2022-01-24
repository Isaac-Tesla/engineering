# MongoDB connection setup

The code is designed to connect to MongoDB and run set integration commands. 

</br>

# Environment Variables

The list of required environment variables to pass in are:

```
    server=localhost
    port=27017
    database=
    user=
    password=
```

Note: Most of these can be left blank if using a basic local docker instance (as per the example shown).

</br>

# Virtual Environment

    build:

        conda env create -f environment.yml

    activate:

        source activate mongodb

</br>


### Local Machine
1. Set the environmental variables:
    ```
    while read line; do export $line; done < .env
    ```
2. Create a virtual environment by running `conda env create -f environment.yml` in the root directory. 

3. Activate the environment `conda activate mongodb`.   

4. From the root directory call `python3 main.py create`. 