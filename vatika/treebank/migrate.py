import json
import sys

from vatika.treebank.model import Sentence

if __name__ == '__main__':
  with open(sys.argv[1], 'r') as fl:
    data = json.load(fl)

  for s in data:
    ob = Sentence(parse_tree=s)
    ob.save()
