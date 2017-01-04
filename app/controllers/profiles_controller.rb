class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_user

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all.order(updated_at: :desc)
    @users = User.joins(:profile).includes(:profile).where(profiles: {status: "Looking"}).order(last_sign_in_at: :desc).where.not(id: current_user.id)
    if !current_user.profile.nil? 
    #   if !params[:search_instrument].nil? 
    #     @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%")
    #   end
    #   if !params[:search_name].nil? 
    #     @users = @users.where("profiles.name LIKE ?", "%#{params[:name]}%")
    #   end
    #   if !params[:search_city].nil? 
    #     @users = @users.where("profiles.city LIKE ?", "%#{params[:city]}%")
    #   end
    #   if !params[:search_state].nil? 
    #     @users = @users.where("profiles.state LIKE ?", "%#{params[:state]}%")
    #   end
    # else 
    #   if !params[:search_instrument].nil? 
    #     @users = @profiles.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%")
    #   end
    #   if !params[:search_name].nil? 
    #     @users = @profiles.where("profiles.name LIKE ?", "%#{params[:name]}%")
    #   end
    #   if !params[:search_city].nil? 
    #     @users = @profiles.where("profiles.city LIKE ?", "%#{params[:city]}%")
    #   end
    #   if !params[:search_state].nil? 
    #     @users = @profiles.where("profiles.state LIKE ?", "%#{params[:state]}%")
    #   end

      if !params[:search_instrument].nil? 
        if !params[:search_name].nil?
          if !params[:search_city].nil?
            if !params[:search_state].nil?
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").where("profiles.state LIKE ?", "%#{params[:search_state]}")
            else  
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").order(last_sign_in_at: :desc)
            end
          else
            @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.name LIKE ?", "%#{params[:search_name]}%").order(last_sign_in_at: :desc)
          end
        else 
          if !params[:search_city].nil?
            if !params[:search_state].nil?
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
            else  
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").order(last_sign_in_at: :desc)
            end
          else
            if if !params[:search_state].nil?
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").where("profiles.state LIKE ?", "%#{params[:search_state]}%").order(last_sign_in_at: :desc)
            else 
              @users = @users.where("profiles.primary_instrument LIKE ?", "%#{params[:search_instrument]}%").order(last_sign_in_at: :desc)
            end          
          end
        end
      end 
      else
        if !params[:search_name].nil?
          if !params[:search_city].nil?
            if !params[:search_state].nil?
              @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
            else  
              @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").order(last_sign_in_at: :desc)
            end
          else
            if !params[:search_city].nil?
              if !params[:search_state].nil?
                @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
              else
                 @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.city LIKE ?", "%#{params[:search_city]}").order(last_sign_in_at: :desc)
              end  
            else 
              if !params[:search_state].nil?
                @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
              else
                @users = @users.where("profiles.name LIKE ?", "%#{params[:search_name]}%").order(last_sign_in_at: :desc)
              end  
            end
          end
        else 
          if !params[:search_city].nil?
            if !params[:search_state].nil?
              @users = @users.where("profiles.city LIKE ?", "%#{params[:search_city]}").where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
            else  
              @users = @users.where("profiles.city LIKE ?", "%#{params[:search_city]}").order(last_sign_in_at: :desc)
            end
          else
            if !params[:search_state].nil?
              @users = @users.where("profiles.state LIKE ?", "%#{params[:search_state]}").order(last_sign_in_at: :desc)
            else 
              @users = @users.where("profiles.state LIKE ?", "%#{current_user.profile.state}").where("profiles.looking_for LIKE ?", "%#{current_user.profile.primary_instrument}").order(last_sign_in_at: :desc)
            end
          end
        end
      end
    end 
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show

  end

  # GET /profiles/new
  def new
      @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = @user 

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to myprofile_profile_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def myprofile
    @profile = @user.profile
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def set_user
      @user = current_user
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:audioclip, :audioclip2, :audioclip3,  :years_spent_playing, :user_id, :name, :bio, :age, :city, :state, :primary_instrument, :second_instrument, :third_instrument, :status, :looking_for, :image, :genre => [])
    end

end
