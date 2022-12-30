class Users < Api
  format :json
  default_format :json

  namespace :users, desc: "Users Related Operations" do
    get "/" do
      { status: true, data: User.all, message: "User data" }
    end

    desc "User registration API"
    params do
      requires :name, type: String, desc: "Name", documentation: { param_type: "body" }
      requires :email, type: String, desc: "Email Address", documentation: { param_type: "body" }
      requires :phone, type: String, desc: "Phone", documentation: { param_type: "body" }
      requires :password, type: String, desc: "Password", documentation: { param_type: "body" }
      requires :role, type: Integer, desc: "Role", documentation: { param_type: "body" }
    end

    post "/" do
      user = User.find_by(email: params[:email])
      if !user.present?
        user = User.new(params)
        if user.save
          { status: true, data: user.as_json(except: [:created_at, :updated_at]), message: "Registration successful" }
        else
          error!({ status: false, message: user.errors.full_messages.join(", ") }, 400)
        end
      else
        error!({ status: false, message: "User already existed" }, 400)
      end
    end

    desc "User login API"
    params do
      requires :email, type: String, desc: "Email Address", documentation: { param_type: "body" }
      requires :password, type: String, desc: "Password", documentation: { param_type: "body" }
    end

    post "/login" do
      user = User.find_by(email: params[:email])
      if user.present?
        if user.valid_password?(params[:password])
          key = UserToken.create(user_id: user.id)
          { status: true, data: user.user_data(key.access_token), message: "Login successful" }
        else
          error!({ status: false, message: "Email and password do not match" }, 400)
        end
      else
        error!({ status: false, message: "User doesn't exist" }, 400)
      end
    end

    desc "User dashboard"

    get "/dashboard" do
      authenticate!
      { status: true, data: @current_user, message: "Login successful" }
    end

    get "/:id" do
      user = User.find_by(id: params[:id])
      if user
        { status: true, data: user }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    put "/:id" do
      user = User.find_by(id: params[:id])
      if user.update!(params)
        { status: true, data: user, message: "User updated" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    get "/delete/:id" do
      user = User.find_by(id: params[:id])
      if user && user.destroy
        { status: true, message: "User deleted" }
      else
        error!({ status: false, message: "No user found" }, 400)
      end
    end
  end
end
