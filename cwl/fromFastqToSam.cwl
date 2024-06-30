cwlVersion: v1.2
class: CommandLineTool

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: pegi3s/bwa

baseCommand: ["bwa", "mem"]

inputs:
  genome:
    doc: "Reference genome in use"
    type: File
    inputBinding:
      position: 1
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai

  read_1:
    type: File
    inputBinding:
      position: 2

  read_2:
    type: File
    inputBinding:
      position: 3
  threads:
    doc: "Max number of threads in use"
    type: int?
    default: 1
    inputBinding:
      position: 4
      prefix: "-t"

stdout: "$(inputs.read_1.basename).sam"

outputs:
  sam_input:
    type: File
    outputBinding:
      glob: "$(inputs.read_1.basename).sam"
