$(document).on 'turbolinks:load', ->
  $('.create_task').validate
    onkeyup: false
    onfocusout: (element) ->
      if !@checkable(element)
        @element element
    errorElement: 'div'
    errorClass: 'field-error'
    rules:
      'task[title]':
        required: true
      'task[description]':
        required: true
    messages:
      'task[title]':
        required: 'Enter title'
      'task[description]':
        required: 'Enter description'
