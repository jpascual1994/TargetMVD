App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    if (data.type === 'new match') {
      $('.new-match-modal .modal-custom-content').html(data.modal_body);
      $('.new-match-modal').modal('show');
      $('.chats-section').html(data.chat_section);
    } else {
      if (window.chatOpen !== data.match_id) {
        $('.new-message-modal .modal-custom-content').html(data.modal_body);
        $('.new-message-modal').modal('show');
      }
      unreads = $('.home-left-top .match[data-match-id="' + data.match_id + '"] .unread-msgs');
      unreads.removeClass('hidden');
      new_unreads = unreads.html();
      new_unreads++;
      unreads.html(new_unreads);
    }
  }
});
