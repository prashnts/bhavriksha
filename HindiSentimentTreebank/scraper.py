import time
import requests
import logging
import json
import sys

from celery import Celery
from huey import Huey, RedisHuey, crontab
from mQueue import myQueue
from pybloomfilter import BloomFilter
from readability import Document
from requests.exceptions import RequestException
from pyquery import PyQuery as pq
from bs4 import BeautifulStoneSoup as Soup
from pymongo import MongoClient

app = Celery('scrape_demo',broker='redis://localhost:6379/0')
event_store = []
links = myQueue()
bf = BloomFilter(10000000, 0.01)
c = 0

# @huey.task(retries=10, retry_delay=10)
# def scrape_sitemap(url):

# 	try:
# 		resp = requests.get(url,timeout=10)
# 		soup = Soup(resp.content)
# 		urls = soup.findAll('url')
	
# 		for u in urls:
# 			loc = u.find('loc').string
# 			bf.add(loc)
# 			links.insert(loc)

# 		while not links.is_empty():
# 			scrape_u(links.remove())
# 		print('done')
	
# 	except RequestException as e:
# 		raise Exception("Request Failed. Will Retry.")


@app.task
def scrape_site(url):

	try:
		scrape_u(url)

		while not links.is_empty():

			scrape_u(links.remove())
			print('scraped another one')

		print('done')
	
	except RequestException as e:
		raise Exception("Request Failed. Will Retry.")


@app.task
def scrape_u(url):

	temp_links = []
	store = {}
	global c
  
	try:

		r = requests.get(url,timeout=10)
		r.encoding = 'utf-8'
		doc = pq(str(r.content))
		r = requests.get(url,timeout=10)
		r.encoding = 'utf-8'
		docq = str.encode(r.text)
		readable_article = Document(docq).summary()
		docs = pq(readable_article)
		docs = docs.text()

		store[url.replace(".", "|").replace("$","-")] = docs
		webdunia.insert_one(store)
		
		with open("ndtv2.txt", "a") as myfile:
			myfile.write(docs)

		temp_links = doc.find('a')

		for i in range(len(temp_links)):

			link = temp_links.eq(i)
			lurl = link.attr('href')


			if lurl not in event_store and lurl is not None and '/news/blogs' in lurl and r"\'" not in lurl and c<24:
				c+=1
				print(c)

				if 'blogs/page' in lurl:
					continue
				else:
					print(lurl)
					event_store.append(lurl)
					links.insert(lurl)



	except RequestException as e:
		raise Exception("Request Failed. Will Retry.")


if __name__ == "__main__":

  scrape_site('http://khabar.ndtv.com/news/blogs/page-7')
