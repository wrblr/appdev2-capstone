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

// To scroll group chat to bottom after each new post:
document.addEventListener("turbo:load", () => {
  const chatWindow = document.getElementById("group-chat-window");
  if (chatWindow) {
    chatWindow.scrollTop = chatWindow.scrollHeight;
  }
});

// To scroll group chat to bottom after each new post:
document.addEventListener("turbo:load", () => {
  const chatWindow = document.getElementById("private-chat-window");
  if (chatWindow) {
    chatWindow.scrollTop = chatWindow.scrollHeight;
  }
});
