#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  mutect_vcf:  
    type:
      type: array
      items: File

outputs:
  merged_vcf:
    type: File
    outputSource: merge_vcf/vcf_merged
  vcf_filtered:
    type: File
    outputSource: filter_vcf/vcf_filtered

steps:
  merge_vcf:
    run: cwl/postMutect2.cwl
    in:
        mutect_vcf: mutect_vcf
    out: [vcf_merged]
  filter_vcf:
    run: cwl/filterMutect2.cwl
    in:
        mutect_vcf: merge_vcf/vcf_merged
    out: [vcf_filtered]