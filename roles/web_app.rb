name 'web_app'
description 'TTT ruby web app'
run_list [
  'recipe[build-essential]',
  'recipe[ruby_build]',
  'recipe[ttt-ruby]'
]

default_attributes({
  'languages' => {
    'ruby' => {
      'default_version' => '2.2.2'
    }
  }
})

