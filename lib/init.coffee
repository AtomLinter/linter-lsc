{resolve} = require 'path'

module.exports =
  config:
    lscExecutablePath:
      default: resolve __dirname, '..', 'node_modules', 'LiveScript', 'bin'
      title: 'lsc Executable path'
      type: 'string'

  activate: ->
    console.log 'activate linter-lsc'
