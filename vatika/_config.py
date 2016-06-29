# Westeros
import os
import urllib.parse

module_root = os.getcwd()
static_root = module_root + '/public'

mongo_uri = urllib.parse.urlsplit(os.environ['MONGODB_URI'])
mongo_config = {
  'host': mongo_uri.geturl(),
}
mongo_db_name = mongo_uri.path[1:]
