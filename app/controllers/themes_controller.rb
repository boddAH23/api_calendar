class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
    respond_to do |format|
        #format.html
        format.json { render json: @themes }
        format.xml { render xml: @themes }
    end
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
      respond_to do |format|
          #format.html
          format.json { render json: @theme }
          format.xml { render xml: @theme }
      end
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
          #format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
        format.json { render json: @theme, status: :created, location: @theme }
        format.xml { render xml: @theme, status: :created, location: @theme }
      else
      #format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
        format.xml { render xml: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(theme_params)
          #format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { render json: @theme, status: :ok, location: @theme }
        format.xml { render xml: @theme, status: :ok, location: @theme }
      else
      #format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
        format.xml { render xml: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
      if(params[:event_id])
          @event = Event.find(params[:event_id])
          t = Theme.find(params[:id])
          @event.themes.delete(t)
          respond_to do |format|
              #format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
              format.json { render :json => @event, :include =>[:themes] }
              format.xml { render :xml => @event, :include =>[:themes] }
          end
      else
        @theme.destroy
        respond_to do |format|
            #format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
            format.json { head :no_content }
            format.xml { head :no_content }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:name)
    end
end
