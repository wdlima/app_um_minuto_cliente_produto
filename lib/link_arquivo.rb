module Lib
  module LinkArquivo
    
    def link=(value)
      if value.present?
        @upload_file = value if value.is_a?(ActionDispatch::Http::UploadedFile)
        @upload_file_string = value if value.is_a?(String)
        super
      end
    end

    private

    def delete_file_s3_filter
      delete_file_s3(@upload_file_string, @upload_file, self.link)
    rescue Exception => err
      Rails.logger.error("Configs AWS não encontrada - #{err.message}")
    end

    def upload_file_s3_filter
      upload_file_s3(@upload_file_string, @upload_file, "link")
    rescue Exception => err
      Rails.logger.error("Configs AWS não encontrada - #{err.message}")
    end

    def validate_aws_config_filter
      validate_aws_config(@upload_file_string, @upload_file, "link")
    end

    def validate_image_format_filter
      validate_image_format(@upload_file_string, "link")
    end



    def delete_file_s3(file_string, file, field)
      if file_string.present? || file_string.present?
        AwsService.delete(field) if field.present?
      end
    end

    def upload_file_s3(file_string, file, field)
      if file_string.present? || file.present?
        if file_string.present?
          self.send("#{field}=", AwsService.upload(file_string, file_string.split("/").last))
        elsif file.present?
          if(self.id.present?)
            link_antigo = self.class.find(id).send(field) rescue nil
            AwsService.delete(link_antigo) if link_antigo.present?
          end
          file_path = file.tempfile.path
          name = file.original_filename
          self.send("#{field}=", AwsService.upload(file_path, name))
        else
          if self.id.present?
            file = self.class.find(id).send(field) rescue nil
            self.send("#{field}=", file)
          end
        end
      end
    end

    def validate_aws_config(file_string, file, field)
      if file_string.present? || file.present?
        if AWS_ID.blank?
          self.errors.add(field, "Configs AWS não encontrada")
        end
      end
    end

    def validate_image_format(file_string, field)
      if file_string.present?
        unless file_string.include?(".")
          file_string = "#{file_string}.jpg"
        end

        if file_string.downcase.scan(/(.jpg)|(.gif)|(.png)|(.bmp)|(.jpeg)|(.pdf)|(.xls)|(.csv)|(.xlsx)/).size == 0
          self.errors.add(field, "inválida tipos aceitos (.jpg) (.gif) (.png) (.bmp) (.jpeg) (.pdf) (.xls) (.csv) (.xlsx)")
        end
      end
    end
  end
end