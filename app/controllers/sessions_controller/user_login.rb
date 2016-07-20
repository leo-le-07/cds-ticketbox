class SessionsController
  class UserLogin
    def login(email, password)
      user = User.find_by(email: email.downcase)
      unless user
        return nil
      end
      user if user.try(:authenticate, password)
    end
  end
end
