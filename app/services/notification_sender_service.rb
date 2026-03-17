class NotificationSenderService
  def self.call(notification)
    puts "\n=== 🚀 INICIANDO MOTOR DE ENVÍOS ==="

    strategy_class_name = "NotificationStrategies::#{notification.channel.camelize}Strategy"    

    begin
      # Intentamos instanciar la clase (ej. NotificationStrategies::EmailStrategy)
      strategy = strategy_class_name.constantize.new
      strategy.send_notification(notification)
    rescue NameError => e
      puts '❌ ERROR DE ESTRATEGIA: No se encontró la clase. Verifica los nombres de archivo.'
      puts "Detalle técnico: #{e.message}"
    rescue StandardError => e
      puts "❌ ERROR INESPERADO en el envío: #{e.message}"
    end

    puts "======================================\n"
  end
end
