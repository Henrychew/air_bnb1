get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/sign_up' do
  erb :sign_up
end


post '/create' do
  @user = User.new(params[:user])
  if @user.save
    redirect "/create/#{@user.id}"
  else
    redirect "/"
  end
end


get '/create/:id' do
  # @property = Property.all
  @user = User.find(params[:id])
  @properties = @user.properties
  erb :show
end


get '/log_in' do
  erb :log_in
end

post '/new_session' do
  @user = User.find_by_email(params[:user][:email])
  if @user.password == params[:user][:password]
    session['user_id'] = @user.id
    redirect to "/create/#{@user.id}"
  else
    redirect to '/'
  end
end


post '/new_property' do
  @user = User.find_by_id(session['user_id'])
  @property = Property.new(params[:property])
  if @property.save
    @user.properties << @property
    redirect "/#{@user.id}/#{@property.id}"
  else
    redirect "/create/#{@user.id}"
  end
end

get '/:id/:property' do
  @user = User.find(params[:id])
  @properties = @user.properties.order('id desc')
  @property = Property.find(params[:property])
  erb :show_properties
end

get '/:id/:property/edit' do
  @user = User.find(params[:id])
  @property = Property.find(params[:property])
  erb :edit
end


post '/:id/:property/update' do
  @user = User.find(params[:id])
  @property = Property.find(params[:property])

  if @property.update(name: params[:property][:name], location: params[:property][:location], address: params[:property][:address], price: params[:property][:price])
    redirect "/#{@user.id}/#{@property.id}"
  else
    redirect "/#{@user.id}/#{@property.id}"
  end
end



get '/all_property' do
  redirect "/#{@user.id}/#{@property.id}"
end


delete '/:id/:property/delete' do
  @user = User.find(params[:id])
  @property = Property.find(params[:property])
  @delete = @property.destroy
  erb :deleted
end