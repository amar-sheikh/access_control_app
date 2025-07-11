namespace :permissions do
  desc "Load permissions from YAML file and assign to admin roles"
  task load: :environment do
    data = YAML.load_file(Rails.root.join("config", "permissions.yml"))["permissions"]

    permissions = data.map do |key, val|
      Permission.find_or_create_by!(name: key) do |perm|
        perm.label = val["label"]
        perm.action = val["can"][0]
        perm.subject = val["can"][1]
      end
    end

    admin_roles = UserRole.where(name: "admin")
    admin_roles.each do |role|
      role.permission_ids = permissions.map(&:id)
    end

    puts "Permissions loaded and assigned to admin roles!"
  end
end
