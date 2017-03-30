require_relative '../db/db'

def require_glob(glob)
  Dir.glob(glob).sort.each do |path|
    require path
  end
end

require_glob __dir__ + '/models/*.rb'
