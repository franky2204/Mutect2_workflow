final_string=""
for arg in "$@"; do
  final_string+=" $arg"
done

vcf-merge $final_string > fusion.vcf