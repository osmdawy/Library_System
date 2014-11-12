class Api::SessionsController <  Devise::SessionsController


  before_filter :ensure_params_exist
  respond_to :json

  # ===================== Documentation ==================
  # :POST, '/users/sign_in', "Log in, it returns the authontication token"
  # param :user, Hash, :desc => "User info", :required => true do
  #   param :username, String, :desc => "Username", :required => true
  #   param :password, String, :desc => "Password", :required => true
  # end
  # ======================================================
  def create
    @current_user = User.find_for_database_authentication(:username => params[:user][:username])
    return invalid_login_attempt unless @current_user
    if @current_user.valid_password?(params[:user][:password])
      sign_in(@current_user)
      return
    end
    invalid_login_attempt
  end

  # ===================== Documentation ==================
  # :DELETE, '/users/sign_out', "Log out"
  # ======================================================
  def destroy
    @current_user = User.where(:username => params[:user][:username]).first
    sign_out(@current_user)
    render json: {:message => "User sign out sucessfully",:status => true}
  end

  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {:message => t('users.login.missing_params'), :status => false}
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {:message => t('users.login.error_params'), :status => false}
  end
end
