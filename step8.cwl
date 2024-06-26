#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}  
  
inputs:
    mutect_fused:  
        type: File
    human_grch38:
        type: File
  
outputs:
    results:
      type: File
      outputSource: filter_vcf/vcf_filtered
    results_trascript:
      type: File
      outputSource: filter_vcf/vcf_filtered_trascript   
 
steps:

  from_vcf_tsv:
    run: cwl/lastStep/fromVcfToTsv.cwl
    in:
        mutect_fused: mutect_fused
    out: [mutect_tsv]
  create_tab:
    run: cwl/lastStep/createTab.cwl
    in:
        mutect_tsv: from_vcf_tsv/mutect_tsv
    out: [daniela]
  final_results:
    run: cwl/lastStep/finalResults.cwl
    in:
        daniela: create_tab/daniela
        human_grch38: human_grch38
    out: [results, results_trascript]