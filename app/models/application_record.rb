class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.parse_params(params)
    page = (params[:page] || 1).to_i
    limit = (params[:per_page] || 50).to_i
    offset = (page - 1) * limit
    query = "%#{params[:query] || ''}%"
    order = params[:order] || 'created_at'
    [limit, offset, query, order]
  end
end
