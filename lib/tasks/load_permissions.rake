namespace :permissions do
  desc "Load permissions from YAML file"
  task load: :environment do
    data = YAML.load_file(Rails.root.join("config", "permissions.yml"))["permissions"]

    data.each do |key, val|
      Permission.find_or_create_by!(
        name: key
      ) do |perm|
        perm.label = val["label"]
        perm.action = val["can"][0]
        perm.subject = val["can"][1]
      end
    end

    puts "Permissions loaded!"
  end
end
