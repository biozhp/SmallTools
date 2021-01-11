## geneticd = bpositions * rrate
## wheat rrate  0.26 cM/Mb DOI: 10.1126/science.aar7191
## input file preparation
## impute missing rate < 0.8 SNP
## ref https://www.omicsclass.com/article/1334
cat chr_name.txt | while read line
do
plink --vcf all.impute.385.m8.vcf --keep p1.keep.txt --chr $line --out ${line}".p1" --recode 01 transpose -output-missing-genotype 9 --allow-extra-chr --set-missing-var-ids @:# --keep-allele-order && \
cut -d " " -f 5- ${line}".p1.tped" | awk '{print $0" "}' > ${line}".p1.geno" && \
plink --vcf all.impute.385.m8.vcf --keep p2.keep.txt --chr $line --out ${line}".p2" --recode 01 transpose -output-missing-genotype 9 --allow-extra-chr --set-missing-var-ids @:# --keep-allele-order && \
cut -d " " -f 5- ${line}".p2.tped" | awk '{print $0" "}' > ${line}".p2.geno" && \
python ./vcf_geneticd.py -vcf all.impute.385.m8.vcf -rrate 2.6e-9 -chr $line && \
touch finish
done

## xpclr
cd /users/xushb/Project/XPCLR/
cat chr1.txt | while read line
do
/users/xushb/Project/XPCLR/Softwares/XPCLR/bin/XPCLR -xpclr "./input/"${line}".p1.geno" "./input/"${line}".p2.geno" "./input/"${line}".snp" "./normal/"${line}".out" -w1 0.005 500 10000 $line -p1 0.95 && \
touch chr1.finish
done

## xpclr-python
cd /users/xushb/Softwares/miniconda3/bin
. ./activate
cd /users/xushb/Project/XPCLR/
cat chr_name.txt | while read line
do
xpclr --out "./python/"${line}".xpclr.out" --format vcf --input all.impute.385.m8.vcf --samplesA p1.keep.txt --samplesB p2.keep.txt --rrate 2.6e-9 --chr $line --phased --maxsnps 500 --size 10000 && \
touch python.finish
done
