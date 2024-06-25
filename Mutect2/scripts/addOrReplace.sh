file=$1
filename=$(basename $file)
filename_no_ext="${filename%.*}"

gatk  AddOrReplaceReadGroups -I $1 \
      -O $filename_no_ext"_sam_add.sam" \
      --RGLB lib3 \
      --RGPL ILLUMINA \
      --RGPU unit_$filename_no_ext \
      --RGSM sample_$filename_no_ext \
    