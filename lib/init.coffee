{BufferedProcess, CompositeDisposable} = require 'atom'
lsc = require 'atom-livescript'

module.exports =
  activate: ->
    require('atom-package-deps').install 'linter-lsc'

  provideLinter: ->
    grammarScopes: ['source.livescript']
    scope: 'file'
    lintOnFly: true
    lint: (textEditor)=>
      new Promise (resolve, reject)=>
        filePath = textEditor.getPath()
        fileText = textEditor.getText()
        try
          lsc.compile fileText
          resolve []
        catch err
          result = switch
            when err instanceof SyntaxError
              r = /(.*) on line (\d+)$/.exec err.message
              line: r[2]
              text: r[1]
            else
              r = /Parse error on line (\d+): (.*)/.exec err.message
              line: r[1]
              text: r[2]
          messages = [
            type: 'Error'
            text: result.text
            filePath: filePath
            range: [
              [parseInt(result.line)-1, 0]
              [parseInt(result.line), 0]
            ]
          ]
          resolve messages

        process.onWillThrowError ({error, handle})=>
          atom.notifications.addError "Failed to run lsc",
            detail: error.message
            dismissable: true
          handle()
          resolve []
