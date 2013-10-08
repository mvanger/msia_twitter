class TweetsController < ApplicationController
  configure do
    # This line loads the configuration from the .env file into the ENV hash
    # ENV values are accessible like ENV['CONSUMER_KEY']
    Dotenv.load

    # This block is where we're setting up our Twitter authentication
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
    end
  end

  def index
    @username = params[:username]
      if @username
        redirect to("/tweets/#{@username}")
      end
  end

  def tweets
    # This gets the username from the params hash
    @username = params[:username]
    @user = Twitter.user(@username)

    # This queries Twitter's API and asks for the most recent Tweets from a user
    # The tweets are stored in an Array called @my_tweets
    @my_tweets = {}
    if @user.protected? == false
      @my_tweets = Twitter.user_timeline(@username, {count: 200})
    end
  end

end