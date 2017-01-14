'use babel';

describe "waiting for the packages to load", ->
  [activationPromise, editor, workspaceElement] = []

  executeCommand = (callback) ->
    atom.commands.dispatch(workspaceElement, 'ruby-initializer-variables:define')
    waitsForPromise -> activationPromise
    runs(callback)

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      workspaceElement = atom.views.getView(atom.workspace)
      activationPromise = atom.packages.activatePackage('ruby-initializer-variables')

  it 'creates instance variables for the selected arguments', ->
    body = "def initialize(arg1, arg2)\nend"
    editor.setText(body)
    editor.setSelectedBufferRange([[0, body.indexOf("arg1")], [0, body.indexOf(")")]])
    executeCommand ->
      expect(editor.getText()).toEqual "def initialize(arg1, arg2)\
        \n  @arg1 = arg1\
        \n  @arg2 = arg2\
        \nend"
