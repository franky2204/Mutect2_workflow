cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["gatk", "AddOrReplaceReadGroups"]

inputs:
  sam_input:
    type: File
    inputBinding:
      position: 1
      prefix: -I
  output:
    type: string?
    default: "sam_add.sam"
    inputBinding:
      position: 2
      prefix: -O
  RGLB:
    type: string?
    default: "lib3"
    inputBinding:
      position: 3
      prefix: --RGLB
  RGPL:
    type: string?
    default: "ILLUMINA"
    inputBinding:
      position: 4
      prefix: --RGPL
  RGPU:
    type: string?
    default: $("unit"+inputs.sam_input.nameroot)
    inputBinding:
      position: 5
      prefix: --RGPU
  RGSM:
    type: string?
    default: $("sample"+inputs.sam_input.nameroot)
    inputBinding:
      position: 6
      prefix: --RGSM
    

outputs:
  sam_add:
    type: File
    outputBinding:
      glob: "sam_add.sam"
      outputEval: ${
        self[0].basename = inputs.sam_input.nameroot + "_add.sam";
        return self; }