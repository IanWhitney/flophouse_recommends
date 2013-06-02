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
