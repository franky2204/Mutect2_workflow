#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  bam_sorted: File
  threads: int?
outputs:
  bam_indexed:
    type: File
    outputSource: index_bam/bam_indexed
steps:
 index_bam:
    run: cwl/PreMutectSteps/indexBam.cwl
    in:
        bam_sorted: bam_sorted
        threads: threads
    out: [bam_indexed]