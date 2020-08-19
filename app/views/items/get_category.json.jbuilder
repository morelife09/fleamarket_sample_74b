json.array! @children do |child|
  json.id child.id
  json.name child.name
end

json.array! @grandchildren do |grandchild|
  json.id grandchild.id
  json.name grandchild.name
end
