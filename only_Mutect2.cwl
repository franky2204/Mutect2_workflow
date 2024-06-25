#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  sam_input: File
  threads: int?


outputs:
  bam_indexed:
    type: File
    outputSource: pre_mutect2/bam_indexed


steps:
  pre_mutect2:
    run: cwl/S2PMutect2.cwl
    in:
      sam_input: sam_input
      threads: threads
    out: [bam_indexed]



