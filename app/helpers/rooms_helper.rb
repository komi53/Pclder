module RoomsHelper
		 # 最新メッセージのデータを取得して表示するメソッド
  def most_new_message_preview(room)
    # 最新メッセージのデータを取得する
    chat = room.chats.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    chat = chat[0]
    # メッセージの有無を判定
    if chat.present?
      # メッセージがあれば内容を表示
      tag.span "#{chat.message}", class: "dm_list__content__link__box__message"
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.span "[ まだメッセージはありません ]", class: "dm_list__content__link__box__message"
    end
  end

  def most_new_time_preview(room)
    # 最新メッセージのデータを取得する
    chat = room.chats.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    chat = chat[0]
    # メッセージの有無を判定
    if chat.present?
      # メッセージがあれば内容を表示
      tag.span "#{chat.created_at.strftime("%H:%M %p,%b %d")}", class: "dm_list__content__link__box__time"
    end
  end

  # 相手ユーザー名を取得して表示するメソッド
  def opponent_user(room)
    # 中間テーブルから相手ユーザーのデータを取得
    entry = room.user_rooms.where.not(user_id: current_user)
    if entry[0].user != nil
      # 相手ユーザーの名前を取得
      name = entry[0].user.name
      # 名前を表示
      tag.p "#{name}", class: "dm_list__content__link__box__name"
    else
    return tag.p "このメンバーは退会しました。"
    end
  end

  def opponent_user_id(room)
    # 中間テーブルから相手ユーザーのデータを取得
    entry = room.user_rooms.where.not(user_id: current_user)
    if entry[0].user != nil
      # 相手ユーザーのIDを取得
      user_id = entry[0].user.id
      # 名前を表示
      return "#{chat_path(user_id)}"
    else
    return "#{rooms_deleted_path}"
    end
  end

end
