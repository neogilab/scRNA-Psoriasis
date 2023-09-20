#!/bin/bash -l
#SBATCH -A snic2022-22-***
#SBATCH -p node
#SBATCH -n 2
#SBATCH -t 16:00:00
#SBATCH -J cellphoneDB_SkinBlood
module load bioinfo-tools
module load R_packages
conda activate /proj/snic2022-22-***/nobackup/cellphone_env2
cellphonedb method statistical_analysis all_meta_3.txt all_combined_3.txt --counts-data=gene_name
cellphonedb plot dot_plot --columns in/Neu_other_cells_15dec2022.txt --rows in/Rows_selected.txt --output-name dotplot_Neu_other_cells_15dec2022.pdf
cellphonedb plot heatmap_plot all_meta_BloodNeu_SkinNeu.txt --log-name heatmap_selected_columns_log.pdf
