App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $('.new-match-modal .modal-custom-content').html(data.modal_body)
    $('.modal').modal('show');
    $('.chats-section').html('');
  }
});
