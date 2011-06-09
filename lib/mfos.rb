require 'rubygems'

module Mfos
  def generate_text(params)
    (params[:ping] and params[:ping].to_i == 1) ? true : false
  end
  
  def generate_response
    response = Random.new
    response.rand(0..1)
  end
end