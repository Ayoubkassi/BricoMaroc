class NotificationMailer < ApplicationMailer
    default from: ENV['GMAIL_USERNAME']

    def pending_requests_notification(worker, pending_requests)
        @worker = worker
        @pending_requests = pending_requests
    
        mail(
          to: @worker.email,
          subject: 'You have pending requests'
        )
    end
end 