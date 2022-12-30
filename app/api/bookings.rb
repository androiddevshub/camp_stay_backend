class Bookings < Api
  format :json
  default_format :json

  namespace :bookings, desc: "Booking Related Operations" do

    post "/" do
      booking = Booking.new(params)
      if booking.save!
        { status: true, data: booking.as_json(except: [:created_at, :updated_at]), message: "Booking added successfully" }
      else
        error!({ status: false, message: booking.errors.full_messages.join(", ") }, 400)
      end
    end

    get "/users/:user_id" do
      bookings = Booking.where(user_id: params["user_id"])
      if bookings
        booking_list = []
        bookings.map do |booking| 
          booking_list << {
            id: booking.id,
            camp_name: Camp.find(booking.camp_id).name,
            camp_location: Camp.find(booking.camp_id).location,
            camp_owner_name: User.find(booking.camp_owner_id).name,
            camp_owner_contact: Camp.find(booking.camp_id).contact,
            from_date: booking.from_date,
            to_date: booking.to_date,
            cost: booking.cost
          }
        end
        { status: true, booking_list: booking_list, message: "Booking list" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    get "/owners/:owner_id" do
      bookings = Booking.where(camp_owner_id: params["owner_id"])
      if bookings
        booking_list = []
        bookings.map do |booking| 
          booking_list << {
            id: booking.id,
            camp_name: Camp.find(booking.camp_id).name,
            camp_location: Camp.find(booking.camp_id).location,
            camp_tourist_name: User.find(booking.user_id).name,
            camp_tourist_contact: User.find(booking.user_id).phone,
            from_date: booking.from_date,
            to_date: booking.to_date,
            cost: booking.cost
          }
        end
        { status: true, booking_list: booking_list, message: "Booking list" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    get "/delete/:id" do
      booking = Booking.find_by(id: params[:id])
      if booking && booking.destroy
        { status: true, message: "Booking deleted" }
      else
        error!({ status: false, message: "No booking found" }, 400)
      end
    end


  end
end