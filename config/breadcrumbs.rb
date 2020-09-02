crumb :root do
  link "トップページ", root_path
end

crumb :user do
  link "マイページ", user_path(:id)
  parent :root
end

crumb :new_item do |item|
  link "商品を出品する", new_item_path
  parent :user
end

crumb :item do |item|
  link "商品の詳細", item_path
  parent :user
end

crumb :edit_item do |item|
  link "商品を編集する", edit_item_path
  parent :item
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).