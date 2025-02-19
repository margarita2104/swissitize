# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'nav_toggle', to: 'nav_toggle.js'
pin 'add_more_cards', to: 'add_more_cards.js'
pin 'card_switch', to: 'card_switch.js'
pin 'resize_textarea', to: 'resize_textarea.js'
pin 'toggle_visibility', to: 'toggle_visibility.js'
pin 'languages', to: 'languages.js'
