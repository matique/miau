module Aa
  class BbsController < ApplicationController
    before_action :authorize_controller!

    def index
      puts "Aa::Bbs#index"
      render plain: "Aa::Bbs#index"
    end

    def show
      authorize!
      puts "Aa::Bbs#show"
      render plain: "Aa::Bbs#show"
    end
  end
end
