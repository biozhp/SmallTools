## boxplot
library("ggpubr")
df <- read.table("dist_mean.txt",header=T,sep="\t")
p <- ggboxplot(df, x="Type", y="Ed",color="Type",palette=c("#ef7571","#50a5d6"),add="jitter",shape="Type")
groups <- list(c("ALandrace","Cultivar"))
p2 <- p + stat_compare_means(comparisons=groups)
ggsave(p2,filename = "p.pdf",width = 3.2,height = 4.5)

## Density
ggplot(df,aes(Ed,fill=Type, color=Type)) + geom_density(alpha = 0.6) +  theme_bw()

## 
library("ggplot2")
df <- read.table("Enr_plot.txt",header = T,sep = "\t")
df$Term=factor(df$Term,levels = unique(df$Term))
p <- ggplot(gene,aes(x = group,y = pathway,color = pvalue)) + geom_point(aes(size=Count))+scale_color_gradient(low="blue",high="red")+theme_bw()