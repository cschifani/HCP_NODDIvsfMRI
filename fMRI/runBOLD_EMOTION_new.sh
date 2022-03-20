#!/bin/bash -l

#module use /projects/edickie/privatemodules/
#module load ciftify/201902

#saves file in directory you run this from

cd /projects/cschifani/HCP/

shen=/projects/colin/AA_cvs_avg35_inMNI152/MNINonLinear/fsaverage_LR32k/shen268_HCPS900.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat subj_first100.txt`; do
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/EMOTION/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

done

wb_command -cifti-merge all_EMOTION_100.dtseries.nii ${args}

ciftify_meants all_EMOTION_100.dtseries.nii ${shen}




#all HCP with dMRI and fMRi scans
glasser=/projects/cschifani/HCP/dMRI_data_surface/templates/Glasser.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat /projects/cschifani/HCP/bothScansTrue.txt`; do

  if [ -r ${basedir}${k}/EMOTION/tstat1.dtseries.nii ]; then
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/EMOTION/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

 fi

done

wb_command -cifti-merge all_EMOTION_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_EMOTION_100.dtseries.nii ${glasser}



#all HCP with dMRI and fMRi scans
cole=/projects/cschifani/HCP/Cole_atlas/ColeAnticevicNetPartition-master/CortexSubcortex_ColeAnticevic_NetPartition_wSubcorGSR_parcels_LR.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat /projects/cschifani/HCP/bothScansTrue.txt`; do

  if [ -r ${basedir}${k}/EMOTION/tstat1.dtseries.nii ]; then
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/EMOTION/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff >> usedIDs.txt

 fi

done

wb_command -cifti-merge all_EMOTION_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_EMOTION_100.dtseries.nii ${cole}



#all HCP with dMRI and fMRi scans
subcort=/scratch/cschifani/HCP/Structural_Preprocessed/${k}/MNINonLinear/ROIs/Atlas_ROIs.2.nii.gz
outdir=/projects/cschifani/HCP/surface_results/subcortical/fMRI/${k}
basedir=/scratch/colin/HCP900/data8/

#for k in 100206; do
for k in `cat /projects/cschifani/HCP/bothScansTrue.txt`; do

  echo 'working on '${k}

  if [ ! -d ${outdir} ]; then
    mkdir $outdir
  fi

  cd ${basedir}${k}/EMOTION/
  cp tstat1.dtseries.nii $outdir/${k}_tstat1.dtseries.nii
  cd $outdir
  ciftify_meants --outputlabels  labels.csv ${k}_tstat1.dtseries.nii $subcort

  echo ${k} `cat ${k}_tstat1_Atlas_ROIs.2_meants.csv` >> /projects/cschifani/HCP/surface_results/subcortical/BOLD_Participants.csv

done
