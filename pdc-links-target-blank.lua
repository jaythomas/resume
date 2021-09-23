-- Add target="_blank" attributes to all http links in a Pandoc document
local function add_target_blank(link)
  -- Remove if-statement to add target="_blank" to all links, not just http(s)
  if string.match(link.target, '^http') then
    link.attributes.target = '_blank'
  end
  return link
end



return {
  { Link = add_target_blank }
}
