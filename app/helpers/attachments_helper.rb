module AttachmentsHelper
  class << self
    def image_url(attachment)
      if attachment.attached?
        attachment.variant(resize: "100x100").processed.url(expires_in: 1.hour, disposition: "inline")
      end
    end
  end
end
