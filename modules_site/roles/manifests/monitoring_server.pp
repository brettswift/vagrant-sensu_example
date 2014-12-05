class roles::monitoring_server {
  include profiles::sensu_monitor
  include profiles::sensu_agent
}
