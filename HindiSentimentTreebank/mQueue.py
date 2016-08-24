class myQueue(object):

		def __init__(self):
				self.length = 0
				self.head = None

		def is_empty(self):
					return self.length == 0

		def remove(self):
					cargo = self.head.cargo
					self.head = self.head.next
					self.length -= 1
					return cargo

		def insert(self, cargo):
					node = mNode(cargo)
					if self.head is None:
							# If list is empty the new node goes first
							self.head = node
					else:
							last = self.head
							while last.next:
									last = last.next
									# Append the new node
							last.next = node
					self.length += 1

class mNode(object):

    def __init__(self, cargo=None, next=None):
        self.cargo = cargo
        self.next  = next

    def __str__(self):
        return str(self.cargo)