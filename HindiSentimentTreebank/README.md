# event-scraper

Representative Scraping Routines.

- Uses Huey for task queue.
- Auto retry for failed tasks.
- Test coverage for Scraper classes.

# Usage:

- Create a new Virtual Environment.
- Install Dependencies
    `$ pip3 install -r requirements.txt`.
- Run Redis Server (used as task queue store). Assumes default Redis output.
    `$ redis-server`.
- Run Consumer with 10 worker processes:
    `$ huey_consumer.py events.huey -w 10`
- In another terminal, run this to start scraping:
    `$ python3 events.py`

# Testing:

Test coverage is currently limited to `scraper` module. To test, run:
    `$ python3 -m unittest`


 celery -A scraper beat -l info
 celery -A scraper worker -l info
