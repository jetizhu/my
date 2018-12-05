local redis = require "nginx.redis"
local red = redis:new()
red:set_timeout(1000) -- 1 sec

--local ok, err = red:connect("127.0.0.1", 6379)
local ok, err = red:connect("unix:/tmp/redis.sock")
if not ok then
	ngx.exec("@vphotosgallery-release")
	return 
--	ngx.say("failed to connect: ", err)
end

local res, err = red:get(ngx.var.arg_vphotowechatid)
-- local res, err = red:get(ngx.var.cookie_vpid)
if not res then
	ngx.exec("@vphotosgallery-release")
	return 
elseif res == "cdn" then
        ngx.exec("@vphotosgallery-cdn")
        return
elseif res == "2d23" then
        ngx.exec("@vphotosgallery-2d23")
        return
elseif res == "hdgj" then
        ngx.exec("@vphotosgallery-hdgj")
        return
end

if res == ngx.null then
	ngx.exec("@vphotosgallery-release")
       	return
end

ngx.exec("@vphotosgallery-beta")