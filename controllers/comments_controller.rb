class CommentsController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  #set root as parent directory of current file
  set :root, File.join(File.dirname(__FILE__),'..')

  #sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  $comments = [
    {
      :id => 0,
      :name => "Ye",
      :body => "No one man should have all that power"
    },

    {
      :id => 1,
      :name => "2Chainz",
      :body => "Someone asked how i get to my destination using public transport, I catch 2 TRAIIINZZZ"
    }

  ]

#Index
  get '/comments' do

    @title = "All Comments"
    @comments = $comments

    erb :'comments/index'

    end

    #New
    get '/comments/new' do

    @comments = {

      :id => "",
      :name => "",
      :body => ""

    }

    erb :'comments/new'

    end

  #Show

    get '/comments/:id' do

      id = params[:id].to_i

      @title = "Show Comment"
      @comments = $comments[id]

      erb :'comments/show'


    end

    #Create
    post '/comments' do

      id = $comments.last[:id] + 1

      new_comment = {

        :id => id,
        :name => params[:name],
        :body => params[:body]

      }

      $posts.push new_post

      redirect '/comments'


    end

    #Update
    put '/comments/:id' do

    id = params[:id].to_i

    comment = $comments[id]

    comment[:name] = params[:name]
    comment[:body] = params[:body]

    $comments[id] = comment

    redirect '/comments'

    end

    #Edit
    get '/comments/:id/edit' do

      id = params[:id].to_i

      @comments = $comments[id]

      erb :'comments/edit'


    end

    #Destroy
    delete '/comments/:id' do

      id = params[:id].to_i

      $comments.delete_at id

      redirect '/comments'



    end


end
