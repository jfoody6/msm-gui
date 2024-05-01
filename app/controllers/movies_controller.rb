class MoviesController < ApplicationController
  def modify

    #get the ID out of params
    #look up existing record
    #overwrite each column with updated value from user inputs 
    #save
    #redirect to same page
      m_id = params.fetch("path_id")
      matching_records = Movie.where({ :id => m_id})
      the_movie = matching_records.at(0)

      the_movie.title = params.fetch("query_title")
      the_movie.year = params.fetch("query_year")
      the_movie.duration = params.fetch("query_duration")
      the_movie.description = params.fetch("query_description")
      the_movie.image = params.fetch("query_image")
      the_movie.director_id = params.fetch("query_director_id")

      the_movie.save

    redirect_to("/movies/#{the_movie.id}")

  end 

  
  
  def destroy
    path_id = params.fetch("path_id")

    matching_records = Movie.where({ :id => path_id })

    the_movie = matching_records.at(0)
    the_movie.destroy 

    redirect_to("/movies")

  end 
  
  def create
    #retrieve the user inputs from params
    #params looks like {"query_title"=>"1", "query_year"=>"2", "query_duration"=>"3", "query_description"=>"4", "query_image"=>"5", "query_director_id"=>"6"}

    m = Movie.new
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")

    m.save

    redirect_to("/movies")

    #create a record in the movie table
    #populate each column with the user input
    #save
    #redicret user back to /movies URL w/ updated view 


  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
