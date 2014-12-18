{resolve} = require 'path'

module.exports =
  configDefaults:
    lscExecutablePath: resolve __dirname, '..', 'node_modules', 'LiveScript',
      'bin'

  activate: ->
    console.log 'activate linter-lsc'
