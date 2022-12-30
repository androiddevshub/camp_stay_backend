class Camps < Api
  format :json
  default_format :json

  namespace :camps, desc: "Camps Related Operations" do

    post "/" do
      camp = Camp.new(params)
      if camp.save!
        { status: true, data: camp.as_json(except: [:created_at, :updated_at]), message: "Camp added successfully" }
      else
        error!({ status: false, message: user.errors.full_messages.join(", ") }, 400)
      end
    end

    get "/" do
      { status: true, camp_list: Camp.all, message: "Camp list" }
    end

    get "/owner/:id" do
      { status: true, camp_list: Camp.where(user_id: params["id"]), message: "Camp list" }
    end

    get "/:id" do
      camp = Camp.find_by(id: params[:id])
      if camp
        { status: true, data: camp.as_json(except: [:created_at, :updated_at]) }
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
      camp = Camp.find_by(id: params[:id])
      if camp && camp.destroy
        { status: true, message: "Camp deleted" }
      else
        error!({ status: false, message: "No camp found" }, 400)
      end
    end


  end
end