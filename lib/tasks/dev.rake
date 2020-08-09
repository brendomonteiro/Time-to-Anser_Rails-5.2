namespace :dev do

  Password_Usada = 123456


  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Criando o Administrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Criando Administradores extras...") { %x(rails dev:add_admin_extra) }
      show_spinner("Criando o Usuário padrão...") { %x(rails dev:add_default_user) }
      # show_spinner("xxxxxxxx...") { %x(rails dev:xxxxxxx) }
    else
    puts "Você não está em ambiente de desenvolvimento!"
    end
  end

   desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
  10.times do |i|
  Admin.create!(
    email: 'admin@admin.com',
    password: Password_Usada,
    password_confirmation: Password_Usada
    )
    end   
  end
  
  desc "Adiciona administradores extras"
  task add_admin_extra: :environment do
    10.times do |i|
    Admin.create!(
    email:  Faker::Internet.email,
    password: Password_Usada,
    password_confirmation: Password_Usada
    )
  end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: Password_Usada,
    password_confirmation: Password_Usada
    )
  end


  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end