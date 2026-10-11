description = [[
Retrieves the webpage title and HTTP response status
for authorized HTTP reconnaissance.
]]

author = "Shaili H"

license = "Same as Nmap--See https://nmap.org/book/man-legal.html"

categories = {"discovery", "safe"}

local http = require "http"
local shortport = require "shortport"

portrule = shortport.http

action = function(host, port)

    local response = http.get(host, port, "/")

    if not response then
        return "Unable to retrieve HTTP response."
    end

    local results = {}

    if response.status then
        table.insert(
            results,
            "HTTP Status Code: " .. tostring(response.status)
        )
    end

    if response.body then
        local title = response.body:match(
            "<[Tt][Ii][Tt][Ll][Ee][^>]*>(.-)</[Tt][Ii][Tt][Ll][Ee]>"
        )

        if title then
            title = title:gsub("%s+", " ")
            table.insert(results, "Webpage Title: " .. title)
        end
    end

    if #results == 0 then
        return "No HTTP status or webpage title retrieved."
    end

    return table.concat(results, "\n")
end

