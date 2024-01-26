# frozen_string_literal: true

module FileHelper
  def file_name_and_extension(name, content_type)
    "#{name}.#{content_type.split('/').last}"
  end

  def file_size_with_unit(bytes)
    units = %w(Bytes KB MB GB)
  
    return "#{bytes} #{units[0]}" if bytes < 1024
    exp = (Math.log(bytes) / Math.log(1024)).to_i
    exp = 3 if exp > 3  # Maximum supported unit is Exabytes
  
    converted_bytes = bytes.to_f / (1024 ** exp)
    "#{converted_bytes.round(2)} #{units[exp]}"
  end
end
