import time
import requests
import logging
import json
import sys

from celery import Celery
from mQueue import myQueue
from pybloomfilter import BloomFilter
from readability import Document
from requests.exceptions import RequestException
from pyquery import PyQuery as pq
from bs4 import BeautifulStoneSoup as Soup

app = Celery('scrape_demo',broker='redis://localhost:6379/0')
event_store = {}
links = myQueue()
bf = BloomFilter(10000000, 0.01)
c = 0

@app.task
def scrape_sitemap(url):
	try:
		resp = requests.get(url,timeout=10)
		soup = Soup(resp.content)
		urls = soup.findAll('url')
		for u in urls:
			loc = u.find('loc').string
			bf.add(loc)
			links.insert(loc)
		while not links.is_empty():
			scrape_u(links.remove())
		print('done')
	except RequestException as e:
		raise Exception("Request Failed. Will Retry.")


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
		doc = pq(str(r.content))
		r = requests.get(url,timeout=10)
		docq = str.encode(r.text)
		readable_article = Document(docq).summary()
		docs = pq(readable_article)
		docs = docs.text()

		store[url.replace(".", "|").replace("$","-")] = docs
		web.insert_one(store)

		with open("filmibeat2.txt", "a") as myfile:
			myfile.write(docs)

		temp_links = doc.find('a')
		k = 0
		for i in range(len(temp_links)):
			link = temp_links.eq(i)
			lurl = link.attr('href')
			if lurl is not None and 'page-no' in lurl :
				k+=1
			if lurl not in bf and lurl is not None and '/reviews/' in lurl and 'siddiqui-054245' not in lurl and k<2:
				c+=1
				x = 'http://hindi.filmibeat.com'+str(lurl)
				if x == 'http://hindi.filmibeat.com/reviews/' or x == r"http://hindi.filmibeat.com\'/reviews/\'" or c%2 != 0:
					continue
				else:
					bf.add(x)
					links.insert(x)

	except RequestException as e:
		raise Exception("Request Failed. Will Retry.")


if __name__ == "__main__":
	scrape_site('http://hindi.filmibeat.com/reviews/?page-no=1')
