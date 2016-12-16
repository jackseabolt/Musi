module Client
  class RegistrationsController < Devise::RegistrationsController

    def create
      super

      # If the account was created...
      if not resource.profile.nil?
       p = Profile.new(:user => resource)
       p.save(validate: false)
      end
    end

    def update
      response = resource.profile.update(profile_params["profile"])

      if not response
        return redirect_to edit_user_registration_path, :flash => { 
          :error => resource.profile.errors.full_messages.join(', ')
        }
      end

      super
    end

    protected
    def after_sign_up_path_for(resource)
      # Automatically sign in the user
      sign_in(:user, resource)

      root_path
    end

    # After a user has updated their profile
    # Redirect path
    def after_update_path_for(resource)
      home_path
    end

    def profile_params
      params.require(:user).permit(:profile => [:title, :first_name, :last_name])
    end

  end
end