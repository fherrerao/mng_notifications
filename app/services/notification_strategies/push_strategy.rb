module NotificationStrategies
  class PushStrategy
    def send_notification(notification)
      if notification.recipient.blank? || notification.recipient.length < 10
        Rails.logger.error('Token de dispositivo inválido')
        return
      end

      payload = { title: notification.title, body: notification.content }
      Rails.logger.info("PUSH ENVIADO | Token: #{notification.recipient} | Payload: #{payload.to_json} | Estado: OK")
    end
  end
end
