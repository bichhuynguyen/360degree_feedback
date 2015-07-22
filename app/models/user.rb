class User < ActiveRecord::Base
  belongs_to :team
  belongs_to :role
  has_many :versions
  accepts_nested_attributes_for :versions, allow_destroy: true, reject_if: :all_blank
  

  # attr_accesible :version, :comment, :versions_attributes 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :cv,
                    :url  => "/CVs/:id/:basename.:extension",
                    :path => ":rails_root/public/CVs/:id/:basename.:extension"

  # validates_attachment_presence :file
  validates_attachment_size :cv, 
                            :less_than => 300.megabytes
  validates_attachment_content_type :cv, 
                                    :content_type => ['application/pdf', 'application/msword', 'text/plain'],
                                    :message => "Only PDF, WORD or TEXT files are allowed."

 has_attached_file :avatar, styles: {large: "600x600>", medium: "300x300>", thumb: "150x150#"},
                   :url  => "/image/:id/:basename.:extension",
                   :path => ":rails_root/public/image/:id/:basename.:extension"
 validates_attachment_content_type :avatar, content_type: /\Aimage/
  # def self.search(search)
  #   where('user_code LIKE ? || username LIKE ? || email LIKE ? || phone LIKE ?', 
  #          "%#{search}%" , "%#{search}%", "%#{search}%", "%#{search}%")
  # end  
  # require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by_id(row["id"]) || new
    # user.attributes = row.to_hash.slice(*accessible_attributes)
      user.save
    end
  end

  def self.import(file)
    # array_user_code = []
    spreadsheet = open_spreadsheet(file)
    header =  spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # array_user_code = find_by(User_code: row["user_code"])
      # array_user_code << spreadsheet.row(i).user_code
      # array_user_code.select{|e| array_user_code.count(e) > 1}.uniq
      
      # alert (array_user_code)
      user = find_by_id(row["id"]) || new
      user.attributes = row.to_hash.slice(*row.to_hash.keys)
      # user.skip_confirmation!
      # user.attributes = row.to_hash.slice(*accessible_attributes)
      user.save
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, file_warning: :ignore)
    when '.xls' then Roo::Excel.new(file.path, file_warning: :ignore)
    # when '.xlsx' then Excelx.new(file.path, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  
end
