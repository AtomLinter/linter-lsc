'use babel';

import { join } from 'path';
import {
  // eslint-disable-next-line no-unused-vars
  it, fit, wait, beforeEach, afterEach,
} from 'jasmine-fix';

const fixturePath = join(__dirname, 'fixtures');
const goodPath = join(fixturePath, 'good.ls');
const referencePath = join(fixturePath, 'reference_error.ls');
const syntaxPath = join(fixturePath, 'syntax_error.ls');

describe('The lsc provider for Linter', () => {
  const { lint } = require('../src/').provideLinter();

  beforeEach(async () => {
    // Info about this beforeEach() implementation:
    // https://github.com/AtomLinter/Meta/issues/15
    const activationPromise = atom.packages.activatePackage('linter-lsc');

    await atom.packages.activatePackage('language-livescript');

    atom.packages.triggerDeferredActivationHooks();
    await activationPromise;
  });

  it('should be in the packages list', () => {
    expect(atom.packages.isPackageLoaded('linter-lsc')).toBe(true);
  });

  it('should be an active package', () => {
    expect(atom.packages.isPackageActive('linter-lsc')).toBe(true);
  });

  it('reports a ReferenceError in reference_error.ls', async () => {
    const editor = await atom.workspace.open(referencePath);
    const messages = await lint(editor);
    const message = 'Inconsistent use of aFunctionName as a-functionName';

    expect(messages.length).toBe(1);
    expect(messages[0].severity).toBe('error');
    expect(messages[0].excerpt).toBe(message);
    expect(messages[0].location.file).toBe(referencePath);
    expect(messages[0].location.position).toEqual([[2, 0], [2, 21]]);
  });

  it('reports a SyntaxError in syntax_error.ls', async () => {
    const editor = await atom.workspace.open(syntaxPath);
    const messages = await lint(editor);
    const message = "Unexpected '...'";

    expect(messages.length).toBe(1);
    expect(messages[0].severity).toBe('error');
    expect(messages[0].excerpt).toBe(message);
    expect(messages[0].location.file).toBe(syntaxPath);
    expect(messages[0].location.position).toEqual([[1, 0], [1, 28]]);
  });

  it('finds nothing wrong with a valid file', async () => {
    const editor = await atom.workspace.open(goodPath);
    const messages = await lint(editor);
    expect(messages.length).toBe(0);
  });
});
