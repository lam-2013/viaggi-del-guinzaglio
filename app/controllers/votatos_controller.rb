class VotatosController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js
  def create
    @itinerario = Itinerario.find(params[:itinerario_id])
    current_user.vote!(@itinerario)
    @itinerario.voto = Votato.where(:itinerario_id => @itinerario.id).count
    @itinerario.update_attributes(:voto => @itinerario.voto)
    respond_with @user
  end
end