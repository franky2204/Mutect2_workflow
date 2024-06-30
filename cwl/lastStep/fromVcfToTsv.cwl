cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: 
    listing:
      - entry: $(inputs.mutect_fused)
        writable: True

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["mv"]

inputs:
    mutect_fused:
        type: File
        inputBinding:
            position: 1
    output:
        type: string?
        default: "mutect_fused.tsv"
        inputBinding:
            position: 2
outputs:
    mutect_tsv:
        type: File
        outputBinding:
            glob: "mutect_fused.tsv"