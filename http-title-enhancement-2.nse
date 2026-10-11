description = [[
Retrieves the webpage title and HTML meta description
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

    if not response or not response.body then
        return "Unable to retrieve webpage."
    end

    local results = {}

    local title = response.body:match(
        "<[Tt][Ii][Tt][Ll][Ee][^>]*>(.-)</[Tt][Ii][Tt][Ll][Ee]>"
    )

    if title then
        title = title:gsub("%s+", " ")
        table.insert(results, "Webpage Title: " .. title)
    end

    local meta = response.body:match(
        '<[Mm][Ee][Tt][Aa][^>]*[Nn][Aa][Mm][Ee]%s*=%s*["\']description["\'][^>]*[Cc][Oo][Nn][Tt][Ee][Nn][Tt]%s*=%s*["\']([^"\']*)["\'][^>]*>'
    )

    if not meta then
        meta = response.body:match(
            '<[Mm][Ee][Tt][Aa][^>]*[Cc][Oo][Nn][Tt][Ee][Nn][Tt]%s*=%s*["\']([^"\']*)["\'][^>]*[Nn][Aa][Mm][Ee]%s*=%s*["\']description["\'][^>]*>'
        )
    end

    if meta then
        table.insert(results, "Meta Description: " .. meta)
    else
        table.insert(results, "Meta Description: Not found")
    end

    return table.concat(results, "\n")
end
