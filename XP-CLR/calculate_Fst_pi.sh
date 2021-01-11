## Calculate the Fst
cd /users/xushb/Project/XPCLR/Fst/
vcftools --vcf ../all.impute.385.m8.vcf --weir-fst-pop ../p1.txt --weir-fst-pop ../p2.txt --out WL_WMC_Fst --fst-window-size 200000 --fst-window-step 100000 && \
touch finish

## Calculate the pi
