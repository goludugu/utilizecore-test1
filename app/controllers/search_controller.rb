# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @parcels = if params[:search].present?
                 Parcel.search_by_order_id(params[:search])
               else
                 []
               end
  end
end
