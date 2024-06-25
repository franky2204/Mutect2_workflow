output=$(basename "$$1")
filename_no_ext="${output%.*}"
bcftools view  -i  'MIN(FMT/DP)>20' $1 > ${filename_no_ext}_filtered.vcf
