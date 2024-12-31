import scipy, sys
from scipy import stats

for line in open(sys.argv[1]):
	line=line.rstrip().split("\t")
	try:
	    print "\t".join(line), "\t", stats.fisher_exact([[int(line[1]),int(line[2])-int(line[1])],[int(line[3]),int(line[4])-int(line[3])]], alternative="greater")[1]
	except:
	    print "\t".join(line), "\t", 1
