import hug
import falcon
import random

from vatika.treebank.model import Sentence

@hug.get('/')
def get_root():
  skips = random.randint(0, Sentence.objects.count())
  sentence = next(Sentence
      .objects
      .order_by('annotation__size')
      .skip(skips))
  return sentence.repr
