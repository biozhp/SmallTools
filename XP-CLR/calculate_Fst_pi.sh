## Calculate the Fst
cd /users/xushb/Project/XPCLR/Fst/
vcftools --vcf ../all.impute.385.m8.vcf --weir-fst-pop ../p1.txt --weir-fst-pop ../p2.txt --out WL_WMC_Fst --fst-window-size 200000 --fst-window-step 100000 && \
touch finish

## Calculate the pi
cd /users/xushb/Project/XPCLR/pi/
vcftools --vcf ../all.impute.385.m8.vcf --keep ../p1.txt --window-pi 200000 --window-pi-step 100000 --out p1_pi && \
vcftools --vcf ../all.impute.385.m8.vcf --keep ../p2.txt --window-pi 200000 --window-pi-step 100000 --out p2_pi && \
touch finish