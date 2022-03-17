require 'nokogiri'

# creation of the file.wxs
out_file = File.new("generated.wxs", "w")

def process_dir(current_path, xml)
    return if !File.directory?(current_path) || Dir.empty?(current_path)
    directory_name = current_path.split("/").last
    # insert code here to compute other attributes for Directory node
    xml.Directory(Name: directory_name) do
        Dir.children(current_path).each do |entry| 
            file = "#{current_path}/#{entry}"
            if !File.directory?(file)
                # insert code here to compute other attributes for File node
                xml.File(Name: entry)
                puts "found file named #{entry} at #{current_path}"
            else
                puts "found directory named #{current_path}/#{entry}"
                process_dir("#{current_path}/#{entry}", xml)
            end
        end
    end
end

# set the basic setup do u want in the wxs file
builder = Nokogiri::XML::Builder.new(:encoding => 'windows-1252') do |xml|
        xml.Wix('xmlns' => 'http://schemas.microsoft.com/wix/2006/wi') do
            xml.Product('Name' => 'Foobar 1.0', 'Id' => 'ABCDDCBA-86C7-4D14-AEC0-86416A69ABDE',
            'UpgradeCode' =>'ABCDDCBA-7349-453F-94F6-BCB5110BA4FD',  'Language' => '1033', 'Codepage' => '1252',
            'Version' => '1.0.0', 'Manufacturer' => 'Acme Ltd.') do
              
              xml.Package('Id' => '*', 'Keywords' => 'Installer', 'Description' => "Acme's Foobar 1.0 Installer", 
              'Comments' => 'Foobar is a registered trademark of Acme Ltd.', 'Manufacturer' => 'Acme Ltd.',
              'InstallerVersion' => '100', 'Languages' => '1033', 'Compressed' => 'yes', 'SummaryCodepage' => '1252')
            
              xml.Media('Id' => '1', 'Cabinet' => 'Sample.cab', 'EmbedCab' => 'yes', 'DiskPrompt' => "CD-ROM #1")
            
              xml.Property('Id' => 'DiskPromt', 'Value' => "Acme's Foobar 1.0 Installation [1]")
        
              # here will be the generated arbo
                process_dir(".", xml)

                xml.Feature('Id' => 'Complete', 'Level' => '1') do
                    xml.ComponentRef('Id' => 'MainExecutable')
                end
            end
        end
end

pp builder.to_xml

# end of the creation of the file.wxs
out_file.puts(builder.to_xml)
out_file.close