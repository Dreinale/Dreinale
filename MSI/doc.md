# install msitools
``sudo apt update``\
``sudo apt install msitools``

# install nokogiri (for the generator of wxs files)
``gem install nokogiri``\
doc: https://apimirror.com/nokogiri/nokogiri/xml/builder

# run a ruby file
``ruby filename.rb``

# run a wxs file
``wixl -v filename.wxs``

we have 3 folders: \
        -arbo (create a wxs file with the arbo, that take all folders+files)\
        -generator (create a wxs file with the basic setup)\
        -Samplefirst (a wxs file withe the real setup but without the environment)

TODO: combine these 3 folder for create a generator with the same setup of SampleFirst.wxs and that ccan take all files with the Gv3.rb.

Sources: \
      -https://wiki.gnome.org/msitools/HowTo/CreateMSI (For the basic setup)\
      -https://www.firegiant.com/wix/tutorial/com-expression-syntax-miscellanea/environmentally-friendly/\
      -https://subscription.packtpub.com/book/web-development/9781784393212/4\
      -https://www.youtube.com/watch?v=-wyUxQux7xY\
      -https://www.mesta-automation.com/create-an-installer-for-c-sharp-with-wix/


## Tuto of a wsx that can take one file
Here is a short wxs file:
```xml
<?xml version='1.0' encoding='windows-1252'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
  <Product Name='Foobar 1.0' Id='ABCDDCBA-86C7-4D14-AEC0-86416A69ABDE' UpgradeCode='ABCDDCBA-7349-453F-94F6-BCB5110BA4FD'
    Language='1033' Codepage='1252' Version='1.0.0' Manufacturer='Acme Ltd.'>

    <Package Id='*' Keywords='Installer' Description="Acme's Foobar 1.0 Installer"
      Comments='Foobar is a registered trademark of Acme Ltd.' Manufacturer='Acme Ltd.'
      InstallerVersion='100' Languages='1033' Compressed='yes' SummaryCodepage='1252' />

    <Media Id='1' Cabinet='Sample.cab' EmbedCab='yes' DiskPrompt="CD-ROM #1" />
    <Property Id='DiskPrompt' Value="Acme's Foobar 1.0 Installation [1]" />

    <Directory Id='TARGETDIR' Name='SourceDir'>
      <Directory Id='ProgramFilesFolder' Name='PFiles'>
        <Directory Id='Acme' Name='Acme'>
          <Directory Id='INSTALLDIR' Name='Foobar 1.0'>

            <Component Id='MainExecutable' Guid='ABCDDCBA-83F1-4F22-985B-FDB3C8ABD471'>
              <File Id='FoobarEXE' Name='FoobarAppl10.exe' DiskId='1' Source='FoobarAppl10.exe' KeyPath='yes'/>
            </Component>

          </Directory>
        </Directory>
      </Directory>
    </Directory>

    <Feature Id='Complete' Level='1'>
      <ComponentRef Id='MainExecutable' />
    </Feature>

  </Product>
</Wix>
```

# create a fake file
``touch FoobarAppl10.exe``

# build
``wixl -v sample.wxs``
```
Loading sample.wxs...
Building sample.msi...
Writing sample.msi...
```
``msiextract -l sample.msi``
```
Program Files/Acme/Foobar 1.0/FoobarAppl10.exe
```
``msidump sample.msi``
```
Exporting table _SummaryInformation...
Exporting table _ForceCodepage...
Exporting table AdminExecuteSequence... 
Exporting table AdvtExecuteSequence...
Exporting table Component...
Exporting table FeatureComponents...
Exporting table CreateFolder...
Exporting table AppSearch...
Exporting table Property...
Exporting table File...
Exporting table ServiceInstall...
Exporting table Error...
Exporting table InstallExecuteSequence...
Exporting table InstallUISequence...
Exporting table RegLocator...
Exporting table Feature...
Exporting table CustomAction...
Exporting table Icon...
Exporting table Upgrade...
Exporting table RemoveFile...
Exporting table Shortcut...
Exporting table Directory...
Exporting table AdminUISequence...
Exporting table Registry...
Exporting table LaunchCondition...
Exporting table Media...
Exporting table Binary...
Exporting table ServiceControl...
Exporting table Signature...
Exporting table MsiFileHash...
```
``cat File.idt``
```
File    Component_      FileName        FileSize        Version Language        Attributes      Sequence
s72     s72     l255    i4      S72     S20     I2      i4
File    File
FoobarEXE       MainExecutable  FoobarAppl10.exe        1                       512     1
```