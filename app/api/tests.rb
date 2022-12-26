class Tests < Api
  format :json
  default_format :json

  namespace :tests, desc: "Tests Related Operations" do
    get "/" do
      { status: true, message: "I am here in the test api" }
    end

    
  end
end
