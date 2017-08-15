'use babel';

// Dependencies
let helpers;
let lsc;

const loadDeps = () => {
  if (!helpers) {
    helpers = require('atom-linter');
  }
  if (!lsc) {
    lsc = require('livescript');
  }
};

module.exports = {
  activate() {
    this.idleCallbacks = new Set();
    let depsCallbackID;
    const installLinterJSHintDeps = () => {
      this.idleCallbacks.delete(depsCallbackID);
      if (!atom.inSpecMode()) {
        require('atom-package-deps').install('linter-lsc');
      }
      loadDeps();
    };
    depsCallbackID = window.requestIdleCallback(installLinterJSHintDeps);
    this.idleCallbacks.add(depsCallbackID);
  },

  deactivate() {
    this.idleCallbacks.forEach(callbackID => window.cancelIdleCallback(callbackID));
    this.idleCallbacks.clear();
  },

  provideLinter() {
    return {
      name: 'livescript',
      grammarScopes: ['source.livescript'],
      scope: 'file',
      lintsOnChange: true,
      lint: async (textEditor) => {
        const filePath = textEditor.getPath();
        const fileContents = textEditor.getText();

        loadDeps();

        let line;
        let message;
        try {
          lsc.compile(fileContents);
        } catch (err) {
          if (err instanceof SyntaxError || err instanceof ReferenceError) {
            const result = /(.+) on line (\d+)$/.exec(err.message);
            line = Number.parseInt(result[2], 10) - 1;
            message = result[1];
          } else {
            const result = /Parse error on line (\d+): (.+)/.exec(err.message);
            line = Number.parseInt(result[1], 10) - 1;
            message = result[2];
          }
        }

        if (!message) {
          // lsc didn't throw an error
          return [];
        }

        if (textEditor.getText() !== fileContents) {
          // File has changed since the lint was triggered, tell Linter not to update
          return null;
        }

        return [{
          severity: 'error',
          excerpt: message,
          location: {
            file: filePath,
            position: helpers.generateRange(textEditor, line),
          },
        }];
      },
    };
  },
};
