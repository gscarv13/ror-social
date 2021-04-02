module FriendshipsHelper
  def friendships_options(user, requested = [], pending = [], friend_list = [])
    return unless user != current_user

    if pending.include?(user.id)
      link_to('Accept', confirm_friendship_path(id: user, ok: '1'), class: 'btn btn-ok', id: "AC#{user.id}") +
        link_to('Reject', confirm_friendship_path(id: user, ok: '0'), class: 'btn btn-cancel', id: "RF#{user.id}")
    elsif requested.include?(user.id)
      '<span class="btn btn-warning">Pending</span>'.html_safe
    elsif friend_list.include?(user.id)
      '<span class="btn">Friend</span>'.html_safe
    else
      link = link_to 'Friend Request', add_friend_path(user), class: 'btn btn-info', id: "RQ#{user.id}"
      op = "<span> #{link} </span>"

      op.html_safe
    end
  end
end
