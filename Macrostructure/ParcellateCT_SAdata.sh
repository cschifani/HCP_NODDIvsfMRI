#!/bin/bash -l
#
# module load FSL/6.0.0
# module load freesurfer/6.0.0
# module load connectome-workbench/1.3.2
#
#RERUN 13Aug 2021 CT without curvature!!!!!

for subj in `cat /projects/cschifani/HCP/surface_results/cortical/ODI_NDI_BOLD_maps_750/sub750.txt`; do
#for subj in 994273; do
echo "working on" ${subj}

#indir=/projects/cschifani/HCP/dMRI_data_surface/NODDItoMNI/${subj}
outdir=/projects/cschifani/HCP/structure_surface/${subj}
#surface=/scratch/cschifani/HCP/Structural_Preprocessed/${subj}/MNINonLinear/Native
surface32k=/scratch/cschifani/HCP/Structural_Preprocessed/${subj}/MNINonLinear/fsaverage_LR32k
#surface_ROI=/scratch/cschifani/HCP/Structural_Preprocessed/${subj}/MNINonLinear/ROIs
#shen=/projects/colin/AA_cvs_avg35_inMNI152/MNINonLinear/fsaverage_LR32k/shen268_HCPS900.dlabel.nii
results=/projects/cschifani/HCP/surface_results/cortical/CT_750


if [ ! -d ${outdir} ]; then
  mkdir $outdir
fi


cd ${outdir}

#CT
wb_command -cifti-parcellate ${surface32k}/${subj}.thickness.32k_fs_LR.dscalar.nii /projects/janderson/PACTMD/pipelines/NODDI_mdt/surface/Glasser.dlabel.nii COLUMN ${subj}_thickness.32k_fs_LR.pscalar.nii

wb_command -cifti-convert -to-text ${subj}_thickness.32k_fs_LR.pscalar.nii ${subj}_thickness.32k.csv

#SA
wb_command -cifti-parcellate ${subj}_pial_32k_combined.dscalar.nii /projects/janderson/PACTMD/pipelines/NODDI_mdt/surface/Glasser.dlabel.nii COLUMN ${subj}_surfArea.32k_fs_LR.pscalar.nii

wb_command -cifti-convert -to-text ${subj}_surfArea.32k_fs_LR.pscalar.nii ${subj}_surfArea.32k.csv

echo ${subj} `cat ${subj}_thickness.32k.csv` >> ${results}/thickness_noCurv.32k_all.csv
echo ${subj} `cat ${subj}_surfArea.32k.csv` >> ${results}/SurfArea.32k_all.csv

done




