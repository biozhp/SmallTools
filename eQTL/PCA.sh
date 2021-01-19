## results in eigenvec
plink --allow-extra-chr --out temp --recode --vcf all.impute.385.m8f5.num.vcf
plink --allow-extra-chr --file temp --noweb --make-bed --out m8f5
./gcta64 --bfile ../m8f5 --make-grm --autosome --out tmp
./gcta64 --grm tmp --pca --out m8f5.pca
plink --bfile m8f5 --recode A-transpose --out eQTL.SNP
