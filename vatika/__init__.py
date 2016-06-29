# Vatika
import hug
import pecan_mount
import static
import mongocapsule

from vatika import _config as config

db = mongocapsule.MongoCapsule(config.mongo_db_name, **config.mongo_config)


@hug.get('/')
def index():
  return "Vatika API Server. Go to /v1 for docs."

# WSGI Mounts

# @hug.extend_api('/survey')
# def attach_scraper_api():
#   return [api_survey]

# Get WSGI friendly environment for *both* Static Files and API
pecan_mount.tree.graft(__hug_wsgi__, '/api')
pecan_mount.tree.graft(static.Cling(config.static_root), '/')

api = pecan_mount.tree
