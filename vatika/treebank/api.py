import hug
import falcon
import random

from vatika import db
from vatika.treebank.model import Sentence

@hug.get('/')
def get_root():
  skips = random.randint(0, Sentence.objects.count())
  sentence = next(Sentence
      .objects
      .order_by('annotation__size')
      .skip(skips))
  return sentence.repr


@hug.post('/{oid}')
def post_annotations(oid, annotation: hug.types.text):
  try:
    sentence = Sentence.objects.get(oid=oid)
    sentence.annotation.append(annotation)
    sentence.save()
    return sentence.repr
  except db.DoesNotExist:
    raise falcon.HTTPNotFound
