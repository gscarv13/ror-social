module FriendshipsHelper
  def friendships_options(user)
    return unless user != current_user

    if current_user.pending_confirmation.include?(user)
      link_to('Accept', confirm_friendship_path(id: user, ok: '1'), class: 'btn btn-ok', id: "AC#{user.id}") +
        link_to('Reject', confirm_friendship_path(id: user, ok: '0'), class: 'btn btn-cancel', id: "RF#{user.id}")
    elsif current_user.friendship_requested.include?(user)
      '<span class="btn btn-warning">Pending</span>'.html_safe
    elsif !current_user.friend?(user)
      link = link_to 'Friend Request', add_friend_path(user), class: 'btn btn-info', id: "RQ#{user.id}"
      op = "<span> #{link} </span>"

      op.html_safe
    else
      '<span class="btn">Friend</span>'.html_safe
    end
  end
end
