module FriendshipsHelper
  def friendships_options(user)
    return unless user != current_user

    if current_user.pending_confirmation.include?(user)
      link_to('Accept', '', class: 'btn btn-ok') + link_to('Reject', '', class: 'btn btn-cancel')
    elsif current_user.friendship_requested.include?(user)
      '<span class="btn btn-warning">Pending</span>'.html_safe
    elsif !current_user.friend?(user)
      link = link_to 'Friend Request', add_friend_path(user), class: 'btn btn-info'
      op = "<span> #{link} </span>"

      op.html_safe
    end
  end
end
