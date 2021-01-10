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
