def make_files(in_file,out_file):
	c=0
	with open(in_file,'r') as f:
		for line in f.readlines():
			c+=1
			with open(out_file + str(c) + '.input.txt','a') as x:
				x.write(line)

if __name__ == '__main__':
	make_files('data/ndtv.txt')
