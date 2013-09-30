class __View.Task extends Monocle.View
  

  template  : """
    <li data-icon="{{#done}}ok-sign{{/done}}{{^done}}circle-blank{{/done}}">
      <span class="{{#done}}icon ok-sign{{/done}}{{^done}}icon circle-blank{{/done}}"></span>
      <div class="on-right">{{list}}</div>
      <strong>{{name}}</strong>
      <small>{{description}} - {{when}}</small>
    </li>
  """

  constructor: ->
    super
    __Model.Task.bind "update", @bindTaskUpdated
    @append @model 
    
  events:
    "swipeLeft li"  :  "onDelete"
    "hold li"       :  "onDone"
    "singleTap li"  :  "onView"

  elements:
    "input.toggle"  : "toggle"

  bindTaskUpdated: (task) =>
    if task.uid is @model.uid
      @refresh()

  onDone: (event) ->
    
    Lungo.Notification.confirm
      icon: "user"
      title: "Realizar Tarea"
      description: "¿Esta seguro de querer poner la tarea como realizada?"
      accept:
        icon: "checkmark"
        label: "Accept"
        callback: ()=>
          @model.done =  !@model.done
          @model.save()
          @refresh()

      cancel:
        icon: "close"
        label: "Cancel"
        callback: =>
          @
    
  onDelete: (event) ->
    Lungo.Notification.confirm
      icon: "user"
      title: "Eliminar tarea"
      description: "¿Esta seguro de querer eliminar la tarea?"
      accept:
        icon: "checkmark"
        label: "Accept"
        callback: ()=>
          @remove()
          @model.destroy()      
          
      cancel:
        icon: "close"
        label: "Cancel"
        callback: ->
          @


  onView: (event) ->
    __Controller.Task.show @model
