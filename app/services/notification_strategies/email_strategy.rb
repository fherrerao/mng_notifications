module NotificationStrategies
  class EmailStrategy
    def send_notification(notification)
      if notification.recipient.blank?
        puts '⚠️ FALLO: El destinatario está en blanco.'
        return
      end

      template = "<h1>#{notification.title}</h1><p>#{notification.content}</p>"
      puts "✅ ÉXITO: EMAIL ENVIADO a #{notification.recipient} | Template: #{template}"
    end
  end
end
