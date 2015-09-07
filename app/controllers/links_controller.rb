class LinksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_link, only: [:destroy]

  # GET /links
  # GET /links.json
  def index
    if user_signed_in?
      @links = Link.all.joins(:user).where('users.email' => current_user.email).order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    else
      render "home"
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    if params[:slug]
      # if there is slug in the URL, find the Link inside database with that slug
      @link = Link.find_by(slug: params[:slug])
      if @link
        # and redirect the request to the Link original URL
        redirect_to @link.url
      else
        # else, just show the Link details page
        redirect_to root_path
      end
    else
      @link = Link.find(params[:id])
    end
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    if @link.user.email == current_user.email
      @link.destroy
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Link was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, users_attributes: [:user_id])
    end
end
