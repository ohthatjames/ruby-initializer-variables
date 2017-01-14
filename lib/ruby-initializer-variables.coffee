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
        variable = variable.trim()
        editor.insertText("\n" + indentation + "@" + variable + " = " + variable)

  indentationForSelection: (editor, selection) ->
    initialRow = selection.start.row
    initialRowText = editor.lineTextForBufferRow(initialRow)
    indentationSize = initialRowText.match(/\s*/)[0].length + 2
    indentation = " ".repeat(indentationSize)
