class AddAttachmentAudioclip3ToProfiles < ActiveRecord::Migration[5.0]
  	def self.up
    change_table :profiles do |t|
      t.attachment :audioclip3 
    end
  end

  def self.down
    remove_attachment :profiles, :audioclip3
  end
end
