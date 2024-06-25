#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  sam_input: File

outputs:
  bam_output:
    type: File
    outputSource: pre_mutect2/sam_add
steps:
  pre_mutect2:
    run: cwl/PreMutectSteps/addOrReplace2.cwl
    in:
      sam_input: sam_input
    out: [sam_add]
