class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :new, :edit, :destroy, :create]
  before_action :set_user

  # GET /profiles
  # GET /profiles.json
  def index
    #profiles used for users who lack profiles
    @profiles = Profile.all.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 4)
    #users used for users who have added a profile 
    if user_signed_in?
      @users = User.joins(:profile).includes(:profile).where(profiles: {status: "Looking"}).order(last_sign_in_at: :desc).where.not(id: current_user.id).paginate(:page => params[:page], :per_page => 4) 
      if current_user.profile.nil? 
        if !params[:search_instrument].nil? 
          @profiles = @profiles.where("LOWER(profiles.primary_instrument) LIKE ?", "%#{params[:search_instrument].downcase}%")
        end
        if !params[:search_name].nil? 
          @profiles = @profiles.where("LOWER(profiles.name) LIKE ?", "%#{params[:search_name].downcase}%")
        end
        if !params[:search_city].nil? 
          @profiles = @profiles.where("LOWER(profiles.city) LIKE ?", "%#{params[:search_city].downcase}%")
        end
        if !params[:search_state].nil? 
          @profiles = @profiles.where("LOWER(profiles.state) LIKE ?", "%#{params[:search_state].downcase}%")
        end
      else 
         if !params[:search_instrument].nil? 
           @users = @users.where("LOWER(profiles.primary_instrument) LIKE ?", "%#{params[:search_instrument].downcase}%")
        end
        if !params[:search_name].nil? 
          @users = @users.where("LOWER(profiles.name) LIKE ?", "%#{params[:search_name].downcase}%")
        end
        if !params[:search_city].nil? 
          @users = @users.where("LOWER(profiles.city) LIKE ?", "%#{params[:search_city].downcase}%")
        end
        if !params[:search_state].nil? 
          @users = @users.where("LOWER(profiles.state) LIKE ?", "%#{params[:search_state].downcase}%")
        end
      end
    else 
      if !params[:search_instrument].nil? 
        @profiles = @profiles.where("LOWER(profiles.primary_instrument) LIKE ?", "%#{params[:search_instrument].downcase}%")
      end
      if !params[:search_name].nil? 
        @profiles = @profiles.where("LOWER(profiles.name) LIKE ?", "%#{params[:search_name].downcase}%")
      end
      if !params[:search_city].nil? 
        @profiles = @profiles.where("LOWER(profiles.city) LIKE ?", "%#{params[:search_city].downcase}%")
      end
      if !params[:search_state].nil? 
        @profiles = @profiles.where("LOWER(profiles.state) LIKE ?", "%#{params[:search_state].downcase}%")
      end
    end
  end

  def show
    @user = @profile.user
  end
  
  def new
      @profile = Profile.new
  end

  def edit
    @profile = current_user.profile
  end

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
      params.require(:profile).permit(:audioclip, :audioclip2, :audioclip3, :years_spent_playing, :user_id, :name, :bio, :age, :city, :state, :primary_instrument, :second_instrument, :third_instrument, :status, :looking_for, :image, :genre => [])
    end

end
