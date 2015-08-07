class User < ActiveRecord::Base
  # Remember to create a migration!

  has_many :properties

  validate :name, presence: true
  validate :email, presence:true, uniqueness: true, format: {width: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/  }
  validate :password, confirmation: true, length: { minimum: 10 }

  def self.authenticate(email, password)
    @user = User.find_by_email(params[:user])
      unless @user.nil?
        if @user.password == password
            return @user
          else
            return nil
        end
          else
        return nil
      end
    end
  end


#   private
#     def user_params
#       params.require(:user).permit(:name, :email, :password)
#     end
# end
