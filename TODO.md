## TODO / Road map

- [ ] performance tests in the browser
- [ ] consume input image from stream (only node.js ?)and support stdin . same for output / stdout
- [ ] fix npm run test-js  
- [ ] emscripten port generation configurable
- [ ] fix format tests (broken with new wasm)
- [ ] test fftw
- [ ] test mng animations (A PNG-like Image Format Supporting Multiple Images, Animation and Transparent JPEG. Requires libpng-1.0.)
- [ ] test webp
- [ ] CLI options for run({script})
- [ ] I should be able to make output files protected y config.
- [ ] run scriptListener  . finish and test it or drop it
- [ ] verify support IM command quoted arguments
- [ ] test mkdir -p for output files   
- [ ] because options are global - sending commands concurrently could fail. Solution: queue or instance options
- [ ] verify montage and other commands than convert and identify (montage is special with files?)
- [ ] an easy to use API for web-workers
- [ ] verify web worker  passing files is optimal (verify transferable/shared array buffers/optimal)
- [ ] scripts/generateImEnum.ts we should execute our CLI to extract 
- [ ] remove all logic from imageMagick/compiled/nodeMagick.js to separate.ts file
- [ ] adapt executeVirtualCommand from wasm-imagemagick own branch
- [ ] test and document protected files feature
- [ ] should magica support running native IM executable in node if they are present ?  
- [ ] improve errors thrown when there's a missing file, currently it fails silently.
- [w] document run() scripts and supported syntax
  - [ ] document  script pre processors API
- [ ] document custom commands
- [ ] Module.onAbort - listener API - also use it to build the Result return value.
- [ ] document script templates infrastructure, syntax, examples, building helpers, how to add new helpers, how to add new properties to the context. 
- [x] IM itself already supports loading images from URLS - delegate that to it:  convert  http://www.ict.griffith.edu.au/anthony/images/anthony_castle.gif -resize 100x100 castle_logo.png
- [x] Module.onAbort
- [x] emscripten port generation automatized
- [x] custom commands - any command surrounded by curly braces will be evaluated as  a js function: `{  this.pushStdout(...FS.readdir('.')) }`
- [x] apidocs
- [x] template should allow to add custom functions to the context
- [x] compile time templates and run time templates w different syntax 
- [x] adapt executeCommandPreprocessor and command template preprocessor from wasm-imagemagick own branch
- [x] travis
- [x] coverage
- [x] imageBuiltIn() to get all IM built-in images like rose:)
- [x] run() script like executions uses main to run several commands feeding from previous output supporting syntax sugar
  - [x] fix issue with long operations and add more tests
  - [x] support multiple line string commands like in src/main/command.ts
- [x] rich command syntax (src/main/command)
  - [x] end porting tests
- [x] imagePixelColor()
- [x] imageCompare()
- [x] extractImageInfo()
- [x] test from a real-app - check missing exported APIs - npm install usability
- [x] playground
- [x] webworker example & recipe (see test-browser/webWorker)
- [x] format tests
- [x] Performance tests (can we measure also memory consumption?)
- [x] browser tests
- [x] support input images from URLS both in node and browser.
- [x] node.js : work directly in user's filesystem without copying to emc FS: 
- [x] browser
- [x] CLI
- [x] CLI tests
- [x] Input file from url

### problems descriptions:

#### a doubt about templates - do we really need two types of templates ? compile time and runtime - or just with compilet time is enough? templates:

TLDR: wr support both compile tme and tuntime templates - but in general users won't need these later. Also runtime templates require to be all the declaration in the same line of code. 
- [x] We will try to solve all scripting problems just with templates and not implement virtual commands or extra syntax since that would not be KISS. Nevertheless static templates can not accomplish all situations, in general when you meed concrete values new commands (at runtime - not a compile time) are need - templates are evaluated at compile time (For example, I want to protect imperatively one command's output file). But still we will try to solve this only with templates  so we don't have to parse any script code. The only way to support it without virtual commands is by adding event emitter in run() to protect files when they are created if needed

- [ ] two different types of templates are supported: 
    * **compile time** . These are evaluated when `run()` is called, using the script text as a whole
    
    ones evaluated at "compile time" with the ones that are evaluated at compile time - this is when the script is evaluated when you function `run()` is
- [x] ideas for script templates: 

``` 
var result = await run({script:`convert <%= await resolve('foo.png') -scale <%= width('foo.png')/2 %> output.<%=inputFiles[0].extension%>`, inputFiles: [File.resolve('y.gif')]} 
```



### Ideas

- [ ] https://github.com/charto/nbind/ - "easily" generate a js API accessing directly C/C++ code. Also support targeting asm.js , wasm or native. Try to make a simple API for magick++

- [?] Option for Node.js users to work/mount current directory - the tool should not copy input files just use them since are present in mount root ems

- [ ] drawing svg. is not documented and seems the official way is doing it using mvg. But... what if we convert all shapes to paths, use svgo to reduce the number to (even single ) path and use draw to draw them. syntax seems to be compatible... This way we should have yet another method of rasterize a svg, but this time to any format. I wonder what the speed is compared to other rasterize methods, if we target .ma
- [?] how high level scripts DDD can be integrated ? different project ?

- [ ] can we perform similar algorithm as geometrize with IM? this is interesting use-case since the objective is performance, reuse files so we need an api for:
  * prevent/ control file removal
  * commands to write/modify/access existing files
    two api alternatives:
       - Mode like / options - options.reuseFiles or options.preventFileRemove that wont write or remove files (user responsibility)
       - per file attribute "readonly"
           - an API to mark certain files or folders as readonly so they cannot me touched by convert commands. 
              - so i can create a folder and work there.
              - I can pass options.forceFileOverride to explicitly allow modifications by convert.
  * could start with random drawings and image compare (whole image or the local area)

 * check these: to render in CLI ?    ISOBRL	W	ISO/TR 11548-1 BRaiLle	Uses juxtaposition of 8-dot braille patterns (thus 8x2 dot matrices) to reproduce images, using the ISO/TR 11548-1 Braille encoding.
ISOBRL6	W	ISO/TR 11548-1 BRaiLle 6 dots	Uses juxtaposition of 6-dot braille patterns (thus 6x2 dot matrices) to reproduce images, using the ISO/TR 11548-1 Braille encoding.