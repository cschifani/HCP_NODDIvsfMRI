
#!/bin/bash -l

#module load /projects/edickie/privatemodules/ciftify/201902

#saves file in directory you run this from

cd /projects/cschifani/HCP/


#first 100
shen=/projects/colin/AA_cvs_avg35_inMNI152/MNINonLinear/fsaverage_LR32k/shen268_HCPS900.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat /projects/cschifani/HCP/subj_first100.txt`; do
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/WM/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

done

wb_command -cifti-merge all_WM_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_WM_100.dtseries.nii ${shen}


# second 100
shen=/projects/colin/AA_cvs_avg35_inMNI152/MNINonLinear/fsaverage_LR32k/shen268_HCPS900.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat /projects/cschifani/HCP/subj_second100.txt`; do
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/WM/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

done

wb_command -cifti-merge all_WM_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_WM_100.dtseries.nii ${shen}





#all HCP with dMRI and fMRi scans
shen=/projects/colin/AA_cvs_avg35_inMNI152/MNINonLinear/fsaverage_LR32k/shen268_HCPS900.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""

for k in `cat /projects/cschifani/HCP/bothScansTrue.txt`; do
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/WM/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

done

wb_command -cifti-merge all_WM_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_WM_100.dtseries.nii ${shen}



#all HCP with dMRI and fMRi scans
glasser=/projects/cschifani/HCP/dMRI_data_surface/templates/Glasser.dlabel.nii
basedir=/scratch/colin/HCP900/data8/

args=""d

for k in `cat /projects/cschifani/HCP/bothScansTrue.txt`; do
 # got to participant HCP dir with working memory
 ff=${basedir}${k}/WM/tstat1.dtseries.nii
 args="${args} -cifti $ff"
 ls $ff

done

wb_command -cifti-merge all_WM_100.dtseries.nii ${args}

ciftify_meants --outputlabels  labels.csv all_WM_100.dtseries.nii ${glasser}
