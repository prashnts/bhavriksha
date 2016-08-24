from pybloomfilter import BloomFilter

def sec_fil(in_file,out_file):
	bf = BloomFilter(10000000, 0.01)
	c=0
	with open(in_file,'r') as f:
		for line in f.readlines():
			if line not in bf:
				c+=1
				print(c)
				bf.add(line)
				with open(out_file,'a') as inp:
					inp.write(line)

if __name__ == '__main__':
	sec_fil('filmibeat.txt')
	
