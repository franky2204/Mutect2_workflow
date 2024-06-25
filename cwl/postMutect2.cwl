#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  mutect_vcf: 
    type:
      type: array
      items: File

outputs:
  vcf_merged:
    type: File
    outputSource: vcf_merge/vcf_merged

steps:
  extract_vcf:
    run: PostMutectSteps/extractVcf.cwl
    scatter: mutect_vcf
    in:
      mutect_vcf: mutect_vcf
    out: [vcf_uncompressed]
  bgzip_run:
    run: PostMutectSteps/bgzipRun.cwl
    scatter: vcf_uncompressed
    in:
      vcf_uncompressed: extract_vcf/vcf_uncompressed
    out: [bgzip_vcf]
  tabix_run:
    run: PostMutectSteps/tabixVcf.cwl
    scatter: bgzip_vcf
    in:
      bgzip_vcf: bgzip_run/bgzip_vcf
    out: [tabix_vfc]
  vcf_merge:
    run: PostMutectSteps/vcfMerge.cwl
    in:
      tabix_vfc: tabix_run/tabix_vfc
    out: [vcf_merged]