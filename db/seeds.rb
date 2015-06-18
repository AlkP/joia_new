# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(name: "AlkP", admin: true, email: "apasenko@gmail.com",password: "qw",password_confirmation: "qw");
User.create(name: "joia.developer", admin: true, email: "joia.developer@gmail.com",password: "qw",password_confirmation: "qw");

Type.create(name: "OnTrade", name_eng: "OnTrade");
Type.create(name: "OffTrade", name_eng: "OffTrade");
Type.create(name: "Moscow", name_eng: "Moscow");