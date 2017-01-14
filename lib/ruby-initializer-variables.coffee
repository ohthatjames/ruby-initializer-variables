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
      selectionText = editor.getSelectedText()
      variables = selectionText.split(',')
      indentation = @indentationForSelection(editor, editor.getSelectedBufferRange())
      editor.moveToEndOfLine()
      for variable in variables
        variableName = @variableName(variable)
        editor.insertText("\n" + indentation + "@" + variableName + " = " + variableName)

  indentationForSelection: (editor, selection) ->
    initialRow = selection.start.row
    initialRowText = editor.lineTextForBufferRow(initialRow)
    indentationSize = initialRowText.match(/\s*/)[0].length + 2
    indentation = " ".repeat(indentationSize)

  variableName: (variable) ->
    variable = variable.trim()
    if variable.indexOf('=') > 0
      variable.substring(0, variable.indexOf('=')).trim()
    else if variable.indexOf(':') > 0
      variable.substring(0, variable.indexOf(':')).trim()
    else
      variable
