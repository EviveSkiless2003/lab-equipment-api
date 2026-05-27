puts "Clearing old data..."
MaintenanceRecord.destroy_all
Equipment.destroy_all
Category.destroy_all

puts "Creating Categories..."
computing = Category.create!(name: "Computing")
optics = Category.create!(name: "Optics")
networking = Category.create!(name: "Networking")
electronics = Category.create!(name: "Electronics")

puts "Creating Equipment..."
eq1 = Equipment.create!(name: "Dell Server", serial_number: "LAP-001", status: "in_use", category: computing)
eq2 = Equipment.create!(name: "ThinkPad T14", serial_number: "LAP-002", status: "available", category: computing)

eq3 = Equipment.create!(name: "Electron Microscope", serial_number: "MIC-100", status: "maintenance", category: optics)
eq4 = Equipment.create!(name: "Handheld Magnifier", serial_number: "MAG-050", status: "available", category: optics)

eq5 = Equipment.create!(name: "Cisco Switch", serial_number: "NET-999", status: "in_use", category: networking)
eq6 = Equipment.create!(name: "Asus Router", serial_number: "RTR-404", status: "available", category: networking)

eq7 = Equipment.create!(name: "Arduino Uno", serial_number: "ARD-001", status: "available", category: electronics)
eq8 = Equipment.create!(name: "Multimeter", serial_number: "MUL-007", status: "in_use", category: electronics)

puts "Creating Maintenance Records..."
MaintenanceRecord.create!(description: "Replaced battery", performed_at: 2.days.ago, equipment: eq1)
MaintenanceRecord.create!(description: "Cleaned lenses", performed_at: 1.week.ago, equipment: eq3)
MaintenanceRecord.create!(description: "Calibrated focus", performed_at: 1.day.ago, equipment: eq3)
MaintenanceRecord.create!(description: "Updated firmware", performed_at: 3.days.ago, equipment: eq5)
MaintenanceRecord.create!(description: "Replaced faulty port", performed_at: 1.month.ago, equipment: eq5)

puts "Seed complete! Database populated."
