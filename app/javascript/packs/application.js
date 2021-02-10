import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "trix"
import "@rails/actiontext"
import "controllers"

import "./rich_text"

Rails.start()
ActiveStorage.start()

require.context('../images', true)
require("stylesheets/application.scss")
