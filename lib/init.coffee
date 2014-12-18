path = require 'path'

module.exports =
  configDefaults:
    lscExecutablePath: path.join __dirname, '..', 'node_modules', 'LiveScript',
      'bin'

  activate: ->
    console.log 'activate linter-lsc'
