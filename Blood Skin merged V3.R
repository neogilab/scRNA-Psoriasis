##### 13-10-2022##############################################################
library(Seurat)
library(Matrix)
library(dplyr)
library(ggplot2)

SkinBloodMerged <- readRDS("Skin_Blood_Merged.rds")
SkinBloodMerged
DimPlot(SkinBloodMerged,reduction = "umap")
table(SkinBloodMerged$NEW_Group)
tail(SkinBloodMerged@meta.data$orig.ident)
write.table(as.matrix(Idents(object = SkinBloodMerged)),'SkinBlood-Neutro_labels.txt', sep='\t', quote=F)
Blood_FINAL <- readRDS("Blood_FINAL.rds")
DimPlot(Blood_FINAL, reduction = "umap")
Blood_FINAL
Skin_FINAL <- readRDS("SKIN_FINAL.rds")
Skin_FINAL
DimPlot(Skin_FINAL, reduction = "umap")

#table(WZ.combined$WZ.celltype2)
#table(Blood_FINAL$idents)
Blood_sub <- subset(x = Blood_FINAL, idents = c("Neutrophils_1", "Neutrophils_2"), invert = TRUE)
DimPlot(Blood_sub, reduction = "umap")
Skin_sub <- subset(x = Skin_FINAL, idents = c("Neutrophils", "Antigen_presenting_neutrophils"), invert = TRUE)
DimPlot(Skin_sub, reduction = "umap")
BloodSkin.combined <- merge(Blood_sub, y=Skin_sub, add.cell.ids = c("Blood", "Skin"), project = "combined")
BloodSkin.combined
head(SkinBloodMerged@meta.data$orig.ident)
head(colnames(SkinBloodMerged))
head(colnames(BloodSkin.combined))
all.combined <- merge(BloodSkin.combined, y=SkinBloodMerged, add.cell.ids = c("Other", "Neutro"), project = "combined")
head(colnames(all.combined))

write.table(as.matrix(all.combined@assays$RNA@data),'all_combined_3.txt', sep='\t', quote=F)

meta_data <- rownames(all.combined@meta.data)
meta_data <- as.matrix(meta_data)
meta_data[is.na(meta_data)] = "Unkown" # The cell type cannot have NA
write.table(meta_data,'all_meta_3.txt', sep='\t', quote=F, row.names=F)
write.table(as.matrix(Idents(object = all.combined)),'all_combined_idents.txt', sep='\t', quote=F)
