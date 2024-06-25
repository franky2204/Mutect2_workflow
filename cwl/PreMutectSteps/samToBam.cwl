cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: fpant/gatk

baseCommand: ["samtools", "view", "-b"]


inputs:
  sam_add:
    type: File
    inputBinding:
      position: 1
  threads: 
    type: int?
    default: 2
    inputBinding:
      position: 2
      prefix: '-@'
  output: 
    type: string?
    default: "file_add.bam"
    inputBinding:
      position: 3
      prefix: -o
 
     
outputs:
  bam_output:
    type: File
    outputBinding:
      glob: "*.bam"
      outputEval: ${
        self[0].basename = inputs.sam_add.nameroot + ".bam";
        return self; }
