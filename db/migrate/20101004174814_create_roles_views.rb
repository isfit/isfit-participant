class CreateRolesViews < ActiveRecord::Migration
  def self.up
    execute('CREATE VIEW roles_views AS SELECT roles.id, roles_users.user_id, roles.name, roles.authorizable_type, roles.authorizable_id FROM roles INNER JOIN roles_users on roles.id = roles_users.role_id')
  end
  def self.down
    execute('DROP VIEW roles_views')
  end
end
