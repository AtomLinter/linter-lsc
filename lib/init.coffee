{BufferedProcess, CompositeDisposable} = require 'atom'
lsc = require 'atom-livescript'

module.exports =
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
          atom.notifications.addError "Failed to run lsc",
            detail: error.message
            dismissable: true
          handle()
          resolve []
