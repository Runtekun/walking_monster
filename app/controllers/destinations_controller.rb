class DestinationsController < ApplicationController
    def index
        @destinations = Destination.all
        gon.destination = @destination
    end
end
