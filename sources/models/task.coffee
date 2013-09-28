class __Model.Task extends Monocle.Model

  @fields "name", "description", "list", "when", "important", "done"

  @pending: -> @select (task) -> !task.done and task.important is false

  @completed: -> @select (task) -> !!task.done

  @important: -> @select (task) -> task.important is true
