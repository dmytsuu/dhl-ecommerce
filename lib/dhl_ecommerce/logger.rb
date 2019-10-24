module DhlEcommerce
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    %w[debug info warn error].each do |level|
      define_method(:"log_#{level}") do |message|
        message = "[DhlEcommerce::Client] #{message}"
        logger.send(level, message)
      end
    end
  end
end
