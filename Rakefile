STAGING_SERVERS = [
  {
    # edit the host to point to your EC2 instance i.e ubuntu@xx.xx.xx.xxx
    # :host      => 'ubuntu@xx.xx.xx.xxx',
    :node_name => 'web_app_staging1',
    :id_file => '-i ttt.pem'
  }
]

VAGRANT_SERVER = [
  {
    :host      => 'vagrant',
    :node_name => 'vagrant',
    :id_file => ''
  }
]

namespace :prepare do
  def run_prepare(servers)
    servers.each do |server|
      sh "bundle exec knife solo prepare #{server[:host]} -N #{server[:node_name]} #{server[:id_file]}"
    end
  end

  desc "Deploy to staging (make sure AWS instance is running"
  task :staging do
    run_prepare(STAGING_SERVERS)
  end

  desc "Deploy to vagrant"
  task :vagrant do
    run_prepare([{host: 'vagrant', node_name: 'vagrant'}])
  end
end

namespace :deploy do
  def run_deploy(servers)
    servers.each do |server|
      sh "bundle exec knife solo cook #{server[:host]} -N #{server[:node_name]} #{server[:id_file]}"
    end
  end

  desc "Deploy to staging (make sure AWS instance is running"
  task :staging do
    run_deploy(STAGING_SERVERS)
  end

  desc "Deploy to vagrant"
  task :vagrant do
    run_deploy([{host: 'vagrant', node_name: 'vagrant'}])
  end
end
