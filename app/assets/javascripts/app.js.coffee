window.Application ||= {}
Application.keyboard_navigation_disabled = false
Application.keybindings_disabled = () -> $('#movie_search_input').is(':focus')
Application.disable_keyboard_navigation = () -> Application.keyboard_navigation_disabled = true
Application.enable_keyboard_navigation = () -> Application.keyboard_navigation_disabled = false

jQuery -> $('#movie_search_input').bind 'focus', () => Application.disable_keyboard_navigation()
jQuery -> $('#movie_search_input').bind 'blur', () => Application.enable_keyboard_navigation()
jQuery -> $('#episode_search_input').bind 'focus', () => Application.disable_keyboard_navigation()
jQuery -> $('#episode_search_input').bind 'blur', () => Application.enable_keyboard_navigation()
