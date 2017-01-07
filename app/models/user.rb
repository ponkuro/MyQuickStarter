class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [:facebook]

  # UUID(Universally Unique Identifier)を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  # facebookアカウントの登録があるUserをDBから参照する
  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    # データベースに該当ユーザーが存在しない場合 <-- 新規登録時
    unless user
      user = User.new(
        name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end

    # 処理が終わる前に戻り値として明示的にセット
    user
  end

end
