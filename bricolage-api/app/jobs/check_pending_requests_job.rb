class CheckPendingRequestsJob < ApplicationJob
    queue_as :default
  
    def perform
      workers = User.where(role: 'worker')

      Rails.logger.info "Found #{workers.count} workers."
  
      workers.each do |worker|
        # pending_requests = Request.where(worker_id: worker.id, status: 'pending')
        # if pending_requests.any?
            pending_requests = [1,2,3]
          NotificationMailer.pending_requests_notification(worker, pending_requests).deliver_now
        # end
      end
    end
  end
  