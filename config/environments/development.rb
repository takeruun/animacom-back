require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :redis_cache_store, {
      driver: :hiredis,
      url: ENV['REDIS_URL'],
      expires_in: (ENV['REDIS_EXPIRES_IN_MINUTES'] || 5).to_i.minutes,
      connect_timeout: (ENV['REDIS_CONNECT_TIMEOUT_SECONDS'] || 1.0).to_f,
      read_timeout: (ENV['REDIS_READ_TIMEOUT_SECONDS'] || 0.5).to_f,
      write_timeout: (ENV['REDIS_WRITE_TIMEOUT_SECONDS'] || 0.5).to_f,
      reconnect_attempts: (ENV['REDIS_RECONNECT_ATTEMPTS'] || 0).to_i,
      reconnect_delay: (ENV['REDIS_RECONNECT_DELAY_SECONDS'] || 1.0).to_f,
      reconnect_delay_max: (ENV['REDIS_RECONNECT_DELAY_MAX_SECONDS'] || 2.0).to_f,
      error_handler: -> (method:, returning:, exception:) {
        error_info = { on: "on cache_store error_handler", error: exception, method: method, returning: returning }
        Rails.logger.error error_info
      },
    }
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
  config.action_cable.allowed_request_origins = ['http://anima-com.jp:3000']

  config.logger = Logger.new(STDOUT)

  Jbuilder.key_format camelize: :lower
end
