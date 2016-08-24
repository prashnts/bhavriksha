from langdetect import detect

def lang_detect(in_file,out_file):
	c=0
	with open(in_file,'r') as f:

			for line in f.readlines():
				x = detect(line)
				if x == 'hi':
					c+=1
					print(c)
					with open(out_file,'a') as y:
						y.write(line)

if __name__ == '__main__':
	lang_detect('x_filmi.txt','out_filmi.txt')

