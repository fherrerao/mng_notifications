module NotificationStrategies
  class SmsStrategy
    def send_notification(notification)
      safe_content = notification.content.truncate(160)
      Rails.logger.info("SMS ENVIADO | Número: #{notification.recipient} | Fecha: #{Time.current} | Texto: #{safe_content}")
    end
  end
end
