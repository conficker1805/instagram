module ParamHelper
  def latitude_param
    params[:location]["latitude"] if params[:location]
  end

  def longitude_param
    params[:location]["longitude"] if params[:location]
  end
end
