class AddAttachmentAudioclip2ToProfiles < ActiveRecord::Migration[5.0]
  	def self.up
    change_table :profiles do |t|
      t.attachment :audioclip2 
    end
  end

  def self.down
    remove_attachment :profiles, :audioclip2
  end
end
