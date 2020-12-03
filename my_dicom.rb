require 'dicom'
# require 'zenity'
require 'pry'
require 'rmagick'
include Magick

# i dont understand this wrapper.
# z = Zenity::file-selection(:title => 'Wybierz plik DICOM')

# Choose DICOM file to read and anonymize (copy and modify in current folder)
if false
  dicom = `zenity --file-selection --title="Wybierz plik DICOM"`
  dcm = DICOM::DObject.read(dicom.chop!)
  dcm.anonymize
  dcm.write(dicom.split('/')[-1].sub('.dcm','_an.dcm'))
end

# Choose folder with DICOM files for anonymization, first copy all with cp command
if false
  dir_dicom = `zenity --file-selection --title="Wybierz folder z plikami DICOM" --directory`
  system('cp -r "' + dir_dicom.chop! + '" ./')

  ann = DICOM::Anonymizer.new # default settings
  ann.anonymize_path(dir_dicom.split('/')[-1])
end

# copy code from tutorial
if false
  # Load the ruby-dicom library:
  require 'dicom'
  # Load an anonymization instance (and specifying an audit trail file):
  a = DICOM::Anonymizer.new(audit_trail: 'audit_trail.txt')
  # Request private data element removal:
  a.delete_private = true
  # In addition to the default selection of tags to be anonymized, we would like to add "Manufacturer" as well:
  a.set_tag('0008,0070', :value => 'Manufacturer', :enum => true)
  # Lets leave out "Institution Name" from the anonymization process:
  a.remove_tag('0008,0080')
  # Select the enumeration feature:
  a.enumeration = true
  # Avoid overwriting the original files by storing the anonymized files in a separate folder from the original files:
  a.write_path = 'C:/dicom/source'
  # Run the actual anonymization:
  a.anonymize_path('C:/dicom/destination')
end

if true
  while true
    dicom_dir = `zenity --file-selection --title="Wybierz plik DICOM" --save`
    dicom = DICOM::DObject.read(dicom_dir.chop!)
    dicom.image.normalize.display
    # image = dicom.image.normalize
    # image.write("dicom.jpg")
    # `eog "dicom.jpg"`
  end
end

if false
  # Load file and image:
  dicom_dir = `zenity --file-selection --title="Wybierz plik DICOM" --save`
  dcm = DICOM::DObject.read dicom_dir.chop!
  # You might (or might not) want to normalize the gray scale:
  image = dcm.image.normalize
  # Create an array of 'black' rectangles:
  rectangles = Array.new
  rectangles << [0,0,300,100]
  rectangles << [411,0,511,100]
  rectangles << [0,380,100,511]
  rectangles << [411,390,511,511]
  rectangles << [0,420,511,511]
  # Paste black rectangles on top of image:
  rectangles.each do |r|
    erase = Draw.new
    erase.fill "Black"
    erase.rectangle r[0], r[1], r[2], r[3]
    erase.draw(image)
  end
  # Insert annotations:
  text = Draw.new
  text.fill = 'White'
  text.pointsize = 14
  text.annotate(image, 0, 0, 10, 30, "Anonymized by:")
  t = Time.now
  text.annotate(image, 0, 0, 10, 45, t.strftime("Processed %m/%d/%Y"))
  text.font_style = ItalicStyle
  text.annotate(image, 0, 0, 130, 30, "The Cool Admin")
  # Insert pixel data back into the DICOM object and write to file:
  dcm.image = image
  dcm.write("/home/dicom/anonymous.dcm")
end