require_relative '../config/environment'

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  print false
else
  print true
end

database_exists?