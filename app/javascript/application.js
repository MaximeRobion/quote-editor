// Entry point for the build script in your package.json
import "./controllers"
import "@hotwired/turbo-rails"

// The two following lines disable Turbo on the whole application
Turbo.session.drive = false