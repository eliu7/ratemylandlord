class LandlordsController < ApplicationController
  def index
    @landlords = [
                  ["Kevin Johnson", 5,5,5,5],
                  ["Adam Heimowitz", 4,5,4,4],
                  ["Mike Zagreda", 1,1,1,1]
                ]
  end
end
