import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "controllers"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require.context('../images', true)
require("stylesheets/page.scss")
