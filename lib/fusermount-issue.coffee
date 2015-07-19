FusermountIssueView = require './fusermount-issue-view'
{CompositeDisposable} = require 'atom'

exec = require('child_process').exec
util = require 'util'

module.exports = FusermountIssue =
  fusermountIssueView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @fusermountIssueView = new FusermountIssueView(state.fusermountIssueViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @fusermountIssueView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'fusermount-issue:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @fusermountIssueView.destroy()

  serialize: ->
    fusermountIssueViewState: @fusermountIssueView.serialize()

  toggle: ->
    console.log 'FusermountIssue was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

      mountpath = "/home/wagoodman/.atom/mounts/localhost/tmp"
      hostname = "localhost"
      directory = "/tmp"
      username = "wagoodman"
      keyfile = "/home/wagoodman/.ssh/id_rsa"

      console.log 'Mounting...'

      command = util.format "sshfs -o IdentityFile=%s -o cache=yes -o StrictHostKeyChecking=no %s@%s:%s %s", keyfile, username, hostname, directory, mountpath
      exec command, (error, stdout, stderr) ->
         console.log [error, stdout, stderr]
         atom.notifications.add('error', ""+[error, stdout, stderr])
