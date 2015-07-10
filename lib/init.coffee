{resolve} = require 'path'
{BufferedProcess, CompositeDisposable} = require 'atom'

module.exports =
  config:
    lscExecutablePath:
      default: resolve __dirname, '..', 'node_modules', 'livescript'
      title: 'lsc Executable path'
      type: 'string'

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-lsc.lscExecutablePath',
      (executablePath)=>
        @executablePath = executablePath

  deactivate: ->
    @subscriptions.dispose()

  provideLinter: ->
    grammarScopes: ['source.livescript']
    scope: 'file'
    lintOnFly: true
    lint: (textEditor)=>
      new Promise (resolve, reject)=>
        lsc = require @executablePath
        filePath = textEditor.getPath()
        fileText = textEditor.getText()
        try
          lsc.compile fileText
          resolve []
        catch err
          result = /Parse error on line (\d+): (.*)/.exec err.message
          messages = [
            type: 'Error'
            text: result[2]
            filePath: filePath
            range: [
              [parseInt(result[1])-1, 0]
              [parseInt(result[1]), 0]
            ]
          ]
          resolve messages

        process.onWillThrowError ({error, handle})=>
          atom.notifications.addError "Failed to run #{@lscExecutablePath}",
            detail: error.message
            dismissable: true
          handle()
          resolve []
