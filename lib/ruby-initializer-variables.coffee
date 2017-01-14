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
    console.log('Hello world!')
