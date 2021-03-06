$(document).on 'turbolinks:load', ->
  $("#project_user_ids").select2()
  $('.create_project').validate
    onkeyup: false
    onfocusout: (element) ->
      if !@checkable(element)
        @element element
    errorElement: 'div'
    errorClass: 'field-error'
    rules:
      'project[title]':
        required: true
      'project[description]':
        required: true
    messages:
      'project[title]':
        required: 'Enter title'
      'project[description]':
        required: 'Enter description'
