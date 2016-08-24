from pybloomfilter import BloomFilter


def del_duplicates(in_file,out_file):
	bf = BloomFilter(10000000, 0.01)
	c=0
	with open(in_file,'r') as f:
		for line in f:
			x = line.rstrip().split('|')
			# bf.add(word.rstrip())
	for i in x:
		if i not in bf:
			c+=1
			print(c)
			bf.add(i)
			with open(out_file,'a') as y:
				y.write(i+'\n')



if __name__ == '__main__':

	del_duplicates('filmibeat2.txt')
	


# 407 kb