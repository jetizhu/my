local redis = require "nginx.redis"
local red = redis:new()
--local ok, err = red:connect("10.3.16.38", 6379)
local ok, err = red:connect("unix:/tmp/redis.sock")
if not ok then
        ngx.say("failed to connect: ", err)
        return
end

local duri, err = red:get("CDN/bkwft01"..ngx.var.uri)
if duri and duri ~= null and duri ~= ngx.null  then
local agrs = string.gsub(duri,"^.*%?","")
return ngx.req.set_uri_args(agrs)
else
--ngx.exit(404)
--POST API
local http = require "resty.http"
local httpc = http:new()
local apiser = "http://10.3.16.65:8080/vphotoSaaS/wechat/album/getPhotoCDNUrl" 
local res, err = httpc:request_uri(apiser, {
method = "POST",
body = "cdnKey=CDN/bkwft01"..ngx.var.uri,
        headers = {
          ["Content-Type"] = "application/x-www-form-urlencoded",
}
})
--ngx.say(res.body)
json = res.body
--JSON Format
local cjson = require "cjson"
        local jurl = cjson.decode(json)
        local kurl = jurl.data["photoCDNUrl"]
        local agrs = string.gsub(kurl,"^.*%?","")
        return ngx.req.set_uri_args(agrs)
end