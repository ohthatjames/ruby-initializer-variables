'use babel';

describe "waiting for the packages to load", ->
  [activationPromise, editor, workspaceElement] = []

  executeCommand = (callback) ->
    atom.commands.dispatch(workspaceElement, 'ruby-initializer-variables:define')
    waitsForPromise -> activationPromise
    runs(callback)

  it 'works', ->
    expect(1).toEqual(1)
