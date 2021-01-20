library("tximport")
library("DESeq2")
library("BiocParallel")
register(SnowParam(8))
setwd("./DEG/")
## kallisto
samples <- read.table("./sample3.txt", header = T)
tx2gene <- read.table("./gene_trans_HC_LC.txt",sep="\t",header = T)
dir <- "./"
files <- file.path(dir, "kallisto", samples$Sample, "abundance.h5")
txi.kallisto <- tximport(files, type = "kallisto", tx2gene = tx2gene,countsFromAbundance = c("lengthScaledTPM"))
dds <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ Treatment)
dds <- dds[rowSums(counts(dds)) > 1,]
dds <- DESeq(dds)
ck_tre <- results(dds, contrast = c("Treatment","hot12P","12P"))
write.table(ck_tre,file="12P_salmon.txt",sep="\t",quote=F)

## salmon
samples <- read.table("./s3.txt", header = T)
tx2gene <- read.table("./Arab.id.txt",sep="\t",header = T)
dir <- "./"
files <- file.path(dir,"salmon", samples$Sample, "quant.sf")
txi <- tximport(files, type="salmon", tx2gene=tx2gene,countsFromAbundance = c("lengthScaledTPM"))
dds <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ Treatment)
dds <- dds[rowSums(counts(dds)) > 1,]
dds <- DESeq(dds)
ck_tre <- results(dds, contrast = c("Treatment","hot14P","14P"))
write.table(ck_tre,file="14P_new_salmon.txt",sep="\t",quote=F)