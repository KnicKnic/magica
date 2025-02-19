import { File, main, Result, RunResult } from 'magica'
import { Example, examples, sampleImages } from "./examples"

export interface State {
  example: Example
  inputFiles: File[]
  examples: Example[];
  result: RunResult|undefined
  script: string
  working: boolean
  showAllResultsOutput:boolean
}

export interface ParserError {
  line: number
  column: number
  msg: string
  e: any
}

export async function getInitialState(): Promise<State> {
  var example = examples[0]
  var image = await File.fromUrl(example.inputFiles.length ? example.inputFiles[0]: sampleImages[0])
  return {
    example,
    inputFiles: [image],
    examples,
    result: null as any,
    script: '',
    working: false,
    showAllResultsOutput:false
  }
}
