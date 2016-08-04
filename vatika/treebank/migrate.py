import json
import sys

from tqdm import tqdm

from vatika.treebank.model import Sentence

if __name__ == '__main__':
  data = json.loads(sys.stdin.read())

  for s in tqdm(data):
    ob = Sentence(parse_tree=s)
    ob.save()
