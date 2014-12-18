linterPath = atom.packages.getLoadedPackage('linter').path
Linter = require "#{linterPath}/lib/linter"

class LinterLsc extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: 'source.livescript'

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: 'lsc -a'

  linterName: 'lsc'

  # A regex pattern used to extract information from the executable's output.
  regex: '\\[Error: Parse error on line (?<line>\\d+): (?<message>.+)\\]'

  errorStream: 'stderr'

  constructor: (editor) ->
    super(editor)
    atom.config.observe 'linter-lsc.lscExecutablePath', =>
      @executablePath = atom.config.get 'linter-lsc.lscExecutablePath'

  destroy: ->
    atom.config.unobserve 'linter-lsc.lscExecutablePath'

module.exports = LinterLsc
