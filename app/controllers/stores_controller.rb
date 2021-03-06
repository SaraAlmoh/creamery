class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :admins_abilities, only: [:edit, :update, :destroy, :create, :new]

    
  # should I show the active and inactive stores?
  def index 
      @stores = Store.alphabetical
  end
  
  def show
  end
  
  def inactive
      @stores = Store.inactive
  end
  
  def active
      @stores = Store.active
  end
  

  def new
      @store = Store.new
  end

    # find by id and hence show info
  def edit
      @store = Store.find(params[:id])
  end

  def create
      # shoud store_params be in the model?
      @store = Store.new(store_params)
      if @store.save
        redirect_to @store, notice: "#{@store.name} was added to the system."
      else
        render action: 'new'
      end
  end

  def update
      if @store.update(store_params)
        redirect_to @store, notice: "#{@store.name} was revised in the system."
      else
        render action: 'edit'
      end
  end

  def destroy
      @store.destroy
      redirect_to stores_url
  end
  
    def admins_abilities
      puts "uyjthrsegafwgrtkuyrefwadhrtjyrews"
      unless current_users_role == "admin"
        respond_to do |format|
          format.html { redirect_to stores_url, notice: 'You are not authorized to view this information/perform this action' }
          format.json { head :no_content }
        end
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from users (potential hackers), but rather only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :latitude, :longitude, :active)
    end
    
end
