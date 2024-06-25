#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}  
  
inputs:
    mutect_vcf_unfilterd:  
      type: File
  
outputs:
    vcf_filtered:
      type: File
      outputSource: filter_vcf/vcf_filtered
 
steps:

  filter_vcf:
    run: cwl/filterMutect2C.cwl
    in:
        mutect_vcf: mutect_vcf_unfilterd
    out: [vcf_filtered]