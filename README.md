[Linter]: https://github.com/AtomLinter/Linter
[LiveScript]: http://livescript.net/
[lsc]: http://livescript.net/#usage

# linter-coffeelint

This linter plugin for [Linter][] provides an interface to [lsc][]. It will be used with files that have the "[LiveScript][]" syntax.

## Installation

Linter package must be installed in order to use this plugin. If Linter is not installed, please follow the instructions [here][Linter].

### Plugin installation

```
$ apm install linter-lsc
```

## Settings

You can configure linter-coffeelint by editing ~/.atom/config.cson (choose Open Your Config in Atom menu):

```
'linter-lsc':
  'lscExecutablePath': null #lsc path. run 'which lsc' to find the path to the directory that holds the executable
```

**Note:** This plugin finds the nearest coffeelint.json file and uses the `-f` command line argument to use that file, so you may not use the `-f` argument in the linter settings.

## Contributing

If you would like to contribute enhancements or fixes, please do the following:

1. Fork the plugin repository.
2. Hack on a separate topic branch created from the latest master.
3. Commit and push the topic branch.
4. Make a pull request.
5. welcome to the club

Please note that modifications should follow these coding guidelines:

1. Indent is 2 spaces.
2. Code should pass coffeelint linter.
3. Vertical whitespace helps readability, don’t be afraid to use it.

Thank you for helping out!
