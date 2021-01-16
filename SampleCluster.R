library(argparser)
library(parallel)
library(BiocGenerics)
library(Biobase)
library(genefilter)
library(WGCNA)
library(flashClust)
library(caret)
## input
fpkm <- "exp.txt"
cutoff <- 0.5
maxBlockSize <- 30000
mergeCutHeight <- 0.25
notfilter <- 0
outdir <- "."
setwd(outdir)
options(stringsAsFactors = FALSE)
allowWGCNAThreads()
ALLOW_WGCNA_THREADS = 1

# obtain expression data set
data <- read.table(fpkm, header=T, row.names=1, sep="\t")
sp_num <- ncol(data)

# ===============================================================
# 1.2 Filt data according to the coefficient of variation
# ===============================================================
datExpr0 <- as.matrix(data)
if(notfilter==1){
    FltData <- datExpr0
}else{
    FltData <- varFilter(datExpr0, var.func = IQR, var.cutoff = cutoff, filterByQuantile = TRUE)
}

# ==============================================================
# 1.3 Check data for excessive missing values and identification of outlier sample
# ==============================================================
datExpr0 <- as.data.frame(t(FltData))
gsg <- goodSamplesGenes(datExpr0, verbose = 3)
if(!gsg$allOK){
	if (sum(!gsg$goodGenes)>0){  
		write.table(names(datExpr0)[!gsg$goodGenes], file=paste(outdir, "RMGenes.txt", sep="/"), row.names=F, col.names=F, quote=F)
	}  
	if (sum(!gsg$goodSamples)>0){
		write.table(names(datExpr0)[!gsg$goodSamples], file=paste(outdir, "RMSamples.txt", sep="/"), row.names=F, col.names=F, quote=F)
}
# Remove the offending genes and samples from the data
	datExpr0 <- datExpr0[gsg$goodSamples, gsg$goodGenes]
}

# To see if there are any obvious outlier by constructing tree based on the expression values
sampleTree <- flashClust(dist(datExpr0,method='manhattan'), method = "average")
pdf(file=paste(outdir,"sampleClustering.pdf", sep="/"), width = 12, height = 9)
sizeGrWindow(12, 9)
par(cex = 1)
par(mar = c(2, 4, 2, 0))
plot(sampleTree, main = "Sample cluster", sub="", xlab="", cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.5)
cutHeights <- 20000000
abline(h=cutHeights, col="red")
dev.off()