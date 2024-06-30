cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: 

baseCommand: ["bwa", "mem"]

inputs:
  genome:
    doc: "genome in use"
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
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2

stdout: $(input.read_1).sam

outputs:
  sam_file:
    type: File
    outputBinding:
      glob: "*.sam"