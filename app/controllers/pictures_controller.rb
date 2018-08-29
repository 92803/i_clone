class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all.order(created_at: :desc)
  end

  def show
    @picture = Picture.find_by(id: params[:id])
    @user = User.find_by(id: @picture.user_id)
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
      if params[:cache][:image] != ""
        @picture.image.retrieve_from_cache! params[:cache][:image]
      end
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    @picture.image.retrieve_from_cache! params[:cache][:image]
    if @picture.save
       PictureMailer.picture_mail(@picture).deliver
       redirect_to pictures_path, notice:"投稿しました"
    else
       render "new"
    end
  end

  # PATCH/PUT /pictures/1
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: 'Picture was successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /pictures/1
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: 'Picture was successfully destroyed.'
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:image,:image_cache,:content)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
