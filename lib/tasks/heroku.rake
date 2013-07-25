namespace :heroku_scheduler do
  desc "Curls the root url to keep the server active"
  task :keep_alive do
    @url = 'http://theflophouserecommends.herokuapp.com'
    `curl -3 #{@url}`
  end
end

class MyStrategy < HerokuSan::Deploy::Rails
  def deploy
    @stage.maintenance :on
    @stage.install_addons
    @stage.push(@commit, @force)
    @stage.restart
    @stage.maintenance :off
  end
end
HerokuSan.project = HerokuSan::Project.new(Rails.root.join("config","heroku.yml"), :deploy => MyStrategy)
