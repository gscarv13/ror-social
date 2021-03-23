module FriendshipsHelper
  def friendships_options(user)
    return unless user != current_user

    if current_user.pending_confirmation.include?(user)
      link_to('Accept', confirm_friendship_path(user), class: 'btn btn-ok', id: "COD#{user.id}") +
        link_to('Reject', refuse_friendship_path(user), method: :delete, class: 'btn btn-cancel', id: "COD#{user.id}")
    elsif current_user.friendship_requested.include?(user)
      '<span class="btn btn-warning">Pending</span>'.html_safe
    elsif !current_user.friend?(user)
      link = link_to 'Friend Request', add_friend_path(user), class: 'btn btn-info', id: "COD#{user.id}"
      op = "<span> #{link} </span>"

      op.html_safe
    end
  end
end
