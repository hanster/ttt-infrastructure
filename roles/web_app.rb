name 'web_app'
description 'TTT ruby web app'
run_list [
  'recipe[build-essential]',
  'recipe[chruby::system]',
  'recipe[ttt-ruby]'
]

default_attributes({
  "chruby" => {
    "rubies" => {
      "1.9.3-p392" => false,
      "2.2.2" => true
    },
    "default" => "2.2.2"
  }
})

