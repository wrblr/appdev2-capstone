// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Change to true to allow Turbo
Turbo.session.drive = false

// Allow UJS alongside Turbo
import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;
import Rails from "@rails/ujs"
Rails.start();

// Add to application.js or inside a script tag on the show page
document.addEventListener("turbo:load", () => {
  const chatWindow = document.getElementById("group-chat-window");
  if (chatWindow) {
    chatWindow.scrollTop = chatWindow.scrollHeight;
  }
});
