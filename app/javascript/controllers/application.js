import { Application } from "@hotwired/stimulus"
import { start } from "@hotwired/turbo"
import Rails from "@rails/ujs"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Start Turbo
start()

// Start Rails UJS
Rails.start()
