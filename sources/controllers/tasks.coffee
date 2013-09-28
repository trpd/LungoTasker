class __Controller.TasksCtrl extends Monocle.Controller

    events:
      "click [data-action=new]"    :   "onNew"

    elements:
      "#pending"    :   "pending"
      "#important"  :   "important"
      "input"                 :   "name"

    constructor: ->
      super
      __Model.Task.bind "create", @bindTaskCreated
      __Model.Task.bind "update", @bindTaskUpdated
      __Model.Task.bind "destroy", @bindTaskUpdated

    ###Esta llamando al metodo de otro controlador ###  
    onNew: (event) ->
      __Controller.Task.new()

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      new __View.Task model: task, container: "article##{context} ul"
      Lungo.Router.back()
      Lungo.Notification.hide()
      @renderTotals()

    bindTaskUpdated: (task) =>
      Lungo.Router.back()
      Lungo.Notification.hide()  
      @renderTotals()

    renderTotals: ->
      Lungo.Element.count("#pendingHeader", __Model.Task.pending().length);
      Lungo.Element.count("#importantHeader", __Model.Task.important().length);
      Lungo.Element.count("#pending", __Model.Task.pending().length);
      Lungo.Element.count("#important", __Model.Task.important().length);
      
###Esto lo que hace es comprobar si lungo esta en funcionamiento ###
$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "home", when: "2013/01/01", important: true, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "office", when: "2013/01/02", important: true, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "home", when: "2013/01/03", important: true, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "other", when: "01/12/2013", important: false, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "office", when: "02/12/2013", important: false, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "other", when: "03/12/2013", important: false, done: false
  __Model.Task.create name: "Tomar una cerveza", description: "Con la peña", list: "home", when: "04/12/2013", important: false, done: false


