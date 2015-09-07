[Linter]: https://github.com/AtomLinter/Linter
[LiveScript]: http://livescript.net/
[lsc]: http://livescript.net/#usage

# linter-lsc

This linter plugin for [Linter][] provides an interface to [lsc][]. It will be used with files that have the "[LiveScript][]" syntax.

## Installation

On first activation the plugin will install all dependencies automatically, you no longer have to worry about installing Linter.

### Plugin installation

```
$ apm install linter-lsc
```

## Settings

You can configure linter-lsc by editing ~/.atom/config.cson (choose Open Your Config in Atom menu):

```
'linter-lsc':
  'lscExecutablePath': null #lsc path. run 'which lsc' to find the path to the directory that holds the executable
```

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
