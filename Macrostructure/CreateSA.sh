#!/bin/bash -l
#
# module load connectome-workbench/1.3.2
#

#for subj in `cat /projects/cschifani/HCP/surface_results/cortical/ODI_NDI_BOLD_maps_750/sub750.txt`; do

#for subj in `cat /KIMEL/tigrlab/scratch/cschifani/list_S900_HCP.txt`; do
for subj in 129533; do

echo "working on" ${subj}

#indir=/external/rprshnas01/public_datasets/HCP/HCP_S900/$subj/T1w/fsaverage_LR32k
indir=/scratch/cschifani/HCP_S900/HCP_S900/$subj/T1w/fsaverage_LR32k/
#outdir=/KIMEL/tigrlab/projects/cschifani/HCP/surface_results/cortical/surfaceArea
outdir=/projects/cschifani/HCP/surface_results/cortical/surfaceArea/$subj

if [ ! -d ${outdir} ]; then
  mkdir $outdir
fi

cd $outdir

wb_command -surface-vertex-areas $indir/${subj}.L.pial.32k_fs_LR.surf.gii ${subj}.L.pial.32k_fs_LR.shape.gii

wb_command -surface-vertex-areas $indir/${subj}.R.pial.32k_fs_LR.surf.gii ${subj}.R.pial.32k_fs_LR.shape.gii


wb_command -cifti-create-dense-scalar  ${subj}_pial_32k_combined.dscalar.nii -left-metric ${subj}.L.pial.32k_fs_LR.shape.gii -right-metric ${subj}.R.pial.32k_fs_LR.shape.gii

done