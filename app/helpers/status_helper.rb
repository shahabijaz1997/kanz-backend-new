module StatusHelper
  class << self
    def colorized_status(status)
      return if status.nil?
      
      if status == :submitted
        "primary"
      elsif status == :approved
        "success"
      elsif status == :rejected
        "danger"
      elsif status == :verified
        "info"
      elsif status == :reopened
        "warning"
      else
        "secondary"
      end
    end
  end
end
