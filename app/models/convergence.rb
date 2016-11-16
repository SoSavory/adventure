class Convergence < ActiveRecord::Base
  belongs_to :story
  belongs_to :parent, class_name: "Page"
  belongs_to :child, class_name: "Page"

  #convergence title gets displayed on the page parent
  #parent holds the convergence, child is converged to

end
