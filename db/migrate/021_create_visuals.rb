class CreateVisuals < ActiveRecord::Migration
  def self.up
    create_table :visuals do |t|
      t.column :listing_id,  :integer
      t.column :parent_id,  :integer
      t.column :content_type, :string
      t.column :filename, :string    
      t.column :thumbnail, :string 
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
      t.column :comment, :string
      t.column :visual_type_id, :integer
    end
    
    add_column :attribute_values, :description, :string
    add_column :attribute_values, :type, :string
    
    AttributeValue
    
    VisualType.create (:name=>"photo", :description=>"photo")
    VisualType.create (:name=>"floor plan", :description=>"photo")
    VisualType.create (:name=>"video", :description=>"video")
    VisualType.create (:name=>"walkthrough", :description=>"walkthrough")
    
  end

  def self.down
    drop_table :visuals
  end
end
