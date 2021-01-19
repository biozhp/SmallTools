##GEMMA
plink --allow-extra-chr --out temp --recode --vcf all.impute.385.m8f5.filter.vcf
plink --allow-extra-chr --file temp --noweb --make-bed --out m8f5
./gemma-0.98.3-linux-static -bfile ./SNP/m8f5 -gk 2 -o gemma

cd /users/xushb/Project/eQTL/gemma/
name=$1
cat ${name} | while read line
do
mkdir ./temp/$line
cp ./scripts/traits.bed ./temp/$line
cp ./scripts/traits.bim ./temp/$line
cp ./exp/${line}".TPM.txt" ./temp/$line/exp.txt
cat ./scripts/header.txt ./temp/$line/exp.txt > ./temp/$line/exp1.txt
Rscript ./scripts/trans.R ./temp/$line/ && \
python ./scripts/fam.py -i ./temp/$line/exp_trans.txt -o ./temp/$line/traits.fam && \
dos2unix ./temp/$line/traits.fam && \
./scripts/gemma-0.98.3-linux-static -bfile ./temp/$line/traits -k ./output/gemma.sXX.txt -c ./scripts/gemma.cov.pca.peer.txt -lmm 1 -o ${line}".gemma" && \
python ./scripts/gene_name.py -i ./output/${line}".gemma.assoc.txt" -g ${line} -o ./result/${line}".out" && \
touch ./finish/${line}".finish"
rm -r ./temp/$line
done


import re
inf = open("list.txt","r")
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t",line)
    shell5 = "cd /users/xushb/Softwares/miniconda3/bin"
    shell6 = ". ./activate"
    shell1 = "cd /users/xushb/Project/eQTL/gemma/"
    shell2 = "sh ./run_pipline.sh ./list/" + str(li[0]) + " && \\"
    shell3 = "touch " + str(li[0]) + ".finish"
    ouf_name = "/users/xushb/Project/eQTL/gemma/shell/" + str(li[0]) + ".sh"
    ouf = open(ouf_name,"w")
    ouf.write("%s\n%s\n%s\n%s\n%s\n" % (shell5,shell6,shell1,shell2,shell3))