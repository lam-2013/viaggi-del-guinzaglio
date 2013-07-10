Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'Ij2sZUH5eNimgdvjEp4U9Q', 'sEEmLjk9olD9Cn5JpHwsyDtwH4y0cFAAoTk9XKi2Qg'
  provider :facebook, '137581853113182', '710b13c9ee3c4559e110b6c3577405df', cliente_option: {ssl:{ca_file:"#{Rails.root}/config/cacert.pem"}}
end