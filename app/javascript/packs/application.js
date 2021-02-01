import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "trix"
import "@rails/actiontext"
import "controllers"

import "./rich_text"

Rails.start()
Turbolinks.start()
ActiveStorage.start()