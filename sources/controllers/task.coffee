class TaskCtrl extends Monocle.Controller

  elements:
    "input[name=name]"          : "name"
    "textarea[name=description]": "description"
    ######"input[name=list]"          : "list"
    "select[name=list]"        : "list"
    "select[name=when]"         : "when"
    "input[name=important]"     : "important"

  events:
    "click [data-action=save]"  : "onSave"

  constructor: ->
    super
    @new = @_new
    @show = @_show
      
  # Events
  onSave: (event) ->
    if @current
      # Save

      @current.name        = @name.val()
      @current.description = @description.val()
      @current.list        = $("#lista").val()
      @current.when        = $("#fecha").val()
      @current.important   = @important[0].checked
      @current.save()
      ###
      if @current.important is @important[0].checked
        @current.save()
      else 
      ###
    else
      # New task

      Lungo.Notification.show()
      __Model.Task.create
        name        : @name.val()
        description : @description.val()
        list        : $("#lista").val()
        when        : $("#fecha").val()
        important   : @important[0].checked

  # Private Methods
  _new: (@current=null) ->
    ###Con esto se borran los valores de los campos###
    @name.val ""
    @description.val ""
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description
    @list.val @current.list
    @important[0].checked = @current.important
    Lungo.Router.section "task"

$$ ->
  __Controller.Task = new TaskCtrl "section#task"
