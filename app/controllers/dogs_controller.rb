class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update, :destroy]
  before_action :authenticate_user!, only: :toggle_favorite


#  def toggle_favorite
 #   @dog = Dog.find_by(id: params[:id])
 #   current_user.favorited?(@dog)  ? current_user.unfavorite(@dog) : current_user.favorite(@dog)
 # end
#end



  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = Dog.paginate page: params[:page], per_page: 5

    #@dogs = Dog.order('DATE(updated_at), favorites DESC')  --Most recent then by most liked
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    #@dog = Dog.new
    @dog = current_user.dogs.build
  end



  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    #@dog = Dog.new(dog_params)
    @dog = current_user.dogs.build(dog_params)
    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end




  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @dog = current_user.dogs.find_by(id: params[:id])
    redirect_to dogs_path, notice:"Only Owner Can Edit This Dog" if @dog.nil?
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, images: [])
    end
end


