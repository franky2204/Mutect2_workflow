#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  sam_add: File
  threads: int?

outputs:
  bam_output:
    type: File
    outputSource: sam_to_bam/bam_output
steps:
 sam_to_bam:
    run: cwl/PreMutectSteps/samToBam.cwl
    in:
      sam_add: sam_add
      threads: threads
    out: [bam_output]