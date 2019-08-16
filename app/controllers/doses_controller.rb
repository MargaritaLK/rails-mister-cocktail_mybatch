class DosesController < ApplicationController
  def index
    @dose = Dose.all
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new #je wil een lege dose hebben, zodat simple form weet dat het nog geen id heeft
  end

  def create
    @dose = Dose.new(doses_params)
    #cocktail_id --haal je uit de url (params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    #decstiption --uit params
    #ingredient ID
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end


  private

  def doses_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
