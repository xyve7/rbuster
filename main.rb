require("net/http")
require("uri")


def brute_force(arr, location, dir = "/") 
    for pdir in arr do
        real_path = dir + pdir
        uri = URI("#{location}#{real_path}")
        req = Net::HTTP.get_response(uri);
        if req.code != "404"
            puts("#{real_path} found... code=#{req.code}")
            brute_force(arr, location, dir + pdir + "/")
        end
    end
end

if ARGV.length > 1
  arr = IO.readlines(ARGV[1], chomp: true)
  brute_force(arr.reject{ |line| line.start_with?('#') || line.start_with?('\\') || line.empty? }, ARGV[0])
else
  STDERR.puts("rbuster: unsufficent number of arguments")
end
