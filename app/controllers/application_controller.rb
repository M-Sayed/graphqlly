class ApplicationController < ActionController::Base

  def current_user
    return unless session[:token]

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.decrypt_and_verify session[:token]

    user_id = token.gsub('user-id:', '').to_i

    User.find_by id: user_id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
end
