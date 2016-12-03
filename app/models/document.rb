class Document < ActiveRecord::Base
    mount_uploader :document, FileUploader
end
