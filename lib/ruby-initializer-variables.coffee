'use babel';

{ CompositeDisposable } = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace',
      'ruby-initializer-variables:define': => @defineVariables()

  deactivate: ->
    @subscriptions.dispose()


  defineVariables: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      variables = selection.split(',')
      editor.moveToEndOfLine()
      for variable in variables
        variable = variable.trim()
        editor.insertText("\n  @" + variable + " = " + variable)
