class Doc < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore
  attr_accessible :data, :slug
end
