#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  bam_output: File
  threads: int?

outputs:
  bam_sorted:
    type: File
    outputSource: sort_bam/bam_sorted
steps:
 sort_bam:
    run: cwl/PreMutectSteps/sortBam.cwl
    in:
      bam_output: bam_output
      threads: threads
    out: [bam_sorted]