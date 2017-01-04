class AddAttachmentAudioclipToProfiles < ActiveRecord::Migration[5.0]
  def self.up
    change_table :profiles do |t|
      t.attachment :audioclip 
    end
  end

  def self.down
    remove_attachment :profiles, :audioclip
  end
end
