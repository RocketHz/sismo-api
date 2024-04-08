class EarthquakesController < ApplicationController
  def index
    @earthquakes = Earthquake.all
    @earthquakes = @earthquakes.where(mag_type: params[:mag_type]) if params[:mag_type].present?
    @earthquakes = @earthquakes.paginate(page: params[:page], per_page: params[:per_page] || 10)
   
    response = {
       data: @earthquakes.map do |earthquake|
         {
           id: earthquake.id,
           type: "feature",
           attributes: {
             external_id: earthquake.id.to_s,
             magnitude: earthquake.mag,
             place: earthquake.place,
             time: earthquake.time.iso8601,
             tsunami: earthquake.tsunami,
             mag_type: earthquake.mag_type,
             title: earthquake.title,
             coordinates: {
               longitude: earthquake.longitude,
               latitude: earthquake.latitude
             },
             comments: earthquake.comments.map do |comment|
               {
                 id: comment.id,
                 body: comment.body
               }
             end
           },
           links: {
             external_url: earthquake.url
           }
         }
       end,
       pagination: {
         current_page: @earthquakes.current_page,
         total: @earthquakes.total_entries,
         per_page: @earthquakes.per_page
       }
    }
   
    render json: response
   end
   

   def show
    @earthquake = Earthquake.find(params[:id])
    response = {
       data: {
         id: @earthquake.id,
         type: "feature",
         attributes: {
           external_id: @earthquake.id.to_s,
           magnitude: @earthquake.mag,
           place: @earthquake.place,
           time: @earthquake.time.iso8601,
           tsunami: @earthquake.tsunami,
           mag_type: @earthquake.mag_type,
           title: @earthquake.title,
           coordinates: {
             longitude: @earthquake.longitude,
             latitude: @earthquake.latitude
           },
           comments: @earthquake.comments.map do |comment|
             {
               id: comment.id,
               body: comment.body
             }
           end
         },
         links: {
           external_url: @earthquake.url
         }
       }
    }
   
    render json: response
   end
   

  def create
    @earthquake = Earthquake.new(earthquake_params)
    if @earthquake.save
      render json: @earthquake, status: :created
    else
      render json: @earthquake.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @earthquake = Earthquake.find(params[:id])
    @earthquake.destroy
    head :no_content
  end

  private

  def earthquake_params
    params.require(:earthquake).permit(:id, :mag, :place, :time, :url, :tsunami, :mag_type, :title, :latitude, :longitude)
  end
end
