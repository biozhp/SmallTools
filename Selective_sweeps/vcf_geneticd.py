import re
import argparse
parser = argparse.ArgumentParser(description='Author:Peng Zhao <pengzhao@nwafu.edu.cn>')
parser.add_argument('-vcf', type=str)
parser.add_argument('-rrate', type=str)
parser.add_argument('-chr', type=str)
args = parser.parse_args()
vcf_name = args.vcf
rate = args.rrate
chr_name = args.chr
ouf_name = str(chr_name) + ".snp"
inf = open(vcf_name,"r")
ouf = open(ouf_name,"w")
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t",line)
    if li[0][:1] != "#":
        if str(li[0]) == str(chr_name):
            snp_name = str(li[0]) + ":" + str(li[1])
            geneticd = int(li[1]) * float(rate)
            ouf.write("%s\t%s\t%s\t%s\t%s\t%s\n" % (snp_name,chr_name,geneticd,li[1],li[3],li[4]))
ouf.close()