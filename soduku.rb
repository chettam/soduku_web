require 'sinatra' # load sinatra
require_relative './lib/grid'
require_relative './lib/cell'
require_relative './lib/user'
require_relative './helpers/application'
require 'sinatra/partial' 

require 'rack-flash'

def create_user
	user = User.new
	user.create_unsolved_grid(easy)
	user
end

def box_order_to_row_order(cells)
  boxes = cells.each_slice(9).to_a
  (0..8).to_a.inject([]) do |memo, i|
    first_box_index = i / 3 * 3
    three_boxes = boxes[first_box_index, 3]
    three_rows_of_three = three_boxes.map do |box| 
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
    memo += three_rows_of_three.flatten
  end
end

def generate_new_puzzle_if_necessary
	return if session[:current_solution]
	user = create_user
	session[:solution] = user.grid.to_s
	session[:puzzle] = user.unsolved_grid.to_s
	session[:current_solution] = session[:puzzle]
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash[:notice] = "Incorrect values are highlighted in Yellow"
  end
  session[:check_solution] = nil
end

enable :sessions
set :session_secret, "cedvjrnvoirgbruvgovieirvjerobge"
set :partial_template_engine, :erb
use Rack::Flash

get '/' do # default route for our website
	prepare_to_check_solution
  generate_new_puzzle_if_necessary
	@current_solution = session[:current_solution] || session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
	erb :index
end

get '/new_game' do
	level = params[:level]
	user = User.new
	user.create_unsolved_grid(level)
	session[:solution] = user.grid.to_s
	session[:puzzle] = user.unsolved_grid.to_s
	session[:current_solution] = session[:puzzle]
	redirect to("/")
end


get '/solution' do
  @current_solution = session[:solution]
  erb :index
end

post'/' do	
	cells = box_order_to_row_order(params["cell"])  
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
end




