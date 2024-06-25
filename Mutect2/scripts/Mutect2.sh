#inputs: 1 folder, 2 genome file(need to be indexed), 3 threads
num_args=$#
genome=$1
threads=$2

args=("${@:3}")
# Itera attraverso ogni argomento dal terzo in poi
for arg in "${args[@]}"; do
    final_string+="-I $arg "
done

gatk Mutect2 $final_string -R $genome -O Muteq_final_resoult.vcf.gz --native-pair-hmm-threads $threads