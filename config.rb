# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :sprockets

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.remote = 'git@github.com:RichardVickerstaff/a_heroic_death.git'
  deploy.branch = 'master'
  deploy.build_before = true
  deploy.commit_message = "Deployed by #{`whoami`} on #{Time.now.utc}"
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :asset_host, host: '//richardvickerstaff.github.io/a_heroic_death'
end
