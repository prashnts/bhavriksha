import hashlib

from vatika import db


class Sentence(db.Document):
  oid = db.StringField(required=True, primary_key=True)
  parse_tree = db.StringField(required=True)
  annotation = db.ListField(db.StringField())

  def save(self, *args, **kwa):
    self.oid = str(hashlib.md5(self.parse_tree.encode()).hexdigest())
    return super().save(*args, **kwa)

  @property
  def repr(self):
    return {
      'parse_tree': self.parse_tree,
      'id': self.oid
    }
